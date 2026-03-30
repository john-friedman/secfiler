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


def _first_across_rows(rows: list[dict], keys: list[str]):
    for row in rows:
        for key in keys:
            value = row.get(key)
            if _is_present(value):
                return value
    return None


def _collect_values(rows: list[dict], keys: list[str]) -> list[str]:
    values = []
    for row in rows:
        for key in keys:
            if key not in row:
                continue
            value = row.get(key)
            if isinstance(value, (list, tuple, set)):
                for item in value:
                    values.extend(_split_values(item))
            else:
                values.extend(_split_values(value, preserve_empty=(key in row)))
    return values


def _split_values(value, preserve_empty: bool = False) -> list[str]:
    if value is None:
        return []

    if isinstance(value, (list, tuple, set)):
        out = []
        for item in value:
            out.extend(_split_values(item, preserve_empty=preserve_empty))
        return out

    text = _to_text(value)
    if not text.strip():
        return [""] if preserve_empty else []

    if any(token in text for token in ("|", ";", "\n", "\r")):
        normalized = (
            text.replace("\r\n", "\n")
            .replace("\r", "\n")
            .replace(";", "|")
            .replace("\n", "|")
        )
        parts = [part.strip() for part in normalized.split("|")]
        if preserve_empty:
            return parts
        return [part for part in parts if part]

    return [text]


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _is_present(value):
        ET.SubElement(parent, tag).text = _to_text(value)


def _add_if_defined(parent: ET.Element, tag: str, row: dict, key: str) -> None:
    if key in row and row.get(key) is not None:
        ET.SubElement(parent, tag).text = _to_text(row.get(key))


def construct_1k(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    first_row = normalized_rows[0]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/rega/onekfiler")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_data = ET.SubElement(root, "headerData")
    _add_if_present(header_data, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]))

    filer_info = ET.SubElement(header_data, "filerInfo")
    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    filer = ET.SubElement(filer_info, "filer")
    issuer_credentials = ET.SubElement(filer, "issuerCredentials")
    _add_if_present(issuer_credentials, "cik", _first_across_rows(normalized_rows, ["filerCik"]))
    _add_if_present(issuer_credentials, "ccc", _first_across_rows(normalized_rows, ["filerCcc"]))
    _add_if_present(filer, "fileNumber", _first_across_rows(normalized_rows, ["fileNumber"]))

    flags = ET.SubElement(filer_info, "flags")
    _add_if_present(flags, "shellCompanyFlag", _first_across_rows(normalized_rows, ["shellCompanyFlag"]))
    if any("confirmingCopyFlag" in row for row in normalized_rows):
        _add_if_defined(flags, "confirmingCopyFlag", first_row, "confirmingCopyFlag")
    _add_if_present(flags, "successorFilingFlag", _first_across_rows(normalized_rows, ["successorFilingFlag"]))
    if any("returnCopyFlag" in row for row in normalized_rows):
        _add_if_defined(flags, "returnCopyFlag", first_row, "returnCopyFlag")
    if any("overrideInternetFlag" in row for row in normalized_rows):
        _add_if_defined(flags, "overrideInternetFlag", first_row, "overrideInternetFlag")

    _add_if_present(filer_info, "reportingPeriod", _first_across_rows(normalized_rows, ["reportingPeriod"]))

    form_data = ET.SubElement(root, "formData")

    item1 = ET.SubElement(form_data, "item1")
    _add_if_present(item1, "formIndication", _first_across_rows(normalized_rows, ["formIndication"]))
    _add_if_present(item1, "fiscalYearEnd", _first_across_rows(normalized_rows, ["fiscalYearEnd"]))
    _add_if_present(item1, "street1", _first_across_rows(normalized_rows, ["street1"]))
    if any("street2" in row for row in normalized_rows):
        _add_if_defined(item1, "street2", first_row, "street2")
    _add_if_present(item1, "city", _first_across_rows(normalized_rows, ["city"]))
    _add_if_present(item1, "stateOrCountry", _first_across_rows(normalized_rows, ["stateOrCountry"]))
    _add_if_present(item1, "zipCode", _first_across_rows(normalized_rows, ["zipCode"]))
    _add_if_present(item1, "phoneNumber", _first_across_rows(normalized_rows, ["phoneNumber"]))

    issued_titles = _collect_values(normalized_rows, ["issuedSecuritiesTitle"])
    if issued_titles:
        for title in issued_titles:
            ET.SubElement(item1, "issuedSecuritiesTitle").text = title
    else:
        _add_if_present(item1, "issuedSecuritiesTitle", _first_across_rows(normalized_rows, ["issuedSecuritiesTitle"]))

    item1_info = ET.SubElement(form_data, "item1Info")
    _add_if_present(item1_info, "issuerName", _first_across_rows(normalized_rows, ["issuerName"]))
    _add_if_present(item1_info, "cik", _first_across_rows(normalized_rows, ["issuerCik"]))
    _add_if_present(
        item1_info,
        "jurisdictionOrganization",
        _first_across_rows(normalized_rows, ["jurisdictionOrganization"]),
    )
    _add_if_present(item1_info, "irsNum", _first_across_rows(normalized_rows, ["irsNum"]))

    item2 = ET.SubElement(form_data, "item2")
    _add_if_present(item2, "regArule257", _first_across_rows(normalized_rows, ["regArule257"]))

    summary_fields = [
        ("commissionFileNumber", "commissionFileNumber"),
        ("offeringQualificationDate", "offeringQualificationDate"),
        ("offeringCommenceDate", "offeringCommenceDate"),
        ("qualifiedSecuritiesSold", "qualifiedSecuritiesSold"),
        ("offeringSecuritiesSold", "offeringSecuritiesSold"),
        ("pricePerSecurity", "pricePerSecurity"),
        ("aggregrateOfferingPrice", "aggregrateOfferingPrice"),
        ("aggregrateOfferingPriceHolders", "aggregrateOfferingPriceHolders"),
        ("underwrittenSpName", "underwrittenSpName"),
        ("underwriterFees", "underwriterFees"),
        ("crdNumberBrokerDealer", "crdNumberBrokerDealer"),
        ("issuerNetProceeds", "issuerNetProceeds"),
        ("clarificationResponses", "clarificationResponses"),
        ("auditorSpName", "auditorSpName"),
        ("auditorFees", "auditorFees"),
        ("legalSpName", "legalSpName"),
        ("legalFees", "legalFees"),
        ("salesCommissionsSpName", "salesCommissionsSpName"),
        ("salesCommissionsFee", "salesCommissionsFee"),
        ("findersSpName", "findersSpName"),
        ("findersFees", "findersFees"),
        ("promoterSpName", "promoterSpName"),
        ("promotersFees", "promotersFees"),
        ("blueSkySpName", "blueSkySpName"),
        ("blueSkyFees", "blueSkyFees"),
    ]
    has_summary = any(_is_present(_first_across_rows(normalized_rows, [key])) for _, key in summary_fields)
    if has_summary:
        summary_info = ET.SubElement(form_data, "summaryInfo")
        for tag, key in summary_fields:
            _add_if_present(summary_info, tag, _first_across_rows(normalized_rows, [key]))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
