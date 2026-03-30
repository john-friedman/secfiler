import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text


def construct_cover_page(rows: list) -> bytes:
    header_row = next((r for r in rows if r.get('_table') == 'cover_page'), rows[0] if rows else {})

    root = ET.Element('edgarSubmission')

    _add_path_text(root, ['submissionType'], header_row.get('submissionType'))
    _add_path_text(root, ['rbOperatesPursuantToFormATS'], header_row.get('rbOperatesPursuantToFormATS'))
    _add_path_text(root, ['accessionNumber'], header_row.get('accessionNumber'))
    _add_path_text(root, ['filerCredentials', 'filerCik'], header_row.get('filerCik'))
    _add_path_text(root, ['filerCredentials', 'filerCcc'], header_row.get('filerCcc'))
    _add_path_text(root, ['fileNumber'], header_row.get('fileNumber'))
    _add_path_text(root, ['txNMSStockATSName'], header_row.get('txNMSStockATSName'))
    _add_path_text(root, ['taStatementAboutAmendment'], header_row.get('taStatementAboutAmendment'))
    _add_path_text(root, ['liveTestFlag'], header_row.get('liveTestFlag'))
    _add_path_text(root, ['flags', 'overrideInternetFlag'], header_row.get('overrideInternetFlag'))
    _add_path_text(root, ['flags', 'confirmingCopyFlag'], header_row.get('confirmingCopyFlag'))

    _add_created_with_comment(root)
    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')