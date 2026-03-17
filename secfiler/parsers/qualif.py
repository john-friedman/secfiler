import xml.etree.ElementTree as ET
from ..constants import CREATED_WITH_SECFILER_COMMENT

def _add_created_with_comment(root: ET.Element) -> None:
    root.insert(0, ET.Comment(CREATED_WITH_SECFILER_COMMENT))

import io

def construct_qualif(rows: list) -> bytes:
    row = rows[0]  # QUALIF is always a single record
    root = ET.Element('edgarSubmission')
    
    if row.get('schemaVersion'):
        ET.SubElement(root, 'schemaVersion').text = row['schemaVersion']
    
    if row.get('submissionType'):
        ET.SubElement(root, 'submissionType').text = row['submissionType']
    
    if row.get('act'):
        ET.SubElement(root, 'act').text = row['act']
    
    if row.get('testOrLive'):
        ET.SubElement(root, 'testOrLive').text = row['testOrLive']
    
    effective_data = ET.SubElement(root, 'effectiveData')
    
    if row.get('finalEffectivenessDispDate'):
        ET.SubElement(effective_data, 'finalEffectivenessDispDate').text = row['finalEffectivenessDispDate']
    
    if row.get('finalEffectivenessDispTime'):
        ET.SubElement(effective_data, 'finalEffectivenessDispTime').text = row['finalEffectivenessDispTime']
    
    if row.get('form'):
        ET.SubElement(effective_data, 'form').text = row['form']
    
    filer = ET.SubElement(effective_data, 'filer')
    
    if row.get('cik'):
        ET.SubElement(filer, 'cik').text = row['cik']
    
    if row.get('entityName'):
        ET.SubElement(filer, 'entityName').text = row['entityName']
    
    if row.get('fileNumber'):
        ET.SubElement(filer, 'fileNumber').text = row['fileNumber']
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')
    
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    
    return output.getvalue().encode('utf-8')