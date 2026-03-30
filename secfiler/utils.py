import xml.etree.ElementTree as ET
from .constants import CREATED_WITH_SECFILER_COMMENT


def _add_created_with_comment(root: ET.Element) -> None:
    root.insert(0, ET.Comment(CREATED_WITH_SECFILER_COMMENT))


def _is_present(value) -> bool:
    if value is None:
        return False
    if isinstance(value, str):
        return bool(value.strip())
    if isinstance(value, (list, tuple, set)):
        return any(_is_present(item) for item in value)
    return True


def _ensure_path(parent: ET.Element, tags: list[str], create_leaf: bool = False) -> ET.Element:
    current = parent
    total = len(tags)
    for idx, tag in enumerate(tags):
        found = None
        if not (create_leaf and idx == total - 1):
            for child in current:
                if child.tag == tag:
                    found = child
                    break
        if found is None:
            found = ET.SubElement(current, tag)
        current = found
    return current


def _add_path_text(root: ET.Element, tags: list[str], value) -> None:
    if value is None:
        return
    target = _ensure_path(root, tags)
    if not _is_present(target.text):
        target.text = value


def _add_path_attr(root: ET.Element, tags: list[str], attr_name: str, value) -> None:
    if not _is_present(value):
        return
    target = _ensure_path(root, tags)
    if attr_name not in target.attrib:
        target.set(attr_name, value)


def _add_footnote_ids(parent: ET.Element, path: list[str], value) -> None:
    """
    Splits a pipe-delimited footnote string and appends one <footnoteId id="..."/>
    child per value under the element at `path` relative to `parent`.

    Example:
        value = "F1|F2"
        produces:
            <footnoteId id="F1"/>
            <footnoteId id="F2"/>
    """
    if not _is_present(value):
        return
    ids = [fid.strip() for fid in str(value).split('|') if fid.strip()]
    if not ids:
        return
    target = _ensure_path(parent, path) if path else parent
    for fid in ids:
        node = ET.SubElement(target, 'footnoteId')
        node.set('id', fid)