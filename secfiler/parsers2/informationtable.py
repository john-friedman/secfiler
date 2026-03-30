import io
import xml.etree.ElementTree as ET

from ..utils import _add_created_with_comment, _add_path_text, _ensure_path


_INFO_TABLE_XMLNS = "http://www.sec.gov/edgar/document/thirteenf/informationtable"


def _write_info_table(root: ET.Element, row: dict) -> None:
    info_table = _ensure_path(root, ["infoTable"], create_leaf=True)

    # Keep element order aligned with the SEC information table schema.
    _add_path_text(info_table, ["nameOfIssuer"], row.get("nameOfIssuer"))
    _add_path_text(info_table, ["titleOfClass"], row.get("titleOfClass"))
    _add_path_text(info_table, ["cusip"], row.get("cusip"))
    _add_path_text(info_table, ["figi"], row.get("figi"))
    _add_path_text(info_table, ["value"], row.get("value"))
    _add_path_text(info_table, ["shrsOrPrnAmt", "sshPrnamt"], row.get("sshPrnamt"))
    _add_path_text(info_table, ["shrsOrPrnAmt", "sshPrnamtType"], row.get("sshPrnamtType"))
    _add_path_text(info_table, ["putCall"], row.get("putCall"))
    _add_path_text(info_table, ["investmentDiscretion"], row.get("investmentDiscretion"))
    _add_path_text(info_table, ["otherManager"], row.get("otherManager"))
    _add_path_text(info_table, ["votingAuthority", "Sole"], row.get("votingAuthoritySole"))
    _add_path_text(info_table, ["votingAuthority", "Shared"], row.get("votingAuthorityShared"))
    _add_path_text(info_table, ["votingAuthority", "None"], row.get("votingAuthorityNone"))


def construct_information_table(rows: list) -> bytes:
    root = ET.Element("informationTable")
    root.set("xmlns", _INFO_TABLE_XMLNS)

    for row in rows:
        _write_info_table(root, row)

    _add_created_with_comment(root)
    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
