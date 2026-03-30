import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment



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

            signature = tuple((k, "" if record.get(k) is None else _to_text(record.get(k))) for k in sorted(record))
            if signature in seen:
                continue
            seen.add(signature)
            records.append(record)

    return records


def construct_schedule13g(rows: list) -> bytes:
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
    root.set("xmlns", "http://www.sec.gov/edgar/schedule13g")
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
    _add_if_present(
        cover_page_header,
        "securitiesClassTitle",
        _first_across_rows(normalized_rows, ["securitiesClassTitle"]),
    )
    _add_if_present(
        cover_page_header,
        "eventDateRequiresFilingThisStatement",
        _first_across_rows(normalized_rows, ["eventDateRequiresFilingThisStatement"]),
    )

    issuer_info = ET.SubElement(cover_page_header, "issuerInfo")
    _add_if_present(issuer_info, "issuerCik", _first_across_rows(normalized_rows, ["issuerCik"]))
    _add_if_present(issuer_info, "issuerName", _first_across_rows(normalized_rows, ["issuerName"]))
    _add_if_present(issuer_info, "issuerCusip", _first_across_rows(normalized_rows, ["issuerCusip"]))

    has_issuer_address = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("issuerStreet1", "issuerStreet2", "issuerCity", "issuerStateOrCountry", "issuerZipCode")
    )
    if has_issuer_address:
        issuer_principal_address = ET.SubElement(issuer_info, "issuerPrincipalExecutiveOfficeAddress")
        _add_if_present(
            issuer_principal_address,
            "com:street1",
            _first_across_rows(normalized_rows, ["issuerStreet1"]),
        )
        _add_if_present(
            issuer_principal_address,
            "com:street2",
            _first_across_rows(normalized_rows, ["issuerStreet2"]),
        )
        _add_if_present(
            issuer_principal_address,
            "com:city",
            _first_across_rows(normalized_rows, ["issuerCity"]),
        )
        _add_if_present(
            issuer_principal_address,
            "com:stateOrCountry",
            _first_across_rows(normalized_rows, ["issuerStateOrCountry"]),
        )
        _add_if_present(
            issuer_principal_address,
            "com:zipCode",
            _first_across_rows(normalized_rows, ["issuerZipCode"]),
        )

    designate_rules = _normalize_values(
        _first_across_rows(normalized_rows, ["designateRulePursuantThisScheduleFiled"])
    )
    if designate_rules:
        designate_rules_parent = ET.SubElement(cover_page_header, "designateRulesPursuantThisScheduleFiled")
        for value in designate_rules:
            _add_if_present(
                designate_rules_parent,
                "designateRulePursuantThisScheduleFiled",
                value,
            )

    reporting_person_details = ET.SubElement(form_data, "coverPageHeaderReportingPersonDetails")
    _add_if_present(
        reporting_person_details,
        "reportingPersonName",
        _first_across_rows(normalized_rows, ["reportingPersonName"]),
    )
    _add_if_present(
        reporting_person_details,
        "citizenshipOrOrganization",
        _first_across_rows(normalized_rows, ["citizenshipOrOrganization"]),
    )

    beneficially_owned_number_of_shares = ET.SubElement(
        reporting_person_details,
        "reportingPersonBeneficiallyOwnedNumberOfShares",
    )
    _add_if_present(
        beneficially_owned_number_of_shares,
        "soleVotingPower",
        _first_across_rows(normalized_rows, ["soleVotingPower"]),
    )
    _add_if_present(
        beneficially_owned_number_of_shares,
        "sharedVotingPower",
        _first_across_rows(normalized_rows, ["sharedVotingPower"]),
    )
    _add_if_present(
        beneficially_owned_number_of_shares,
        "soleDispositivePower",
        _first_across_rows(normalized_rows, ["soleDispositivePower"]),
    )
    _add_if_present(
        beneficially_owned_number_of_shares,
        "sharedDispositivePower",
        _first_across_rows(normalized_rows, ["sharedDispositivePower"]),
    )

    _add_if_present(
        reporting_person_details,
        "reportingPersonBeneficiallyOwnedAggregateNumberOfShares",
        _first_across_rows(normalized_rows, ["aggregateSharesOwned"]),
    )
    _add_if_present(
        reporting_person_details,
        "aggregateAmountExcludesCertainSharesFlag",
        _first_across_rows(normalized_rows, ["aggregateAmountExcludesCertainSharesFlag"]),
    )
    _add_if_present(
        reporting_person_details,
        "classPercent",
        _first_across_rows(normalized_rows, ["classPercent"]),
    )
    _add_if_present(
        reporting_person_details,
        "memberGroup",
        _first_across_rows(normalized_rows, ["memberGroup"]),
    )
    _add_if_present(
        reporting_person_details,
        "typeOfReportingPerson",
        _first_across_rows(normalized_rows, ["typeOfReportingPerson"]),
    )
    _add_if_defined(
        reporting_person_details,
        "comments",
        _first_across_rows(normalized_rows, ["comments"]),
    )

    items = ET.SubElement(form_data, "items")

    item1 = ET.SubElement(items, "item1")
    _add_if_present(item1, "issuerName", _first_across_rows(normalized_rows, ["item1IssuerName"]))
    _add_if_present(
        item1,
        "issuerPrincipalExecutiveOfficeAddress",
        _first_across_rows(normalized_rows, ["item1IssuerAddress"]),
    )

    item2 = ET.SubElement(items, "item2")
    _add_if_present(item2, "filingPersonName", _first_across_rows(normalized_rows, ["item2FilingPersonName"]))
    _add_if_present(
        item2,
        "principalBusinessOfficeOrResidenceAddress",
        _first_across_rows(normalized_rows, ["item2PrincipalAddress"]),
    )
    _add_if_present(item2, "citizenship", _first_across_rows(normalized_rows, ["item2Citizenship"]))

    item3 = ET.SubElement(items, "item3")
    _add_if_present(item3, "notApplicableFlag", _first_across_rows(normalized_rows, ["item3NotApplicable"]))
    _add_if_present(item3, "typeOfPersonFiling", _first_across_rows(normalized_rows, ["item3TypeOfPersonFiling"]))
    _add_if_present(
        item3,
        "otherTypeOfPersonFiling",
        _first_across_rows(normalized_rows, ["item3OtherTypeOfPersonFiling"]),
    )

    item4 = ET.SubElement(items, "item4")
    _add_if_present(
        item4,
        "amountBeneficiallyOwned",
        _first_across_rows(normalized_rows, ["item4AmountBeneficiallyOwned"]),
    )
    _add_if_present(item4, "classPercent", _first_across_rows(normalized_rows, ["item4ClassPercent"]))

    number_of_shares_person_has = ET.SubElement(item4, "numberOfSharesPersonHas")
    _add_if_present(
        number_of_shares_person_has,
        "solePowerOrDirectToVote",
        _first_across_rows(normalized_rows, ["item4SoleVotingPower"]),
    )
    _add_if_present(
        number_of_shares_person_has,
        "sharedPowerOrDirectToVote",
        _first_across_rows(normalized_rows, ["item4SharedVotingPower"]),
    )
    _add_if_present(
        number_of_shares_person_has,
        "solePowerOrDirectToDispose",
        _first_across_rows(normalized_rows, ["item4SoleDispositivePower"]),
    )
    _add_if_present(
        number_of_shares_person_has,
        "sharedPowerOrDirectToDispose",
        _first_across_rows(normalized_rows, ["item4SharedDispositivePower"]),
    )

    item5 = ET.SubElement(items, "item5")
    _add_if_present(item5, "notApplicableFlag", _first_across_rows(normalized_rows, ["item5NotApplicable"]))
    _add_if_present(
        item5,
        "classOwnership5PercentOrLess",
        _first_across_rows(normalized_rows, ["item5ClassOwnership5PercentOrLess"]),
    )

    item6 = ET.SubElement(items, "item6")
    _add_if_present(item6, "notApplicableFlag", _first_across_rows(normalized_rows, ["item6NotApplicable"]))
    _add_if_present(
        item6,
        "ownershipMoreThan5PercentOnBehalfOfAnotherPerson",
        _first_across_rows(normalized_rows, ["item6OwnershipMoreThan5Percent"]),
    )

    item7 = ET.SubElement(items, "item7")
    _add_if_present(item7, "notApplicableFlag", _first_across_rows(normalized_rows, ["item7NotApplicable"]))
    _add_if_present(
        item7,
        "subsidiaryIdentificationAndClassification",
        _first_across_rows(normalized_rows, ["item7SubsidiaryIdentification"]),
    )

    item8 = ET.SubElement(items, "item8")
    _add_if_present(item8, "notApplicableFlag", _first_across_rows(normalized_rows, ["item8NotApplicable"]))
    _add_if_present(
        item8,
        "identificationAndClassificationOfGroupMembers",
        _first_across_rows(normalized_rows, ["item8GroupMembers"]),
    )

    item9 = ET.SubElement(items, "item9")
    _add_if_present(item9, "notApplicableFlag", _first_across_rows(normalized_rows, ["item9NotApplicable"]))
    _add_if_present(
        item9,
        "groupDissolutionNotice",
        _first_across_rows(normalized_rows, ["item9GroupDissolutionNotice"]),
    )

    item10 = ET.SubElement(items, "item10")
    _add_if_present(item10, "notApplicableFlag", _first_across_rows(normalized_rows, ["item10NotApplicable"]))
    _add_if_present(item10, "certifications", _first_across_rows(normalized_rows, ["item10Certifications"]))

    signature_information = ET.SubElement(form_data, "signatureInformation")
    _add_if_present(
        signature_information,
        "reportingPersonName",
        _first_across_rows(normalized_rows, ["signatureReportingPersonName"]),
    )
    signature_details = ET.SubElement(signature_information, "signatureDetails")
    _add_if_present(signature_details, "signature", _first_across_rows(normalized_rows, ["signature"]))
    _add_if_present(signature_details, "title", _first_across_rows(normalized_rows, ["signatureTitle"]))
    _add_if_present(signature_details, "date", _first_across_rows(normalized_rows, ["signatureDate"]))

    _add_if_defined(form_data, "signatureComments", _first_across_rows(normalized_rows, ["signatureComments"]))
    _add_if_defined(form_data, "exhibitInfo", _first_across_rows(normalized_rows, ["exhibitInfo"]))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
