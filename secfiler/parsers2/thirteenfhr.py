import io
import xml.etree.ElementTree as ET
from ..utils import (
    _add_created_with_comment,
    _add_path_text,
    _ensure_path,
)

def construct_13fhr(rows: list) -> bytes:
    root = ET.Element('edgarSubmission')
    root.set('xmlns', 'http://www.sec.gov/edgar/thirteenffiler')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')
    root.set('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance')

    header_row = next((r for r in rows if r.get('_table') == '13fhr'), rows[0] if rows else {})

    # --- headerData ---
    _add_path_text(root, ['schemaVersion'], header_row.get('schemaVersion') or 'X0202')

    header_data = _ensure_path(root, ['headerData'])
    _add_path_text(header_data, ['submissionType'], header_row.get('submissionType'))
    
    filer_info = _ensure_path(header_data, ['filerInfo'])
    _add_path_text(filer_info, ['liveTestFlag'], header_row.get('liveTestFlag'))

    flags = _ensure_path(filer_info, ['flags'])
    _add_path_text(flags, ['confirmingCopyFlag'], header_row.get('confirmingCopyFlag'))
    _add_path_text(flags, ['returnCopyFlag'], header_row.get('returnCopyFlag'))
    _add_path_text(flags, ['overrideInternetFlag'], header_row.get('overrideInternetFlag'))

    filer = _ensure_path(filer_info, ['filer'])
    credentials = _ensure_path(filer, ['credentials'])
    _add_path_text(credentials, ['cik'], header_row.get('filerCik'))
    _add_path_text(credentials, ['ccc'], header_row.get('filerCcc'))
    _add_path_text(filer, ['fileNumber'], header_row.get('fileNumber'))

    _add_path_text(filer_info, ['periodOfReport'], header_row.get('periodOfReport'))
    _add_path_text(filer_info, ['denovoRequest'], header_row.get('denovoRequest'))

    # --- formData / coverPage ---
    form_data = _ensure_path(root, ['formData'])
    cover_page = _ensure_path(form_data, ['coverPage'])

    _add_path_text(cover_page, ['reportCalendarOrQuarter'], header_row.get('reportCalendarOrQuarter'))
    _add_path_text(cover_page, ['isAmendment'], header_row.get('isAmendment'))
    _add_path_text(cover_page, ['amendmentNo'], header_row.get('amendmentNo'))

    amendment_info = _ensure_path(cover_page, ['amendmentInfo'])
    _add_path_text(amendment_info, ['amendmentType'], header_row.get('amendmentType'))
    _add_path_text(amendment_info, ['confDeniedExpired'], header_row.get('confDeniedExpired'))
    _add_path_text(amendment_info, ['reasonForNonConfidentiality'], header_row.get('reasonForNonConfidentiality'))
    _add_path_text(amendment_info, ['dateDeniedExpired'], header_row.get('dateDeniedExpired'))
    _add_path_text(amendment_info, ['dateReported'], header_row.get('dateReported'))

    filing_manager = _ensure_path(cover_page, ['filingManager'])
    _add_path_text(filing_manager, ['name'], header_row.get('filingManagerName'))

    address = _ensure_path(filing_manager, ['address'])
    _add_path_text(address, ['com:street1'], header_row.get('street1'))
    _add_path_text(address, ['com:street2'], header_row.get('street2'))
    _add_path_text(address, ['com:city'], header_row.get('city'))
    _add_path_text(address, ['com:stateOrCountry'], header_row.get('stateOrCountry'))
    _add_path_text(address, ['com:zipCode'], header_row.get('zipCode'))

    _add_path_text(cover_page, ['reportType'], header_row.get('reportType'))
    _add_path_text(cover_page, ['form13FFileNumber'], header_row.get('form13FFileNumber'))
    _add_path_text(cover_page, ['secFileNumber'], header_row.get('secFileNumber'))
    _add_path_text(cover_page, ['crdNumber'], header_row.get('crdNumber'))
    _add_path_text(cover_page, ['provideInfoForInstruction5'], header_row.get('provideInfoForInstruction5'))
    _add_path_text(cover_page, ['additionalInformation'], header_row.get('additionalInformation'))

    # otherManager rows (no sequenceNumber)
    other_manager_rows = [r for r in rows if r.get('_table') == '13fhr_other_manager']
    if other_manager_rows:
        other_managers_info = _ensure_path(cover_page, ['otherManagersInfo'])
        for row in other_manager_rows:
            other_manager = _ensure_path(other_managers_info, ['otherManager'], create_leaf=True)
            _add_path_text(other_manager, ['name'], row.get('name'))
            _add_path_text(other_manager, ['cik'], row.get('cik'))
            _add_path_text(other_manager, ['form13FFileNumber'], row.get('form13FFileNumber'))
            _add_path_text(other_manager, ['secFileNumber'], row.get('secFileNumber'))
            _add_path_text(other_manager, ['crdNumber'], row.get('crdNumber'))

    # --- signatureBlock ---
    sig_block = _ensure_path(form_data, ['signatureBlock'])
    _add_path_text(sig_block, ['name'], header_row.get('signatureName'))
    _add_path_text(sig_block, ['title'], header_row.get('signatureTitle'))
    _add_path_text(sig_block, ['phone'], header_row.get('signaturePhone'))
    _add_path_text(sig_block, ['signature'], header_row.get('signature'))
    _add_path_text(sig_block, ['city'], header_row.get('signatureCity'))
    _add_path_text(sig_block, ['stateOrCountry'], header_row.get('signatureStateOrCountry'))
    _add_path_text(sig_block, ['signatureDate'], header_row.get('signatureDate'))

    # --- summaryPage ---
    summary_page = _ensure_path(form_data, ['summaryPage'])
    _add_path_text(summary_page, ['otherIncludedManagersCount'], header_row.get('otherIncludedManagersCount'))
    _add_path_text(summary_page, ['tableEntryTotal'], header_row.get('tableEntryTotal'))
    _add_path_text(summary_page, ['tableValueTotal'], header_row.get('tableValueTotal'))
    _add_path_text(summary_page, ['isConfidentialOmitted'], header_row.get('isConfidentialOmitted'))

    # otherManager2 rows (have sequenceNumber)
    other_manager2_rows = [r for r in rows if r.get('_table') == '13fhr_other_manager2']
    if other_manager2_rows:
        other_managers2_info = _ensure_path(summary_page, ['otherManagers2Info'])
        for row in other_manager2_rows:
            other_manager2 = _ensure_path(other_managers2_info, ['otherManager2'], create_leaf=True)
            _add_path_text(other_manager2, ['sequenceNumber'], row.get('sequenceNumber'))
            other_manager = _ensure_path(other_manager2, ['otherManager'], create_leaf=True)
            _add_path_text(other_manager, ['name'], row.get('name'))
            _add_path_text(other_manager, ['cik'], row.get('cik'))
            _add_path_text(other_manager, ['form13FFileNumber'], row.get('form13FFileNumber'))
            _add_path_text(other_manager, ['secFileNumber'], row.get('secFileNumber'))
            _add_path_text(other_manager, ['crdNumber'], row.get('crdNumber'))

    _add_created_with_comment(root)
    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')