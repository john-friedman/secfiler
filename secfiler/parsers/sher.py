import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _is_present


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
    "cusip",
    "nameOfIssuer",
    "shortStartPosition",
    "shortEndPosition",
]


def construct_sher(rows: list) -> bytes:
    if not rows:
        rows = [{}]

    root = ET.Element("edgarDocument")

    cik = next((r.get("cik") for r in rows if _is_present(r.get("cik"))), None)
    if cik:
        ET.SubElement(root, "cik").text = cik

    short_sale_data_info = ET.SubElement(root, "shortSaleDataInfo")

    for day in DAY_ORDER:
        day_rows = [r for r in rows if r.get("_table") == f"sher_{day}"]
        if not day_rows:
            continue

        day_data = ET.SubElement(short_sale_data_info, f"{day}Data")

        sale_date = next((r.get("saleDate") for r in day_rows if _is_present(r.get("saleDate"))), None)
        if sale_date:
            ET.SubElement(day_data, "saleDate").text = sale_date

        for row in day_rows:
            if not any(_is_present(row.get(f)) for f in FIELD_NAMES):
                continue
            short_sale_data_list = ET.SubElement(day_data, "shortSaleDataList")
            for tag in FIELD_NAMES:
                value = row.get(tag)
                if _is_present(value):
                    ET.SubElement(short_sale_data_list, tag).text = value

    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")