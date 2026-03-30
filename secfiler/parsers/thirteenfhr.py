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
        out = []
        for item in value:
            out.extend(_normalize_values(item))
        return out
    text = _to_text(value)
    if not text.strip():
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


def _record_signature(record: dict) -> tuple:
    return tuple((k, "" if record.get(k) is None else _to_text(record[k])) for k in sorted(record))


def _collect_records(rows: list[dict], keys: list[str], marker_keys: list[str]) -> list[dict]:
    records = []
    seen = set()
    for row in rows:
        if not any(_is_present(row.get(k)) for k in marker_keys):
            continue

        lists = {}
        max_items = 0
        for key in keys:
            vals = _normalize_values(row.get(key))
            lists[key] = vals
            max_items = max(max_items, len(vals))
        if max_items == 0:
            continue

        for idx in range(max_items):
            record = {}
            for key, vals in lists.items():
                if not vals:
                    record[key] = None
                elif len(vals) == 1:
                    record[key] = vals[0]
                elif idx < len(vals):
                    record[key] = vals[idx]
                else:
                    record[key] = None
            sig = _record_signature(record)
            if sig in seen:
                continue
            seen.add(sig)
            records.append(record)
    return records


def construct_13fhr(rows: list) -> bytes:
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
    root.set("xmlns", "http://www.sec.gov/edgar/thirteenffiler")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")
    root.set("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance")

    _add_if_present(root, "schemaVersion", _first_across_rows(normalized_rows, ["schemaVersion"]) or "X0202")

    header_data = ET.SubElement(root, "headerData")
    _add_if_present(header_data, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]))

    filer_info = ET.SubElement(header_data, "filerInfo")
    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    flags = ET.SubElement(filer_info, "flags")
    _add_if_present(flags, "confirmingCopyFlag", _first_across_rows(normalized_rows, ["confirmingCopyFlag"]))
    _add_if_present(flags, "returnCopyFlag", _first_across_rows(normalized_rows, ["returnCopyFlag"]))
    _add_if_present(flags, "overrideInternetFlag", _first_across_rows(normalized_rows, ["overrideInternetFlag"]))

    filer = ET.SubElement(filer_info, "filer")
    credentials = ET.SubElement(filer, "credentials")
    _add_if_present(credentials, "cik", _first_across_rows(normalized_rows, ["filerCik"]))
    _add_if_present(credentials, "ccc", _first_across_rows(normalized_rows, ["filerCcc"]))
    _add_if_present(filer, "fileNumber", _first_across_rows(normalized_rows, ["fileNumber"]))

    _add_if_present(filer_info, "periodOfReport", _first_across_rows(normalized_rows, ["periodOfReport"]))
    _add_if_present(filer_info, "denovoRequest", _first_across_rows(normalized_rows, ["denovoRequest"]))

    form_data = ET.SubElement(root, "formData")

    cover_page = ET.SubElement(form_data, "coverPage")
    _add_if_present(cover_page, "reportCalendarOrQuarter", _first_across_rows(normalized_rows, ["reportCalendarOrQuarter"]))
    _add_if_present(cover_page, "isAmendment", _first_across_rows(normalized_rows, ["isAmendment"]))
    _add_if_present(cover_page, "amendmentNo", _first_across_rows(normalized_rows, ["amendmentNo"]))

    amendment_fields = ["amendmentType", "confDeniedExpired", "reasonForNonConfidentiality", "dateDeniedExpired", "dateReported"]
    if any(_is_present(_first_across_rows(normalized_rows, [field])) for field in amendment_fields):
        amendment_info = ET.SubElement(cover_page, "amendmentInfo")
        for field in amendment_fields:
            _add_if_present(amendment_info, field, _first_across_rows(normalized_rows, [field]))

    filing_manager = ET.SubElement(cover_page, "filingManager")
    _add_if_present(filing_manager, "name", _first_across_rows(normalized_rows, ["filingManagerName"]))

    has_manager_address = any(_is_present(_first_across_rows(normalized_rows, [f])) for f in ["street1", "street2", "city", "stateOrCountry", "zipCode"])
    if has_manager_address:
        address = ET.SubElement(filing_manager, "address")
        _add_if_present(address, "com:street1", _first_across_rows(normalized_rows, ["street1"]))
        if any("street2" in row for row in normalized_rows):
            _add_if_defined(address, "com:street2", first_row, "street2")
        _add_if_present(address, "com:city", _first_across_rows(normalized_rows, ["city"]))
        _add_if_present(address, "com:stateOrCountry", _first_across_rows(normalized_rows, ["stateOrCountry"]))
        _add_if_present(address, "com:zipCode", _first_across_rows(normalized_rows, ["zipCode"]))

    _add_if_present(cover_page, "reportType", _first_across_rows(normalized_rows, ["reportType"]))
    _add_if_present(cover_page, "form13FFileNumber", _first_across_rows(normalized_rows, ["form13FFileNumber"]))
    _add_if_present(cover_page, "secFileNumber", _first_across_rows(normalized_rows, ["secFileNumber"]))
    _add_if_present(cover_page, "crdNumber", _first_across_rows(normalized_rows, ["crdNumber"]))
    _add_if_present(cover_page, "provideInfoForInstruction5", _first_across_rows(normalized_rows, ["provideInfoForInstruction5"]))
    _add_if_present(cover_page, "additionalInformation", _first_across_rows(normalized_rows, ["additionalInformation"]))

    other_manager_records = _collect_records(
        normalized_rows,
        ["name", "cik", "form13FFileNumber", "secFileNumber", "crdNumber"],
        marker_keys=["name"],
    )
    # OtherManager2 rows are disambiguated by sequenceNumber.
    other_manager_records = [r for r in other_manager_records if not _is_present(r.get("sequenceNumber"))]
    if other_manager_records:
        other_managers_info = ET.SubElement(cover_page, "otherManagersInfo")
        for record in other_manager_records:
            other_manager = ET.SubElement(other_managers_info, "otherManager")
            _add_if_present(other_manager, "name", record.get("name"))
            _add_if_present(other_manager, "cik", record.get("cik"))
            _add_if_present(other_manager, "form13FFileNumber", record.get("form13FFileNumber"))
            _add_if_present(other_manager, "secFileNumber", record.get("secFileNumber"))
            _add_if_present(other_manager, "crdNumber", record.get("crdNumber"))

    signature_block = ET.SubElement(form_data, "signatureBlock")
    _add_if_present(signature_block, "name", _first_across_rows(normalized_rows, ["signatureName"]))
    _add_if_present(signature_block, "title", _first_across_rows(normalized_rows, ["signatureTitle"]))
    _add_if_present(signature_block, "phone", _first_across_rows(normalized_rows, ["signaturePhone"]))
    _add_if_present(signature_block, "signature", _first_across_rows(normalized_rows, ["signature"]))
    _add_if_present(signature_block, "city", _first_across_rows(normalized_rows, ["signatureCity"]))
    _add_if_present(signature_block, "stateOrCountry", _first_across_rows(normalized_rows, ["signatureStateOrCountry"]))
    _add_if_present(signature_block, "signatureDate", _first_across_rows(normalized_rows, ["signatureDate"]))

    summary_page = ET.SubElement(form_data, "summaryPage")
    _add_if_present(summary_page, "otherIncludedManagersCount", _first_across_rows(normalized_rows, ["otherIncludedManagersCount"]))
    _add_if_present(summary_page, "tableEntryTotal", _first_across_rows(normalized_rows, ["tableEntryTotal"]))
    _add_if_present(summary_page, "tableValueTotal", _first_across_rows(normalized_rows, ["tableValueTotal"]))
    _add_if_present(summary_page, "isConfidentialOmitted", _first_across_rows(normalized_rows, ["isConfidentialOmitted"]))

    other_manager2_records = _collect_records(
        normalized_rows,
        ["sequenceNumber", "name", "cik", "form13FFileNumber", "secFileNumber", "crdNumber"],
        marker_keys=["sequenceNumber"],
    )
    if other_manager2_records:
        other_managers2_info = ET.SubElement(summary_page, "otherManagers2Info")
        for record in other_manager2_records:
            other_manager2 = ET.SubElement(other_managers2_info, "otherManager2")
            _add_if_present(other_manager2, "sequenceNumber", record.get("sequenceNumber"))
            other_manager = ET.SubElement(other_manager2, "otherManager")
            _add_if_present(other_manager, "name", record.get("name"))
            _add_if_present(other_manager, "cik", record.get("cik"))
            _add_if_present(other_manager, "form13FFileNumber", record.get("form13FFileNumber"))
            _add_if_present(other_manager, "secFileNumber", record.get("secFileNumber"))
            _add_if_present(other_manager, "crdNumber", record.get("crdNumber"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
