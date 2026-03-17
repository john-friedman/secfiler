import io
import xml.etree.ElementTree as ET
from ..constants import CREATED_WITH_SECFILER_COMMENT

def _add_created_with_comment(root: ET.Element) -> None:
    root.insert(0, ET.Comment(CREATED_WITH_SECFILER_COMMENT))



def _is_present(value) -> bool:
    if value is None:
        return False
    if isinstance(value, str):
        return bool(value.strip())
    if isinstance(value, (list, tuple, set)):
        return any(_is_present(item) for item in value)
    return True


def _to_text(value) -> str:
    if isinstance(value, bool):
        return "true" if value else "false"
    return str(value)


def _normalize_values(value) -> list[str]:
    if value is None:
        return []
    if isinstance(value, (list, tuple, set)):
        out: list[str] = []
        for item in value:
            out.extend(_normalize_values(item))
        return out

    text = _to_text(value)
    if text == "":
        return [""]

    stripped = text.strip()
    if not stripped:
        return []

    if any(token in text for token in ("|", ";", "\n", "\r")):
        normalized = (
            text.replace("\r\n", "\n")
            .replace("\r", "\n")
            .replace(";", "|")
            .replace("\n", "|")
        )
        return [part.strip() for part in normalized.split("|") if part.strip()]

    return [text]


def _first_in_row(row: dict, aliases: list[str]):
    for alias in aliases:
        value = row.get(alias)
        if _is_present(value):
            return value
    return None


def _first_across_rows(rows: list[dict], aliases: list[str]):
    for row in rows:
        value = _first_in_row(row, aliases)
        if _is_present(value):
            return value
    return None


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _is_present(value):
        ET.SubElement(parent, tag).text = _to_text(value)


def _add_if_defined(parent: ET.Element, tag: str, value) -> None:
    if value is not None:
        ET.SubElement(parent, tag).text = _to_text(value)


def _record_signature(record: dict, keys: list[str]) -> tuple:
    return tuple((key, "" if record.get(key) is None else _to_text(record.get(key))) for key in keys)


def _collect_records(
    rows: list[dict],
    field_aliases: dict[str, list[str]],
    marker_keys: list[str],
) -> list[dict]:
    records: list[dict] = []
    seen = set()

    for row in rows:
        if not any(_is_present(row.get(key)) for key in marker_keys):
            continue

        value_lists: dict[str, list[str]] = {}
        max_items = 0
        for field_name, aliases in field_aliases.items():
            value = _first_in_row(row, aliases)
            normalized = _normalize_values(value)
            value_lists[field_name] = normalized
            max_items = max(max_items, len(normalized))

        if max_items == 0:
            continue

        for index in range(max_items):
            record = {}
            for field_name, normalized in value_lists.items():
                if not normalized:
                    record[field_name] = None
                elif len(normalized) == 1:
                    record[field_name] = normalized[0]
                elif index < len(normalized):
                    record[field_name] = normalized[index]
                else:
                    record[field_name] = None

            if not any(_is_present(value) for value in record.values()):
                continue

            signature = _record_signature(record, sorted(record))
            if signature in seen:
                continue
            seen.add(signature)
            records.append(record)

    return records


