import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment



def _is_present(value) -> bool:
    if value is None:
        return False
    if isinstance(value, str):
        return bool(value.strip())
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


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _is_present(value):
        ET.SubElement(parent, tag).text = _to_text(value)


def _add_if_defined(parent: ET.Element, tag: str, row: dict, key: str) -> None:
    if key in row and row.get(key) is not None:
        ET.SubElement(parent, tag).text = _to_text(row.get(key))


def construct_1z(rows: list) -> bytes:
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
    root.set("xmlns", "http://www.sec.gov/edgar/rega/onezfiler")
    root.set("xmlns:ns1", "http://www.sec.gov/edgar/common")

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
    _add_if_present(flags, "confirmingCopyFlag", _first_across_rows(normalized_rows, ["confirmingCopyFlag"]))
    _add_if_present(flags, "successorFilingFlag", _first_across_rows(normalized_rows, ["successorFilingFlag"]))
    _add_if_present(flags, "returnCopyFlag", _first_across_rows(normalized_rows, ["returnCopyFlag"]))
    _add_if_present(flags, "overrideInternetFlag", _first_across_rows(normalized_rows, ["overrideInternetFlag"]))

    form_data = ET.SubElement(root, "formData")

    item1 = ET.SubElement(form_data, "item1")
    _add_if_present(item1, "issuerName", _first_across_rows(normalized_rows, ["issuerName"]))
    _add_if_present(item1, "street1", _first_across_rows(normalized_rows, ["street1"]))
    if any("street2" in row for row in normalized_rows):
        _add_if_defined(item1, "street2", first_row, "street2")
    _add_if_present(item1, "city", _first_across_rows(normalized_rows, ["city"]))
    _add_if_present(item1, "stateOrCountry", _first_across_rows(normalized_rows, ["stateOrCountry"]))
    _add_if_present(item1, "zipCode", _first_across_rows(normalized_rows, ["zipCode"]))
    _add_if_present(item1, "phone", _first_across_rows(normalized_rows, ["phone"]))
    _add_if_present(item1, "commissionFileNumber", _first_across_rows(normalized_rows, ["commissionFileNumber"]))

    summary_fields = [
        "offeringQualificationDate",
        "offeringCommenceDate",
        "offeringSecuritiesQualifiedSold",
        "offeringSecuritiesSold",
        "pricePerSecurity",
        "portionSecuritiesSoldIssuer",
        "portionSecuritiesSoldSecurityholders",
        "underwrittenSpName",
        "underwriterFees",
        "salesCommissionsSpName",
        "salesCommissionsFee",
        "findersSpName",
        "findersFees",
        "auditorSpName",
        "auditorFees",
        "legalSpName",
        "legalFees",
        "promoterSpName",
        "promotersFees",
        "blueSkySpName",
        "blueSkyFees",
        "crdNumberBrokerDealer",
        "issuerNetProceeds",
        "clarificationResponses",
    ]
    has_summary = any(_is_present(_first_across_rows(normalized_rows, [field])) for field in summary_fields)
    if has_summary:
        summary = ET.SubElement(form_data, "summaryInfoOffering")
        for field in summary_fields:
            _add_if_present(summary, field, _first_across_rows(normalized_rows, [field]))

    certification = ET.SubElement(form_data, "certificationSuspension")
    _add_if_present(certification, "securitiesClassTitle", _first_across_rows(normalized_rows, ["securitiesClassTitle"]))
    _add_if_present(certification, "certificationFileNumber", _first_across_rows(normalized_rows, ["certificationFileNumber"]))
    _add_if_present(certification, "approxRecordHolders", _first_across_rows(normalized_rows, ["approxRecordHolders"]))

    signature_tab = ET.SubElement(form_data, "signatureTab")
    _add_if_present(signature_tab, "cik", _first_across_rows(normalized_rows, ["signatureCik"]))
    _add_if_present(signature_tab, "regulationIssuerName1", _first_across_rows(normalized_rows, ["regulationIssuerName1"]))
    _add_if_present(signature_tab, "regulationIssuerName2", _first_across_rows(normalized_rows, ["regulationIssuerName2"]))
    _add_if_present(signature_tab, "signatureBy", _first_across_rows(normalized_rows, ["signatureBy"]))
    _add_if_present(signature_tab, "date", _first_across_rows(normalized_rows, ["signatureDate"]))
    _add_if_present(signature_tab, "title", _first_across_rows(normalized_rows, ["signatureTitle"]))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
