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


def _pick_first_row(rows: list[dict], marker_keys: list[str]):
    for row in rows:
        if any(_is_present(row.get(key)) for key in marker_keys):
            return row
    return None


def _record_signature(record: dict, keys: list[str]) -> tuple:
    return tuple((key, "" if record.get(key) is None else _to_text(record.get(key))) for key in keys)


def _collect_values(rows: list[dict], aliases: list[str]) -> list[str]:
    values: list[str] = []
    seen = set()
    for row in rows:
        value = _first_in_row(row, aliases)
        if value is None:
            continue
        for item in _normalize_values(value):
            if item in seen:
                continue
            seen.add(item)
            values.append(item)
    return values


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


def construct_d(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    primary_row = _pick_first_row(
        normalized_rows,
        [
            "primaryIssuerCik",
            "primaryIssuerEntityName",
            "issuerPhoneNumber",
            "jurisdictionOfInc",
            "yearOfIncOverFiveYears",
            "yearOfIncValue",
        ],
    ) or normalized_rows[0]
    primary_rows = [
        row
        for row in normalized_rows
        if any(
            key in row
            for key in (
                "primaryIssuerCik",
                "primaryIssuerEntityName",
                "primaryIssuerEntityType",
                "primaryIssuerEntityTypeOtherDesc",
                "issuerPhoneNumber",
                "jurisdictionOfInc",
                "issuerPreviousName",
                "edgarPreviousName",
                "street1",
                "street2",
                "city",
                "stateOrCountry",
                "stateOrCountryDescription",
                "zipCode",
                "yearOfIncWithinFiveYears",
                "yearOfIncOverFiveYears",
                "yearOfIncYetToBeFormed",
                "yearOfIncValue",
            )
        )
    ] or [primary_row]

    root = ET.Element("edgarSubmission")

    _add_if_present(root, "schemaVersion", _first_across_rows(normalized_rows, ["schemaVersion"]) or "X0708")
    _add_if_present(root, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]) or "D")
    _add_if_present(root, "testOrLive", _first_across_rows(normalized_rows, ["testOrLive"]))

    primary_issuer = ET.SubElement(root, "primaryIssuer")
    _add_if_present(primary_issuer, "cik", _first_across_rows(primary_rows, ["primaryIssuerCik"]))
    _add_if_present(primary_issuer, "entityName", _first_across_rows(primary_rows, ["primaryIssuerEntityName"]))

    has_primary_address = any(
        key in primary_row or _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("street1", "street2", "city", "stateOrCountry", "stateOrCountryDescription", "zipCode")
    )
    if has_primary_address:
        issuer_address = ET.SubElement(primary_issuer, "issuerAddress")
        _add_if_present(issuer_address, "street1", _first_across_rows(primary_rows, ["street1"]))
        if "street2" in primary_row:
            _add_if_defined(issuer_address, "street2", primary_row.get("street2"))
        _add_if_present(issuer_address, "city", _first_across_rows(primary_rows, ["city"]))
        _add_if_present(issuer_address, "stateOrCountry", _first_across_rows(primary_rows, ["stateOrCountry"]))
        _add_if_present(
            issuer_address,
            "stateOrCountryDescription",
            _first_across_rows(primary_rows, ["stateOrCountryDescription"]),
        )
        _add_if_present(issuer_address, "zipCode", _first_across_rows(primary_rows, ["zipCode"]))

    _add_if_present(primary_issuer, "issuerPhoneNumber", _first_across_rows(primary_rows, ["issuerPhoneNumber"]))
    _add_if_present(primary_issuer, "jurisdictionOfInc", _first_across_rows(primary_rows, ["jurisdictionOfInc"]))

    issuer_previous_names = _collect_values(primary_rows, ["issuerPreviousName"])
    if issuer_previous_names:
        issuer_previous_name_list = ET.SubElement(primary_issuer, "issuerPreviousNameList")
        for name in issuer_previous_names:
            _add_if_defined(issuer_previous_name_list, "value", name)

    edgar_previous_names = _collect_values(primary_rows, ["edgarPreviousName"])
    if edgar_previous_names:
        edgar_previous_name_list = ET.SubElement(primary_issuer, "edgarPreviousNameList")
        for name in edgar_previous_names:
            _add_if_defined(edgar_previous_name_list, "value", name)

    _add_if_present(primary_issuer, "entityType", _first_across_rows(primary_rows, ["primaryIssuerEntityType"]))
    _add_if_present(
        primary_issuer,
        "entityTypeOtherDesc",
        _first_across_rows(primary_rows, ["primaryIssuerEntityTypeOtherDesc"]),
    )

    has_year_of_inc = any(
        _is_present(_first_across_rows(primary_rows, [key]))
        for key in ("yearOfIncWithinFiveYears", "yearOfIncOverFiveYears", "yearOfIncYetToBeFormed", "yearOfIncValue")
    )
    if has_year_of_inc:
        year_of_inc = ET.SubElement(primary_issuer, "yearOfInc")
        _add_if_present(
            year_of_inc,
            "withinFiveYears",
            _first_across_rows(primary_rows, ["yearOfIncWithinFiveYears"]),
        )
        _add_if_present(
            year_of_inc,
            "overFiveYears",
            _first_across_rows(primary_rows, ["yearOfIncOverFiveYears"]),
        )
        _add_if_present(
            year_of_inc,
            "yetToBeFormed",
            _first_across_rows(primary_rows, ["yearOfIncYetToBeFormed"]),
        )
        _add_if_present(year_of_inc, "value", _first_across_rows(primary_rows, ["yearOfIncValue"]))

    related_person_rows = _collect_records(
        normalized_rows,
        {
            "firstName": ["firstName"],
            "middleName": ["middleName"],
            "lastName": ["lastName"],
            "street1": ["street1"],
            "street2": ["street2"],
            "city": ["city"],
            "stateOrCountry": ["stateOrCountry"],
            "stateOrCountryDescription": ["stateOrCountryDescription"],
            "zipCode": ["zipCode"],
            "relationship": ["relationship"],
            "relationshipClarification": ["relationshipClarification"],
        },
        marker_keys=["firstName", "lastName", "relationship"],
    )
    if related_person_rows:
        grouped_related_persons = []
        grouped_index = {}
        for record in related_person_rows:
            person_sig = _record_signature(
                record,
                [
                    "firstName",
                    "middleName",
                    "lastName",
                    "street1",
                    "street2",
                    "city",
                    "stateOrCountry",
                    "stateOrCountryDescription",
                    "zipCode",
                    "relationshipClarification",
                ],
            )
            if person_sig not in grouped_index:
                grouped_index[person_sig] = len(grouped_related_persons)
                grouped_related_persons.append(
                    {
                        "person": {
                            "firstName": record.get("firstName"),
                            "middleName": record.get("middleName"),
                            "lastName": record.get("lastName"),
                            "street1": record.get("street1"),
                            "street2": record.get("street2"),
                            "city": record.get("city"),
                            "stateOrCountry": record.get("stateOrCountry"),
                            "stateOrCountryDescription": record.get("stateOrCountryDescription"),
                            "zipCode": record.get("zipCode"),
                            "relationshipClarification": record.get("relationshipClarification"),
                        },
                        "relationships": [],
                    }
                )

            grouped = grouped_related_persons[grouped_index[person_sig]]
            relationship = record.get("relationship")
            if _is_present(relationship) and relationship not in grouped["relationships"]:
                grouped["relationships"].append(relationship)

        related_persons_list = ET.SubElement(root, "relatedPersonsList")
        for grouped in grouped_related_persons:
            person = grouped["person"]
            related_person_info = ET.SubElement(related_persons_list, "relatedPersonInfo")

            related_person_name = ET.SubElement(related_person_info, "relatedPersonName")
            _add_if_present(related_person_name, "firstName", person.get("firstName"))
            _add_if_present(related_person_name, "middleName", person.get("middleName"))
            _add_if_present(related_person_name, "lastName", person.get("lastName"))

            has_person_address = any(
                _is_present(person.get(field))
                for field in ("street1", "street2", "city", "stateOrCountry", "stateOrCountryDescription", "zipCode")
            )
            if has_person_address:
                related_person_address = ET.SubElement(related_person_info, "relatedPersonAddress")
                _add_if_present(related_person_address, "street1", person.get("street1"))
                _add_if_defined(related_person_address, "street2", person.get("street2"))
                _add_if_present(related_person_address, "city", person.get("city"))
                _add_if_present(related_person_address, "stateOrCountry", person.get("stateOrCountry"))
                _add_if_present(
                    related_person_address,
                    "stateOrCountryDescription",
                    person.get("stateOrCountryDescription"),
                )
                _add_if_present(related_person_address, "zipCode", person.get("zipCode"))

            relationship_list = ET.SubElement(related_person_info, "relatedPersonRelationshipList")
            for relationship in grouped["relationships"]:
                _add_if_present(relationship_list, "relationship", relationship)

            _add_if_defined(
                related_person_info,
                "relationshipClarification",
                person.get("relationshipClarification"),
            )

    issuer_rows = _collect_records(
        normalized_rows,
        {
            "cik": ["cik"],
            "entityName": ["entityName"],
            "entityType": ["entityType"],
            "entityTypeOtherDesc": ["entityTypeOtherDesc"],
            "issuerPhoneNumber": ["issuerPhoneNumber"],
            "jurisdictionOfInc": ["jurisdictionOfInc"],
            "street1": ["street1"],
            "street2": ["street2"],
            "city": ["city"],
            "stateOrCountry": ["stateOrCountry"],
            "stateOrCountryDescription": ["stateOrCountryDescription"],
            "zipCode": ["zipCode"],
            "yearOfIncWithinFiveYears": ["yearOfIncWithinFiveYears"],
            "yearOfIncOverFiveYears": ["yearOfIncOverFiveYears"],
            "yearOfIncYetToBeFormed": ["yearOfIncYetToBeFormed"],
            "yearOfIncValue": ["yearOfIncValue"],
            "issuerPreviousName": ["issuerPreviousName"],
            "edgarPreviousName": ["edgarPreviousName"],
        },
        marker_keys=["cik", "entityName"],
    )
    if issuer_rows:
        issuer_list = ET.SubElement(root, "issuerList")
        for issuer_record in issuer_rows:
            issuer = ET.SubElement(issuer_list, "issuer")
            _add_if_present(issuer, "cik", issuer_record.get("cik"))
            _add_if_present(issuer, "entityName", issuer_record.get("entityName"))
            _add_if_present(issuer, "entityType", issuer_record.get("entityType"))
            _add_if_present(issuer, "entityTypeOtherDesc", issuer_record.get("entityTypeOtherDesc"))
            _add_if_present(issuer, "issuerPhoneNumber", issuer_record.get("issuerPhoneNumber"))
            _add_if_present(issuer, "jurisdictionOfInc", issuer_record.get("jurisdictionOfInc"))

            has_issuer_address = any(
                _is_present(issuer_record.get(field))
                for field in ("street1", "street2", "city", "stateOrCountry", "stateOrCountryDescription", "zipCode")
            )
            if has_issuer_address:
                issuer_address = ET.SubElement(issuer, "issuerAddress")
                _add_if_present(issuer_address, "street1", issuer_record.get("street1"))
                _add_if_defined(issuer_address, "street2", issuer_record.get("street2"))
                _add_if_present(issuer_address, "city", issuer_record.get("city"))
                _add_if_present(issuer_address, "stateOrCountry", issuer_record.get("stateOrCountry"))
                _add_if_present(
                    issuer_address,
                    "stateOrCountryDescription",
                    issuer_record.get("stateOrCountryDescription"),
                )
                _add_if_present(issuer_address, "zipCode", issuer_record.get("zipCode"))

            if _is_present(issuer_record.get("issuerPreviousName")):
                issuer_previous_name_list = ET.SubElement(issuer, "issuerPreviousNameList")
                _add_if_present(issuer_previous_name_list, "value", issuer_record.get("issuerPreviousName"))
            if _is_present(issuer_record.get("edgarPreviousName")):
                edgar_previous_name_list = ET.SubElement(issuer, "edgarPreviousNameList")
                _add_if_present(edgar_previous_name_list, "value", issuer_record.get("edgarPreviousName"))

            has_issuer_year_of_inc = any(
                _is_present(issuer_record.get(field))
                for field in ("yearOfIncWithinFiveYears", "yearOfIncOverFiveYears", "yearOfIncYetToBeFormed", "yearOfIncValue")
            )
            if has_issuer_year_of_inc:
                year_of_inc = ET.SubElement(issuer, "yearOfInc")
                _add_if_present(year_of_inc, "withinFiveYears", issuer_record.get("yearOfIncWithinFiveYears"))
                _add_if_present(year_of_inc, "overFiveYears", issuer_record.get("yearOfIncOverFiveYears"))
                _add_if_present(year_of_inc, "yetToBeFormed", issuer_record.get("yearOfIncYetToBeFormed"))
                _add_if_present(year_of_inc, "value", issuer_record.get("yearOfIncValue"))

    offering_data = ET.SubElement(root, "offeringData")

    has_industry_group = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("industryGroupType", "investmentFundType", "is40Act")
    )
    if has_industry_group:
        industry_group = ET.SubElement(offering_data, "industryGroup")
        _add_if_present(industry_group, "industryGroupType", _first_across_rows(normalized_rows, ["industryGroupType"]))
        has_investment_fund_info = any(
            _is_present(_first_across_rows(normalized_rows, [key]))
            for key in ("investmentFundType", "is40Act")
        )
        if has_investment_fund_info:
            investment_fund_info = ET.SubElement(industry_group, "investmentFundInfo")
            _add_if_present(
                investment_fund_info,
                "investmentFundType",
                _first_across_rows(normalized_rows, ["investmentFundType"]),
            )
            _add_if_present(investment_fund_info, "is40Act", _first_across_rows(normalized_rows, ["is40Act"]))

    has_issuer_size = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("revenueRange", "aggregateNetAssetValueRange")
    )
    if has_issuer_size:
        issuer_size = ET.SubElement(offering_data, "issuerSize")
        _add_if_present(issuer_size, "revenueRange", _first_across_rows(normalized_rows, ["revenueRange"]))
        _add_if_present(
            issuer_size,
            "aggregateNetAssetValueRange",
            _first_across_rows(normalized_rows, ["aggregateNetAssetValueRange"]),
        )

    federal_exemptions = _collect_values(normalized_rows, ["federalExemptionsItem"])
    if federal_exemptions:
        federal_exemptions_exclusions = ET.SubElement(offering_data, "federalExemptionsExclusions")
        for item in federal_exemptions:
            _add_if_present(federal_exemptions_exclusions, "item", item)

    has_type_of_filing = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("isAmendment", "previousAccessionNumber", "dateOfFirstSale", "dateOfFirstSaleYetToOccur")
    )
    if has_type_of_filing:
        type_of_filing = ET.SubElement(offering_data, "typeOfFiling")
        new_or_amendment = ET.SubElement(type_of_filing, "newOrAmendment")
        _add_if_present(new_or_amendment, "isAmendment", _first_across_rows(normalized_rows, ["isAmendment"]))
        _add_if_present(
            new_or_amendment,
            "previousAccessionNumber",
            _first_across_rows(normalized_rows, ["previousAccessionNumber"]),
        )

        date_of_first_sale = ET.SubElement(type_of_filing, "dateOfFirstSale")
        _add_if_present(date_of_first_sale, "value", _first_across_rows(normalized_rows, ["dateOfFirstSale"]))
        _add_if_present(
            date_of_first_sale,
            "yetToOccur",
            _first_across_rows(normalized_rows, ["dateOfFirstSaleYetToOccur"]),
        )

    more_than_one_year = _first_across_rows(normalized_rows, ["moreThanOneYear"])
    if _is_present(more_than_one_year):
        duration_of_offering = ET.SubElement(offering_data, "durationOfOffering")
        _add_if_present(duration_of_offering, "moreThanOneYear", more_than_one_year)

    has_security_types = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in (
            "isDebtType",
            "isEquityType",
            "isMineralPropertyType",
            "isOptionToAcquireType",
            "isOtherType",
            "isPooledInvestmentFundType",
            "isSecurityToBeAcquiredType",
            "isTenantInCommonType",
            "descriptionOfOtherType",
        )
    )
    if has_security_types:
        types_of_securities_offered = ET.SubElement(offering_data, "typesOfSecuritiesOffered")
        _add_if_present(types_of_securities_offered, "isDebtType", _first_across_rows(normalized_rows, ["isDebtType"]))
        _add_if_present(types_of_securities_offered, "isEquityType", _first_across_rows(normalized_rows, ["isEquityType"]))
        _add_if_present(
            types_of_securities_offered,
            "isMineralPropertyType",
            _first_across_rows(normalized_rows, ["isMineralPropertyType"]),
        )
        _add_if_present(
            types_of_securities_offered,
            "isOptionToAcquireType",
            _first_across_rows(normalized_rows, ["isOptionToAcquireType"]),
        )
        _add_if_present(types_of_securities_offered, "isOtherType", _first_across_rows(normalized_rows, ["isOtherType"]))
        _add_if_present(
            types_of_securities_offered,
            "isPooledInvestmentFundType",
            _first_across_rows(normalized_rows, ["isPooledInvestmentFundType"]),
        )
        _add_if_present(
            types_of_securities_offered,
            "isSecurityToBeAcquiredType",
            _first_across_rows(normalized_rows, ["isSecurityToBeAcquiredType"]),
        )
        _add_if_present(
            types_of_securities_offered,
            "isTenantInCommonType",
            _first_across_rows(normalized_rows, ["isTenantInCommonType"]),
        )
        _add_if_present(
            types_of_securities_offered,
            "descriptionOfOtherType",
            _first_across_rows(normalized_rows, ["descriptionOfOtherType"]),
        )

    has_business_combo = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("isBusinessCombinationTransaction", "businessCombinationClarification")
    )
    if has_business_combo:
        business_combination = ET.SubElement(offering_data, "businessCombinationTransaction")
        _add_if_present(
            business_combination,
            "isBusinessCombinationTransaction",
            _first_across_rows(normalized_rows, ["isBusinessCombinationTransaction"]),
        )
        _add_if_defined(
            business_combination,
            "clarificationOfResponse",
            _first_across_rows(normalized_rows, ["businessCombinationClarification"]),
        )

    _add_if_present(
        offering_data,
        "minimumInvestmentAccepted",
        _first_across_rows(normalized_rows, ["minimumInvestmentAccepted"]),
    )

    sales_compensation_list = ET.SubElement(offering_data, "salesCompensationList")
    recipient_rows = _collect_records(
        normalized_rows,
        {
            "recipientName": ["recipientName"],
            "recipientCRDNumber": ["recipientCRDNumber"],
            "associatedBDName": ["associatedBDName"],
            "associatedBDCRDNumber": ["associatedBDCRDNumber"],
            "street1": ["street1"],
            "street2": ["street2"],
            "city": ["city"],
            "stateOrCountry": ["stateOrCountry"],
            "stateOrCountryDescription": ["stateOrCountryDescription"],
            "zipCode": ["zipCode"],
            "solicitationState": ["solicitationState"],
            "solicitationDescription": ["solicitationDescription"],
            "solicitationValue": ["solicitationValue"],
            "foreignSolicitation": ["foreignSolicitation"],
        },
        marker_keys=["recipientName", "recipientCRDNumber", "associatedBDName", "solicitationState", "solicitationValue"],
    )
    if recipient_rows:
        grouped_recipients = []
        grouped_index = {}
        for record in recipient_rows:
            recipient_sig = _record_signature(
                record,
                [
                    "recipientName",
                    "recipientCRDNumber",
                    "associatedBDName",
                    "associatedBDCRDNumber",
                    "street1",
                    "street2",
                    "city",
                    "stateOrCountry",
                    "stateOrCountryDescription",
                    "zipCode",
                    "foreignSolicitation",
                ],
            )
            if recipient_sig not in grouped_index:
                grouped_index[recipient_sig] = len(grouped_recipients)
                grouped_recipients.append(
                    {
                        "recipient": {
                            "recipientName": record.get("recipientName"),
                            "recipientCRDNumber": record.get("recipientCRDNumber"),
                            "associatedBDName": record.get("associatedBDName"),
                            "associatedBDCRDNumber": record.get("associatedBDCRDNumber"),
                            "street1": record.get("street1"),
                            "street2": record.get("street2"),
                            "city": record.get("city"),
                            "stateOrCountry": record.get("stateOrCountry"),
                            "stateOrCountryDescription": record.get("stateOrCountryDescription"),
                            "zipCode": record.get("zipCode"),
                            "foreignSolicitation": record.get("foreignSolicitation"),
                        },
                        "solicitations": [],
                    }
                )

            grouped = grouped_recipients[grouped_index[recipient_sig]]
            solicitation_entry = {
                "state": record.get("solicitationState"),
                "description": record.get("solicitationDescription"),
                "value": record.get("solicitationValue"),
            }
            if any(_is_present(solicitation_entry[key]) for key in ("state", "description", "value")):
                solicitation_sig = _record_signature(solicitation_entry, ["state", "description", "value"])
                existing = {_record_signature(item, ["state", "description", "value"]) for item in grouped["solicitations"]}
                if solicitation_sig not in existing:
                    grouped["solicitations"].append(solicitation_entry)

        for grouped in grouped_recipients:
            recipient_data = grouped["recipient"]
            recipient = ET.SubElement(sales_compensation_list, "recipient")
            _add_if_present(recipient, "recipientName", recipient_data.get("recipientName"))
            _add_if_present(recipient, "recipientCRDNumber", recipient_data.get("recipientCRDNumber"))
            _add_if_present(recipient, "associatedBDName", recipient_data.get("associatedBDName"))
            _add_if_present(recipient, "associatedBDCRDNumber", recipient_data.get("associatedBDCRDNumber"))

            has_recipient_address = any(
                _is_present(recipient_data.get(field))
                for field in ("street1", "street2", "city", "stateOrCountry", "stateOrCountryDescription", "zipCode")
            )
            if has_recipient_address:
                recipient_address = ET.SubElement(recipient, "recipientAddress")
                _add_if_present(recipient_address, "street1", recipient_data.get("street1"))
                _add_if_defined(recipient_address, "street2", recipient_data.get("street2"))
                _add_if_present(recipient_address, "city", recipient_data.get("city"))
                _add_if_present(recipient_address, "stateOrCountry", recipient_data.get("stateOrCountry"))
                _add_if_present(
                    recipient_address,
                    "stateOrCountryDescription",
                    recipient_data.get("stateOrCountryDescription"),
                )
                _add_if_present(recipient_address, "zipCode", recipient_data.get("zipCode"))

            if grouped["solicitations"]:
                states_list = ET.SubElement(recipient, "statesOfSolicitationList")
                for solicitation in grouped["solicitations"]:
                    _add_if_present(states_list, "state", solicitation.get("state"))
                    _add_if_present(states_list, "description", solicitation.get("description"))
                    _add_if_present(states_list, "value", solicitation.get("value"))

            _add_if_present(recipient, "foreignSolicitation", recipient_data.get("foreignSolicitation"))

    has_offering_sales = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("totalOfferingAmount", "totalAmountSold", "totalRemaining", "offeringSalesClarification")
    )
    if has_offering_sales:
        offering_sales_amounts = ET.SubElement(offering_data, "offeringSalesAmounts")
        _add_if_present(
            offering_sales_amounts,
            "totalOfferingAmount",
            _first_across_rows(normalized_rows, ["totalOfferingAmount"]),
        )
        _add_if_present(offering_sales_amounts, "totalAmountSold", _first_across_rows(normalized_rows, ["totalAmountSold"]))
        _add_if_present(offering_sales_amounts, "totalRemaining", _first_across_rows(normalized_rows, ["totalRemaining"]))
        _add_if_defined(
            offering_sales_amounts,
            "clarificationOfResponse",
            _first_across_rows(normalized_rows, ["offeringSalesClarification"]),
        )

    has_investors = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("hasNonAccreditedInvestors", "numberNonAccreditedInvestors", "totalNumberAlreadyInvested")
    )
    if has_investors:
        investors = ET.SubElement(offering_data, "investors")
        _add_if_present(
            investors,
            "hasNonAccreditedInvestors",
            _first_across_rows(normalized_rows, ["hasNonAccreditedInvestors"]),
        )
        _add_if_present(
            investors,
            "numberNonAccreditedInvestors",
            _first_across_rows(normalized_rows, ["numberNonAccreditedInvestors"]),
        )
        _add_if_present(
            investors,
            "totalNumberAlreadyInvested",
            _first_across_rows(normalized_rows, ["totalNumberAlreadyInvested"]),
        )

    has_sales_commissions = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in (
            "salesCommissionsDollarAmount",
            "salesCommissionsIsEstimate",
            "findersFeeDollarAmount",
            "findersFeeIsEstimate",
            "salesCommissionsClarification",
        )
    )
    if has_sales_commissions:
        sales_commissions_finders_fees = ET.SubElement(offering_data, "salesCommissionsFindersFees")

        sales_commissions = ET.SubElement(sales_commissions_finders_fees, "salesCommissions")
        _add_if_present(
            sales_commissions,
            "dollarAmount",
            _first_across_rows(normalized_rows, ["salesCommissionsDollarAmount"]),
        )
        _add_if_present(
            sales_commissions,
            "isEstimate",
            _first_across_rows(normalized_rows, ["salesCommissionsIsEstimate"]),
        )

        finders_fees = ET.SubElement(sales_commissions_finders_fees, "findersFees")
        _add_if_present(finders_fees, "dollarAmount", _first_across_rows(normalized_rows, ["findersFeeDollarAmount"]))
        _add_if_present(finders_fees, "isEstimate", _first_across_rows(normalized_rows, ["findersFeeIsEstimate"]))

        _add_if_defined(
            sales_commissions_finders_fees,
            "clarificationOfResponse",
            _first_across_rows(normalized_rows, ["salesCommissionsClarification"]),
        )

    has_use_of_proceeds = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("grossProceedsUsed", "grossProceedsIsEstimate", "useOfProceedsClarification")
    )
    if has_use_of_proceeds:
        use_of_proceeds = ET.SubElement(offering_data, "useOfProceeds")
        gross_proceeds_used = ET.SubElement(use_of_proceeds, "grossProceedsUsed")
        _add_if_present(gross_proceeds_used, "dollarAmount", _first_across_rows(normalized_rows, ["grossProceedsUsed"]))
        _add_if_present(
            gross_proceeds_used,
            "isEstimate",
            _first_across_rows(normalized_rows, ["grossProceedsIsEstimate"]),
        )
        _add_if_defined(
            use_of_proceeds,
            "clarificationOfResponse",
            _first_across_rows(normalized_rows, ["useOfProceedsClarification"]),
        )

    signature_block = ET.SubElement(offering_data, "signatureBlock")
    _add_if_present(
        signature_block,
        "authorizedRepresentative",
        _first_across_rows(normalized_rows, ["authorizedRepresentative"]),
    )

    signature_rows = _collect_records(
        normalized_rows,
        {
            "signatureIssuerName": ["signatureIssuerName"],
            "signatureName": ["signatureName"],
            "nameOfSigner": ["nameOfSigner"],
            "signatureTitle": ["signatureTitle"],
            "signatureDate": ["signatureDate"],
        },
        marker_keys=["signatureName", "nameOfSigner", "signatureDate", "signatureIssuerName"],
    )
    for signature_record in signature_rows:
        signature = ET.SubElement(signature_block, "signature")
        _add_if_present(signature, "issuerName", signature_record.get("signatureIssuerName"))
        _add_if_present(signature, "signatureName", signature_record.get("signatureName"))
        _add_if_present(signature, "nameOfSigner", signature_record.get("nameOfSigner"))
        _add_if_present(signature, "signatureTitle", signature_record.get("signatureTitle"))
        _add_if_present(signature, "signatureDate", signature_record.get("signatureDate"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