def construct_schedule13d(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/schedule13D")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_data = ET.SubElement(root, "headerData")
    _add_if_present(header_data, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]))

    filer_info = ET.SubElement(header_data, "filerInfo")
    filer = ET.SubElement(filer_info, "filer")
    filer_credentials = ET.SubElement(filer, "filerCredentials")
    _add_if_present(filer_credentials, "cik", _first_across_rows(normalized_rows, ["filerCik"]))
    _add_if_present(filer_credentials, "ccc", _first_across_rows(normalized_rows, ["filerCcc"]))
    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    _add_if_present(
        header_data,
        "previousAccessionNumber",
        _first_across_rows(normalized_rows, ["previousAccessionNumber"]),
    )

    form_data = ET.SubElement(root, "formData")

    cover_page_header = ET.SubElement(form_data, "coverPageHeader")
    _add_if_present(cover_page_header, "amendmentNo", _first_across_rows(normalized_rows, ["amendmentNo"]))
    _add_if_present(cover_page_header, "securitiesClassTitle", _first_across_rows(normalized_rows, ["securitiesClassTitle"]))
    _add_if_present(cover_page_header, "dateOfEvent", _first_across_rows(normalized_rows, ["dateOfEvent"]))
    _add_if_present(cover_page_header, "previouslyFiledFlag", _first_across_rows(normalized_rows, ["previouslyFiledFlag"]))

    issuer_info = ET.SubElement(cover_page_header, "issuerInfo")
    _add_if_present(issuer_info, "issuerCIK", _first_across_rows(normalized_rows, ["issuerCIK"]))
    _add_if_present(issuer_info, "issuerCUSIP", _first_across_rows(normalized_rows, ["issuerCUSIP"]))
    _add_if_present(issuer_info, "issuerName", _first_across_rows(normalized_rows, ["issuerName"]))

    has_issuer_address = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("issuerStreet1", "issuerStreet2", "issuerCity", "issuerStateOrCountry", "issuerZipCode")
    )
    if has_issuer_address:
        issuer_address = ET.SubElement(issuer_info, "address")
        _add_if_present(issuer_address, "com:street1", _first_across_rows(normalized_rows, ["issuerStreet1"]))
        _add_if_present(issuer_address, "com:street2", _first_across_rows(normalized_rows, ["issuerStreet2"]))
        _add_if_present(issuer_address, "com:city", _first_across_rows(normalized_rows, ["issuerCity"]))
        _add_if_present(
            issuer_address,
            "com:stateOrCountry",
            _first_across_rows(normalized_rows, ["issuerStateOrCountry"]),
        )
        _add_if_present(issuer_address, "com:zipCode", _first_across_rows(normalized_rows, ["issuerZipCode"]))

    authorized_person_records = _collect_records(
        normalized_rows,
        {
            "authorizedPersonName": ["authorizedPersonName"],
            "authorizedPersonPhone": ["authorizedPersonPhone"],
            "authorizedStreet1": ["authorizedStreet1"],
            "authorizedStreet2": ["authorizedStreet2"],
            "authorizedCity": ["authorizedCity"],
            "authorizedStateOrCountry": ["authorizedStateOrCountry"],
            "authorizedZipCode": ["authorizedZipCode"],
        },
        marker_keys=["authorizedPersonName", "authorizedPersonPhone", "authorizedStreet1"],
    )
    if authorized_person_records:
        authorized_persons = ET.SubElement(cover_page_header, "authorizedPersons")
        for record in authorized_person_records:
            notification_info = ET.SubElement(authorized_persons, "notificationInfo")
            _add_if_present(notification_info, "personName", record.get("authorizedPersonName"))
            _add_if_present(notification_info, "personPhoneNum", record.get("authorizedPersonPhone"))

            has_person_address = any(
                _is_present(record.get(field))
                for field in (
                    "authorizedStreet1",
                    "authorizedStreet2",
                    "authorizedCity",
                    "authorizedStateOrCountry",
                    "authorizedZipCode",
                )
            )
            if has_person_address:
                person_address = ET.SubElement(notification_info, "personAddress")
                _add_if_present(person_address, "com:street1", record.get("authorizedStreet1"))
                _add_if_present(person_address, "com:street2", record.get("authorizedStreet2"))
                _add_if_present(person_address, "com:city", record.get("authorizedCity"))
                _add_if_present(person_address, "com:stateOrCountry", record.get("authorizedStateOrCountry"))
                _add_if_present(person_address, "com:zipCode", record.get("authorizedZipCode"))

    reporting_person_records = _collect_records(
        normalized_rows,
        {
            "reportingPersonName": ["reportingPersonName"],
            "reportingPersonCIK": ["reportingPersonCIK"],
            "reportingPersonNoCIK": ["reportingPersonNoCIK"],
            "citizenshipOrOrganization": ["citizenshipOrOrganization"],
            "memberOfGroup": ["memberOfGroup"],
            "fundType": ["fundType"],
            "soleVotingPower": ["soleVotingPower"],
            "sharedVotingPower": ["sharedVotingPower"],
            "soleDispositivePower": ["soleDispositivePower"],
            "sharedDispositivePower": ["sharedDispositivePower"],
            "aggregateAmountOwned": ["aggregateAmountOwned"],
            "isAggregateExcludeShares": ["isAggregateExcludeShares"],
            "percentOfClass": ["percentOfClass"],
            "typeOfReportingPerson": ["typeOfReportingPerson"],
            "legalProceedings": ["legalProceedings"],
            "commentContent": ["commentContent"],
        },
        marker_keys=["reportingPersonName", "reportingPersonCIK", "reportingPersonNoCIK"],
    )
    if reporting_person_records:
        reporting_persons = ET.SubElement(form_data, "reportingPersons")
        for record in reporting_person_records:
            reporting_person_info = ET.SubElement(reporting_persons, "reportingPersonInfo")
            _add_if_present(reporting_person_info, "reportingPersonCIK", record.get("reportingPersonCIK"))
            _add_if_present(reporting_person_info, "reportingPersonNoCIK", record.get("reportingPersonNoCIK"))
            _add_if_present(reporting_person_info, "reportingPersonName", record.get("reportingPersonName"))
            _add_if_present(reporting_person_info, "memberOfGroup", record.get("memberOfGroup"))
            _add_if_present(reporting_person_info, "fundType", record.get("fundType"))
            _add_if_present(reporting_person_info, "legalProceedings", record.get("legalProceedings"))
            _add_if_present(
                reporting_person_info,
                "citizenshipOrOrganization",
                record.get("citizenshipOrOrganization"),
            )
            _add_if_present(reporting_person_info, "soleVotingPower", record.get("soleVotingPower"))
            _add_if_present(reporting_person_info, "sharedVotingPower", record.get("sharedVotingPower"))
            _add_if_present(reporting_person_info, "soleDispositivePower", record.get("soleDispositivePower"))
            _add_if_present(reporting_person_info, "sharedDispositivePower", record.get("sharedDispositivePower"))
            _add_if_present(reporting_person_info, "aggregateAmountOwned", record.get("aggregateAmountOwned"))
            _add_if_present(
                reporting_person_info,
                "isAggregateExcludeShares",
                record.get("isAggregateExcludeShares"),
            )
            _add_if_present(reporting_person_info, "percentOfClass", record.get("percentOfClass"))
            _add_if_present(reporting_person_info, "typeOfReportingPerson", record.get("typeOfReportingPerson"))
            _add_if_present(reporting_person_info, "commentContent", record.get("commentContent"))

    items1to7 = ET.SubElement(form_data, "items1To7")

    item1 = ET.SubElement(items1to7, "item1")
    _add_if_present(item1, "securityTitle", _first_across_rows(normalized_rows, ["item1SecurityTitle"]))
    _add_if_present(item1, "issuerName", _first_across_rows(normalized_rows, ["item1IssuerName"]))

    has_item1_address = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("item1Street1", "item1Street2", "item1City", "item1StateOrCountry", "item1ZipCode")
    )
    if has_item1_address:
        issuer_principal_address = ET.SubElement(item1, "issuerPrincipalAddress")
        _add_if_present(issuer_principal_address, "com:street1", _first_across_rows(normalized_rows, ["item1Street1"]))
        _add_if_present(issuer_principal_address, "com:street2", _first_across_rows(normalized_rows, ["item1Street2"]))
        _add_if_present(issuer_principal_address, "com:city", _first_across_rows(normalized_rows, ["item1City"]))
        _add_if_present(
            issuer_principal_address,
            "com:stateOrCountry",
            _first_across_rows(normalized_rows, ["item1StateOrCountry"]),
        )
        _add_if_present(issuer_principal_address, "com:zipCode", _first_across_rows(normalized_rows, ["item1ZipCode"]))

    _add_if_present(item1, "commentText", _first_across_rows(normalized_rows, ["item1CommentText"]))

    item2 = ET.SubElement(items1to7, "item2")
    _add_if_present(item2, "filingPersonName", _first_across_rows(normalized_rows, ["item2FilingPersonName"]))
    _add_if_present(item2, "principalBusinessAddress", _first_across_rows(normalized_rows, ["item2PrincipalBusinessAddress"]))
    _add_if_present(item2, "principalJob", _first_across_rows(normalized_rows, ["item2PrincipalJob"]))
    _add_if_present(item2, "hasBeenConvicted", _first_across_rows(normalized_rows, ["item2HasBeenConvicted"]))
    _add_if_present(item2, "convictionDescription", _first_across_rows(normalized_rows, ["item2ConvictionDescription"]))
    _add_if_present(item2, "citizenship", _first_across_rows(normalized_rows, ["item2Citizenship"]))

    item3 = ET.SubElement(items1to7, "item3")
    _add_if_present(item3, "fundsSource", _first_across_rows(normalized_rows, ["item3FundsSource"]))

    item4 = ET.SubElement(items1to7, "item4")
    _add_if_present(item4, "transactionPurpose", _first_across_rows(normalized_rows, ["item4TransactionPurpose"]))

    item5 = ET.SubElement(items1to7, "item5")
    _add_if_present(item5, "percentageOfClassSecurities", _first_across_rows(normalized_rows, ["item5PercentageOfClass"]))
    _add_if_present(item5, "numberOfShares", _first_across_rows(normalized_rows, ["item5NumberOfShares"]))
    _add_if_present(item5, "transactionDesc", _first_across_rows(normalized_rows, ["item5TransactionDesc"]))
    _add_if_present(item5, "listOfShareholders", _first_across_rows(normalized_rows, ["item5ListOfShareholders"]))
    _add_if_present(item5, "date5PercentOwnership", _first_across_rows(normalized_rows, ["item5Date5PercentOwnership"]))

    item6 = ET.SubElement(items1to7, "item6")
    _add_if_present(item6, "contractDescription", _first_across_rows(normalized_rows, ["item6ContractDescription"]))

    item7 = ET.SubElement(items1to7, "item7")
    _add_if_present(item7, "filedExhibits", _first_across_rows(normalized_rows, ["item7FiledExhibits"]))

    signature_info = ET.SubElement(form_data, "signatureInfo")
    _add_if_defined(signature_info, "commentText", _first_across_rows(normalized_rows, ["signatureCommentText"]))

    signature_person_records = _collect_records(
        normalized_rows,
        {
            "signatureReportingPerson": ["signatureReportingPerson"],
            "signature": ["signature"],
            "title": ["title"],
            "date": ["date"],
        },
        marker_keys=["signatureReportingPerson", "signature", "date"],
    )
    for record in signature_person_records:
        signature_person = ET.SubElement(signature_info, "signaturePerson")
        _add_if_present(signature_person, "signatureReportingPerson", record.get("signatureReportingPerson"))

        signature_details = ET.SubElement(signature_person, "signatureDetails")
        _add_if_present(signature_details, "signature", record.get("signature"))
        _add_if_present(signature_details, "title", record.get("title"))
        _add_if_present(signature_details, "date", record.get("date"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
