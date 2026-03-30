import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text, _ensure_path


def construct_npx(rows: list) -> bytes:
    if not rows:
        rows = [{}]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/npx")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_row = next((r for r in rows if r.get('_table') == 'npx'), rows[0])

    _add_path_text(root, ['headerData', 'submissionType'], header_row.get('submissionType') or 'N-PX')
    _add_path_text(root, ['headerData', 'filerInfo', 'registrantType'], header_row.get('registrantType'))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], header_row.get('liveTestFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'issuerCredentials', 'cik'], header_row.get('filerCik'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'issuerCredentials', 'ccc'], header_row.get('filerCcc'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'fileNumber'], header_row.get('fileNumber'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], header_row.get('overrideInternetFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], header_row.get('confirmingCopyFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'investmentCompanyType'], header_row.get('investmentCompanyType'))
    _add_path_text(root, ['headerData', 'filerInfo', 'periodOfReport'], header_row.get('periodOfReport'))

    series_rows = [r for r in rows if r.get('_table') == 'npx_series']
    if series_rows:
        report_series_class = _ensure_path(root, ['headerData', 'seriesClass', 'reportSeriesClass'])
        _add_path_text(report_series_class, ['rptIncludeAllSeriesFlag'], header_row.get('rptIncludeAllSeriesFlag'))
        for row in series_rows:
            rpt = _ensure_path(report_series_class, ['rptSeriesClassInfo'], create_leaf=True)
            _add_path_text(rpt, ['seriesId'], row.get('idOfSeries'))
            _add_path_text(rpt, ['includeAllClassesFlag'], row.get('rptIncludeAllSeriesFlag') or 'true')

    _add_path_text(root, ['formData', 'coverPage', 'yearOrQuarter'], header_row.get('yearOrQuarter'))
    _add_path_text(root, ['formData', 'coverPage', 'reportCalendarYear'], header_row.get('reportCalendarYear'))
    _add_path_text(root, ['formData', 'coverPage', 'reportQuarterYear'], header_row.get('reportQuarterYear'))
    _add_path_text(root, ['formData', 'coverPage', 'amendmentInfo', 'isAmendment'], header_row.get('isAmendment'))
    _add_path_text(root, ['formData', 'coverPage', 'amendmentInfo', 'amendmentNo'], header_row.get('amendmentNo'))
    _add_path_text(root, ['formData', 'coverPage', 'amendmentInfo', 'amendmentType'], header_row.get('amendmentType'))
    _add_path_text(root, ['formData', 'coverPage', 'amendmentInfo', 'confDeniedExpired'], header_row.get('confDeniedExpired'))
    _add_path_text(root, ['formData', 'coverPage', 'amendmentInfo', 'dateExpiredDenied'], header_row.get('dateExpiredDenied'))
    _add_path_text(root, ['formData', 'coverPage', 'amendmentInfo', 'dateReported'], header_row.get('dateReported'))
    _add_path_text(root, ['formData', 'coverPage', 'amendmentInfo', 'reasonForNonConfidentiality'], header_row.get('reasonForNonConfidentiality'))
    _add_path_text(root, ['formData', 'coverPage', 'reportingPerson', 'name'], header_row.get('reportingPersonName'))
    _add_path_text(root, ['formData', 'coverPage', 'reportingPerson', 'phoneNumber'], header_row.get('reportingPersonPhone'))
    _add_path_text(root, ['formData', 'coverPage', 'reportingPerson', 'address', 'com:street1'], header_row.get('street1'))
    _add_path_text(root, ['formData', 'coverPage', 'reportingPerson', 'address', 'com:street2'], header_row.get('street2'))
    _add_path_text(root, ['formData', 'coverPage', 'reportingPerson', 'address', 'com:city'], header_row.get('city'))
    _add_path_text(root, ['formData', 'coverPage', 'reportingPerson', 'address', 'com:stateOrCountry'], header_row.get('stateOrCountry'))
    _add_path_text(root, ['formData', 'coverPage', 'reportingPerson', 'address', 'com:zipCode'], header_row.get('zipCode'))
    _add_path_text(root, ['formData', 'coverPage', 'agentForService', 'name'], header_row.get('agentName'))
    _add_path_text(root, ['formData', 'coverPage', 'agentForService', 'address', 'com:street1'], header_row.get('agentStreet1'))
    _add_path_text(root, ['formData', 'coverPage', 'agentForService', 'address', 'com:street2'], header_row.get('agentStreet2'))
    _add_path_text(root, ['formData', 'coverPage', 'agentForService', 'address', 'com:city'], header_row.get('agentCity'))
    _add_path_text(root, ['formData', 'coverPage', 'agentForService', 'address', 'com:stateOrCountry'], header_row.get('agentStateOrCountry'))
    _add_path_text(root, ['formData', 'coverPage', 'agentForService', 'address', 'com:zipCode'], header_row.get('agentZipCode'))
    _add_path_text(root, ['formData', 'coverPage', 'reportInfo', 'reportType'], header_row.get('reportType'))
    _add_path_text(root, ['formData', 'coverPage', 'reportInfo', 'confidentialTreatment'], header_row.get('confidentialTreatment'))
    _add_path_text(root, ['formData', 'coverPage', 'reportInfo', 'noticeExplanation'], header_row.get('noticeExplanation'))
    _add_path_text(root, ['formData', 'coverPage', 'fileNumber'], header_row.get('coverFileNumber'))
    _add_path_text(root, ['formData', 'coverPage', 'leiNumber'], header_row.get('leiNumber'))
    _add_path_text(root, ['formData', 'coverPage', 'reportingSecFileNumber'], header_row.get('reportingSecFileNumber'))
    _add_path_text(root, ['formData', 'coverPage', 'reportingCrdNumber'], header_row.get('reportingCrdNumber'))
    _add_path_text(root, ['formData', 'coverPage', 'explanatoryInformation', 'explanatoryChoice'], header_row.get('explanatoryChoice'))
    _add_path_text(root, ['formData', 'coverPage', 'explanatoryInformation', 'explanatoryNotes'], header_row.get('explanatoryNotes'))

    other_manager_rows = [r for r in rows if r.get('_table') == 'npx_other_manager']
    if other_manager_rows:
        other_managers_info = _ensure_path(root, ['formData', 'coverPage', 'otherManagersInfo'])
        for row in other_manager_rows:
            om = _ensure_path(other_managers_info, ['otherManager'], create_leaf=True)
            _add_path_text(om, ['managerName'], row.get('managerName'))
            _add_path_text(om, ['crdNumber'], row.get('crdNumber'))
            _add_path_text(om, ['icaOr13FFileNumber'], row.get('icaOr13FFileNumber'))
            _add_path_text(om, ['otherFileNumber'], row.get('otherFileNumber'))
            _add_path_text(om, ['leiNumberOM'], row.get('leiNumberOM') or row.get('otherManagerLeiNumber'))

    _add_path_text(root, ['formData', 'summaryPage', 'otherIncludedManagersCount'], header_row.get('otherIncludedManagersCount'))

    investment_manager_rows = [r for r in rows if r.get('_table') == 'npx_investment_manager']
    if investment_manager_rows:
        other_managers2 = _ensure_path(root, ['formData', 'summaryPage', 'otherManagers2'])
        for row in investment_manager_rows:
            im = _ensure_path(other_managers2, ['investmentManagers'], create_leaf=True)
            _add_path_text(im, ['serialNo'], row.get('serialNo'))
            _add_path_text(im, ['form13FFileNumber'], row.get('form13FFileNumber'))
            _add_path_text(im, ['crdNumber'], row.get('crdNumber'))
            _add_path_text(im, ['secFileNumber'], row.get('secFileNumber'))
            _add_path_text(im, ['leiNumber'], row.get('leiNumber'))
            _add_path_text(im, ['name'], row.get('name'))

    if series_rows:
        series_page = _ensure_path(root, ['formData', 'seriesPage'])
        _add_path_text(series_page, ['seriesCount'], header_row.get('seriesCount'))
        series_details = _ensure_path(series_page, ['seriesDetails'])
        for row in series_rows:
            sr = _ensure_path(series_details, ['seriesReports'], create_leaf=True)
            _add_path_text(sr, ['idOfSeries'], row.get('idOfSeries'))
            _add_path_text(sr, ['nameOfSeries'], row.get('nameOfSeries'))
            _add_path_text(sr, ['leiOfSeries'], row.get('leiOfSeries'))

    _add_path_text(root, ['formData', 'signaturePage', 'reportingPerson'], header_row.get('signatureReportingPerson'))
    _add_path_text(root, ['formData', 'signaturePage', 'txSignature'], header_row.get('txSignature'))
    _add_path_text(root, ['formData', 'signaturePage', 'txPrintedSignature'], header_row.get('txPrintedSignature'))
    _add_path_text(root, ['formData', 'signaturePage', 'txTitle'], header_row.get('txTitle'))
    _add_path_text(root, ['formData', 'signaturePage', 'txAsOfDate'], header_row.get('txAsOfDate'))

    secondary_sig_rows = [r for r in rows if r.get('_table') == 'npx_secondary_signature']
    if secondary_sig_rows:
        secondary_records = _ensure_path(root, ['formData', 'signaturePage', 'secondaryRecords'])
        for row in secondary_sig_rows:
            sr = _ensure_path(secondary_records, ['secondaryRecord'], create_leaf=True)
            _add_path_text(sr, ['printedSign'], row.get('printedSign'))
            _add_path_text(sr, ['txSignature'], row.get('txSignature'))
            _add_path_text(sr, ['txTitle'], row.get('txTitle'))
            _add_path_text(sr, ['txAsOfDate'], row.get('txAsOfDate'))

    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")