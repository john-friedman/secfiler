import io
import xml.etree.ElementTree as ET

from ..utils import _add_created_with_comment, _add_path_text


def construct_ex103(rows: list) -> bytes:
    root = ET.Element("comments")
    _add_created_with_comment(root)

    for row in rows:
        comment_data = ET.SubElement(root, "commentData")
        for key, tag in [
            ("itemNumber", "itemNumber"),
            ("columnName", "columnName"),
            ("comment", "Comment"),
            ("fieldName", "fieldName"),
            ("commentColumn", "commentColumn"),
            ("commentDescription", "commentDescription"),
            ("commentNumber", "commentNumber"),
        ]:
            _add_path_text(comment_data, [tag], row.get(key))

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")

