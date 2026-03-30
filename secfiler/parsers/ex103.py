import io
import xml.etree.ElementTree as ET

from ..utils import _add_created_with_comment


def construct_ex103(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element('comments')
    _add_created_with_comment(root)

    for row in normalized_rows:
        comment_data = ET.SubElement(root, 'commentData')
        for key, tag in [
            ('itemNumber', 'itemNumber'),
            ('columnName', 'columnName'),
            ('comment', 'Comment'),
            ('fieldName', 'fieldName'),
            ('commentColumn', 'commentColumn'),
            ('commentDescription', 'commentDescription'),
            ('commentNumber', 'commentNumber'),
        ]:
            value = row.get(key)
            if _is_present(value):
                child = ET.SubElement(comment_data, tag)
                child.text = _to_text(value)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')



