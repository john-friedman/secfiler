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


def construct_ncr(rows: list) -> bytes:
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
    root.set("xmlns", "http://www.sec.gov/edgar/ncrfiler")

    _add_if_present(root, "schemaVersion", _first_across_rows(normalized_rows, ["schemaVersion"]) or "X0101")

    header_data = ET.SubElement(root, "headerData")
    _add_if_present(header_data, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]) or "N-CR")

    filer_info = ET.SubElement(header_data, "filerInfo")
    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    filer = ET.SubElement(filer_info, "filer")
    issuer_credentials = ET.SubElement(filer, "issuerCredentials")
    _add_if_present(issuer_credentials, "cik", _first_across_rows(normalized_rows, ["filerCik"]))
    _add_if_present(issuer_credentials, "ccc", _first_across_rows(normalized_rows, ["filerCcc"]))

    _add_if_present(filer_info, "periodOfReport", _first_across_rows(normalized_rows, ["periodOfReport"]))

    form_data = ET.SubElement(root, "formData")

    general_info = ET.SubElement(form_data, "generalInfo")
    _add_if_present(general_info, "reportDate", _first_across_rows(normalized_rows, ["reportDate"]))
    _add_if_present(general_info, "registrantName", _first_across_rows(normalized_rows, ["registrantName"]))
    _add_if_present(general_info, "registrantCik", _first_across_rows(normalized_rows, ["registrantCik"]))
    _add_if_present(general_info, "registrantLei", _first_across_rows(normalized_rows, ["registrantLei"]))
    _add_if_present(general_info, "seriesName", _first_across_rows(normalized_rows, ["seriesName"]))
    _add_if_present(general_info, "seriesId", _first_across_rows(normalized_rows, ["seriesId"]))
    _add_if_present(general_info, "seriesLei", _first_across_rows(normalized_rows, ["seriesLei"]))
    _add_if_present(general_info, "fileNumber", _first_across_rows(normalized_rows, ["fileNumber"]))

    has_liquidity_threshold = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("dateOfDailyAssets", "percentageOfDailyAssets", "percentageOfWeeklyAssets", "factsDescription")
    )
    if has_liquidity_threshold:
        liquidity_threshold_event = ET.SubElement(form_data, "liquidityThresholdEvent")
        _add_if_present(
            liquidity_threshold_event,
            "dateOfDailyAssets",
            _first_across_rows(normalized_rows, ["dateOfDailyAssets"]),
        )
        _add_if_present(
            liquidity_threshold_event,
            "percentageOfWeeklyAssets",
            _first_across_rows(normalized_rows, ["percentageOfWeeklyAssets"]),
        )
        _add_if_present(
            liquidity_threshold_event,
            "percentageOfDailyAssets",
            _first_across_rows(normalized_rows, ["percentageOfDailyAssets"]),
        )
        _add_if_present(
            liquidity_threshold_event,
            "factsDescription",
            _first_across_rows(normalized_rows, ["factsDescription"]),
        )

    has_disclosure = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in (
            "supportPersonName",
            "supportDate",
            "supportDescription",
            "supportAmtDescription",
            "relationshipDescription",
            "contractRestrictionsDesc",
            "termOfSupport",
            "reasonDescription",
        )
    )
    if has_disclosure:
        disclosure = ET.SubElement(form_data, "disclosure")
        _add_if_present(disclosure, "supportDescription", _first_across_rows(normalized_rows, ["supportDescription"]))
        _add_if_present(disclosure, "supportPersonName", _first_across_rows(normalized_rows, ["supportPersonName"]))
        _add_if_present(disclosure, "relationshipDescription", _first_across_rows(normalized_rows, ["relationshipDescription"]))
        _add_if_present(disclosure, "supportDate", _first_across_rows(normalized_rows, ["supportDate"]))
        _add_if_present(disclosure, "supportAmtDescription", _first_across_rows(normalized_rows, ["supportAmtDescription"]))
        _add_if_present(disclosure, "reasonDescription", _first_across_rows(normalized_rows, ["reasonDescription"]))
        _add_if_present(disclosure, "termOfSupport", _first_across_rows(normalized_rows, ["termOfSupport"]))
        _add_if_present(
            disclosure,
            "contractRestrictionsDesc",
            _first_across_rows(normalized_rows, ["contractRestrictionsDesc"]),
        )

    optional_disclosure = _first_across_rows(normalized_rows, ["optionalDisclosure"])
    if optional_disclosure is not None:
        optional_disclosure_parent = ET.SubElement(form_data, "optionalDisclosure")
        _add_if_present(optional_disclosure_parent, "optionalDisclosure", optional_disclosure)

    signature_block = ET.SubElement(form_data, "signatureBlock")
    _add_if_present(signature_block, "name", _first_across_rows(normalized_rows, ["signatureName"]))
    _add_if_present(signature_block, "title", _first_across_rows(normalized_rows, ["signatureTitle"]))
    _add_if_present(signature_block, "signature", _first_across_rows(normalized_rows, ["signature"]))
    _add_if_present(signature_block, "signatureDate", _first_across_rows(normalized_rows, ["signatureDate"]))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
