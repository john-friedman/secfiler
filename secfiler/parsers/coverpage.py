import io
import xml.etree.ElementTree as ET
from ..constants import CREATED_WITH_SECFILER_COMMENT

def _add_created_with_comment(root: ET.Element) -> None:
    root.insert(0, ET.Comment(CREATED_WITH_SECFILER_COMMENT))



NS_COV = "http://www.sec.gov/edgar/atsn/cover"
NS_ATS = "http://www.sec.gov/edgar/atsncommon"


ET.register_namespace("cov", NS_COV)
ET.register_namespace("ats", NS_ATS)


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
        ET.SubElement(parent, f"{{{NS_COV}}}{tag}").text = _to_text(value)


def construct_cover_page(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element(f"{{{NS_COV}}}edgarSubmission")
    root.set("xmlns:ats", NS_ATS)

    _add_if_present(root, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]))
    _add_if_present(
        root,
        "rbOperatesPursuantToFormATS",
        _first_across_rows(normalized_rows, ["rbOperatesPursuantToFormATS"]),
    )
    _add_if_present(root, "accessionNumber", _first_across_rows(normalized_rows, ["accessionNumber"]))

    filer_credentials = ET.SubElement(root, f"{{{NS_COV}}}filerCredentials")
    _add_if_present(filer_credentials, "filerCik", _first_across_rows(normalized_rows, ["filerCik"]))
    _add_if_present(filer_credentials, "filerCcc", _first_across_rows(normalized_rows, ["filerCcc"]))

    _add_if_present(root, "fileNumber", _first_across_rows(normalized_rows, ["fileNumber"]))
    _add_if_present(root, "txNMSStockATSName", _first_across_rows(normalized_rows, ["txNMSStockATSName"]))
    _add_if_present(
        root,
        "taStatementAboutAmendment",
        _first_across_rows(normalized_rows, ["taStatementAboutAmendment"]),
    )
    _add_if_present(root, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    flags = ET.SubElement(root, f"{{{NS_COV}}}flags")
    _add_if_present(flags, "overrideInternetFlag", _first_across_rows(normalized_rows, ["overrideInternetFlag"]))
    _add_if_present(flags, "confirmingCopyFlag", _first_across_rows(normalized_rows, ["confirmingCopyFlag"]))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
