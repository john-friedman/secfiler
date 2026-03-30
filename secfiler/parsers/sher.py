import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment



DAY_ORDER = [
    "sunday",
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
]

FIELD_NAMES = [
    "saleDate",
    "cusip",
    "nameOfIssuer",
    "shortStartPosition",
    "shortEndPosition",
]

DAY_INDICATOR_KEYS = [
    "table",
    "tableName",
    "sourceTable",
    "_table",
    "section",
    "mapping",
    "group",
    "recordType",
    "rowType",
]


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


def _normalize_token(value: str) -> str:
    return "".join(ch for ch in value.lower() if ch.isalnum())


def _normalize_row(row) -> dict:
    if isinstance(row, dict) or hasattr(row, "get"):
        return row
    return dict(row)


def _normalized_row_key_map(row: dict) -> dict[str, str]:
    normalized = {}
    for key in row.keys():
        normalized[_normalize_token(str(key))] = key
    return normalized


def _find_day_in_text(value: str):
    normalized_text = _normalize_token(value)
    for day in DAY_ORDER:
        day_norm = _normalize_token(day)
        if day_norm and day_norm in normalized_text:
            return day
    return None


def _detect_row_day(row: dict):
    for key in DAY_INDICATOR_KEYS:
        value = row.get(key)
        if not _is_present(value):
            continue
        day = _find_day_in_text(_to_text(value))
        if day:
            return day

    for key in row.keys():
        day = _find_day_in_text(str(key))
        if day:
            return day

    return None


def _candidate_norm_keys_for_field(day: str, field_name: str, allow_generic: bool) -> list[str]:
    day_norm = _normalize_token(day)
    field_norm = _normalize_token(field_name)

    candidates = [
        f"{day_norm}{field_norm}",
        f"{day_norm}data{field_norm}",
        f"sher{day_norm}{field_norm}",
        f"sher{day_norm}data{field_norm}",
    ]
    if allow_generic:
        candidates.insert(0, field_norm)
    return candidates


def _extract_field_value(
    row: dict,
    normalized_key_map: dict[str, str],
    day: str,
    field_name: str,
    allow_generic: bool,
):
    for norm_key in _candidate_norm_keys_for_field(day, field_name, allow_generic):
        raw_key = normalized_key_map.get(norm_key)
        if raw_key is None:
            continue
        value = row.get(raw_key)
        if _is_present(value):
            return value

    field_norm = _normalize_token(field_name)
    day_norm = _normalize_token(day)
    for norm_key, raw_key in normalized_key_map.items():
        if not norm_key.endswith(field_norm):
            continue
        if day_norm not in norm_key:
            continue
        value = row.get(raw_key)
        if _is_present(value):
            return value

    return None


def _extract_record_for_day(row: dict, day: str, allow_generic: bool):
    normalized_key_map = _normalized_row_key_map(row)
    record = {}
    for field_name in FIELD_NAMES:
        record[field_name] = _extract_field_value(
            row=row,
            normalized_key_map=normalized_key_map,
            day=day,
            field_name=field_name,
            allow_generic=allow_generic,
        )

    if any(_is_present(value) for value in record.values()):
        return record
    return None


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


def construct_sher(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            normalized_rows.append(_normalize_row(row))
    else:
        normalized_rows = [{}]

    records_by_day = {day: [] for day in DAY_ORDER}

    for row in normalized_rows:
        row_day = _detect_row_day(row)
        if row_day:
            record = _extract_record_for_day(row=row, day=row_day, allow_generic=True)
            if record:
                records_by_day[row_day].append(record)
            continue

        extracted_any = False
        for day in DAY_ORDER:
            record = _extract_record_for_day(row=row, day=day, allow_generic=False)
            if record:
                records_by_day[day].append(record)
                extracted_any = True

        if extracted_any:
            continue

    root = ET.Element("edgarDocument")
    _add_if_present(root, "cik", _first_across_rows(normalized_rows, ["cik"]))

    short_sale_data_info = ET.SubElement(root, "shortSaleDataInfo")
    for day in DAY_ORDER:
        day_records = records_by_day[day]
        if not day_records:
            continue

        day_data = ET.SubElement(short_sale_data_info, f"{day}Data")
        sale_date = next((record.get("saleDate") for record in day_records if _is_present(record.get("saleDate"))), None)
        _add_if_present(day_data, "saleDate", sale_date)

        for record in day_records:
            has_security_data = any(
                _is_present(record.get(field_name))
                for field_name in ("cusip", "nameOfIssuer", "shortStartPosition", "shortEndPosition")
            )
            if not has_security_data:
                continue

            short_sale_data_list = ET.SubElement(day_data, "shortSaleDataList")
            _add_if_present(short_sale_data_list, "cusip", record.get("cusip"))
            _add_if_present(short_sale_data_list, "nameOfIssuer", record.get("nameOfIssuer"))
            _add_if_present(short_sale_data_list, "shortStartPosition", record.get("shortStartPosition"))
            _add_if_present(short_sale_data_list, "shortEndPosition", record.get("shortEndPosition"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
