import xml.etree.ElementTree as ET
from ..constants import CREATED_WITH_SECFILER_COMMENT

def _add_created_with_comment(root: ET.Element) -> None:
    root.insert(0, ET.Comment(CREATED_WITH_SECFILER_COMMENT))

import io

def construct_information_table(rows: list) -> bytes:
    root = ET.Element('informationTable')
    root.set('xmlns', 'http://www.sec.gov/edgar/document/thirteenf/informationtable')
    root.set('xmlns:ns2', 'http://www.sec.gov/edgar/common')
    root.set('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance')
    root.set('xsi:schemaLocation', 
             'http://www.sec.gov/edgar/document/thirteenf/informationtable eis_13FDocument.xsd')
    
    for row in rows:
        info_table = ET.SubElement(root, 'infoTable')
        
        if row.get('nameOfIssuer'):
            ET.SubElement(info_table, 'nameOfIssuer').text = row['nameOfIssuer']
        
        if row.get('titleOfClass'):
            ET.SubElement(info_table, 'titleOfClass').text = row['titleOfClass']
        
        if row.get('cusip'):
            ET.SubElement(info_table, 'cusip').text = row['cusip']
        
        if row.get('figi'):
            ET.SubElement(info_table, 'figi').text = row['figi']
        
        if row.get('value'):
            ET.SubElement(info_table, 'value').text = row['value']
        
        if row.get('sshPrnamt') or row.get('sshPrnamtType'):
            shrs_or_prn_amt = ET.SubElement(info_table, 'shrsOrPrnAmt')
            
            if row.get('sshPrnamt'):
                ET.SubElement(shrs_or_prn_amt, 'sshPrnamt').text = row['sshPrnamt']
            
            if row.get('sshPrnamtType'):
                ET.SubElement(shrs_or_prn_amt, 'sshPrnamtType').text = row['sshPrnamtType']
        
        if row.get('investmentDiscretion'):
            ET.SubElement(info_table, 'investmentDiscretion').text = row['investmentDiscretion']
        
        if row.get('otherManager'):
            ET.SubElement(info_table, 'otherManager').text = row['otherManager']
        
        if row.get('votingAuthoritySole') or row.get('votingAuthorityShared') or row.get('votingAuthorityNone'):
            voting_authority = ET.SubElement(info_table, 'votingAuthority')
            
            if row.get('votingAuthoritySole'):
                ET.SubElement(voting_authority, 'Sole').text = row['votingAuthoritySole']
            
            if row.get('votingAuthorityShared'):
                ET.SubElement(voting_authority, 'Shared').text = row['votingAuthorityShared']
            
            if row.get('votingAuthorityNone'):
                ET.SubElement(voting_authority, 'None').text = row['votingAuthorityNone']
        
        if row.get('putCall') and str(row['putCall']).strip():
            ET.SubElement(info_table, 'putCall').text = row['putCall']
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')
    
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n')
    output.write("<?xml-stylesheet type='text/xsl' href=\"INFO-TABLE_X01.xsl\"?>\n")
    tree.write(output, encoding='unicode', xml_declaration=False)
    
    return output.getvalue().encode('utf-8')