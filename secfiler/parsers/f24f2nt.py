import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text, _ensure_path


NS_MAIN = "http://www.sec.gov/edgar/twentyfourf2filer"
NS_FEEC = "http://www.sec.gov/edgar/feecommon"
NS_COM = "http://www.sec.gov/edgar/common"

ET.register_namespace("", NS_MAIN)
ET.register_namespace("feec", NS_FEEC)
ET.register_namespace("com", NS_COM)


def construct_24f2nt(rows: list) -> bytes:
    if not rows:
        rows = [{}]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", NS_MAIN)
    root.set("xmlns:feec", NS_FEEC)
    root.set("xmlns:com", NS_COM)

    header_row = next((r for r in rows if r.get('_table') == '24f2nt'), rows[0])

    _add_path_text(root, ['schemaVersion'], header_row.get('schemaVersion') or 'X0102')
    _add_path_text(root, ['headerData', 'submissionType'], header_row.get('submissionType') or '24F-2NT')
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], header_row.get('liveTestFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'issuerCredentials', 'cik'], header_row.get('filerCik'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'issuerCredentials', 'ccc'], header_row.get('filerCcc'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'fileNumber'], header_row.get('fileNumber'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], header_row.get('overrideInternetFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], header_row.get('confirmingCopyFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'investmentCompanyType'], header_row.get('investmentCompanyType'))

    _add_path_text(root, ['formData', 'annualFilings', 'annualFilingInfo', 'item1', 'nameOfIssuer'], header_row.get('issuerName'))
    _add_path_text(root, ['formData', 'annualFilings', 'annualFilingInfo', 'item1', 'addressOfIssuer', 'street1'], header_row.get('street1'))
    _add_path_text(root, ['formData', 'annualFilings', 'annualFilingInfo', 'item1', 'addressOfIssuer', 'street2'], header_row.get('street2'))
    _add_path_text(root, ['formData', 'annualFilings', 'annualFilingInfo', 'item1', 'addressOfIssuer', 'city'], header_row.get('city'))
    _add_path_text(root, ['formData', 'annualFilings', 'annualFilingInfo', 'item1', 'addressOfIssuer', 'state'], header_row.get('state'))
    _add_path_text(root, ['formData', 'annualFilings', 'annualFilingInfo', 'item1', 'addressOfIssuer', 'country'], header_row.get('country'))
    _add_path_text(root, ['formData', 'annualFilings', 'annualFilingInfo', 'item1', 'addressOfIssuer', 'zipCode'], header_row.get('zipCode'))

    # item2 — series/class repeating rows
    item2_path = ['formData', 'annualFilings', 'annualFilingInfo', 'item2']

    series_rows = [r for r in rows if r.get('_table') == '24f2nt_series']
    if series_rows or header_row.get('rptIncludeAllSeriesFlag'):
        report_series_class = _ensure_path(root, item2_path + ['reportSeriesClass'])
        _add_path_text(report_series_class, ['rptIncludeAllSeriesFlag'], header_row.get('rptIncludeAllSeriesFlag'))
        for row in series_rows:
            rpt = _ensure_path(report_series_class, ['rptSeriesClassInfo'], create_leaf=True)
            _add_path_text(rpt, ['seriesName'], row.get('seriesName'))
            _add_path_text(rpt, ['seriesId'], row.get('seriesId'))
            _add_path_text(rpt, ['includeAllClassesFlag'], row.get('includeAllClassesFlag'))
            if row.get('classId') or row.get('className'):
                _add_path_text(rpt, ['classInfo', 'classId'], row.get('classId'))
                _add_path_text(rpt, ['classInfo', 'className'], row.get('className'))

    annual_class_rows = [r for r in rows if r.get('_table') == '24f2nt_annual_class']
    if annual_class_rows or header_row.get('rptIncludeAllClassesFlag'):
        report_class = _ensure_path(root, item2_path + ['reportClass'])
        _add_path_text(report_class, ['rptIncludeAllClassesFlag'], header_row.get('rptIncludeAllClassesFlag'))
        for row in annual_class_rows:
            aci = _ensure_path(report_class, ['annualClassInfo'], create_leaf=True)
            _add_path_text(aci, ['classId'], row.get('annualClassId'))
            _add_path_text(aci, ['className'], row.get('annualClassName'))

    annual_class_name_rows = [r for r in rows if r.get('_table') == '24f2nt_annual_class_name']
    if annual_class_name_rows or header_row.get('rptIncludeAllFlag'):
        report_class_name = _ensure_path(root, item2_path + ['reportClassName'])
        _add_path_text(report_class_name, ['rptIncludeAllFlag'], header_row.get('rptIncludeAllFlag'))
        for row in annual_class_name_rows:
            acni = _ensure_path(report_class_name, ['annualClassNameInfo'], create_leaf=True)
            _add_path_text(acni, ['className'], row.get('annualClassNameInfoClassName'))

    afi_path = ['formData', 'annualFilings', 'annualFilingInfo']

    _add_path_text(root, afi_path + ['item3', 'investmentCompActFileNo'], header_row.get('investmentCompActFileNo'))
    # pipe-delimited — _add_path_text splits into repeated elements
    _add_path_text(root, afi_path + ['item3', 'securitiesActFileNumbers', 'securitiesActFileNo', 'fileNumber'], header_row.get('securitiesActFileNo'))

    _add_path_text(root, afi_path + ['item4', 'lastDayOfFiscalYear'], header_row.get('lastDayOfFiscalYear'))
    _add_path_text(root, afi_path + ['item4', 'isThisFormBeingFiledLate'], header_row.get('isFiledLate'))
    _add_path_text(root, afi_path + ['item4', 'isThisTheLastTimeIssuerFilingThisForm'], header_row.get('isLastFiling'))

    _add_path_text(root, afi_path + ['item5', 'seriesOrClassId'], header_row.get('seriesOrClassId'))
    _add_path_text(root, afi_path + ['item5', 'aggregateSalePriceOfSecuritiesSold'], header_row.get('aggregateSalePrice'))
    _add_path_text(root, afi_path + ['item5', 'aggregatePriceOfSecuritiesRedeemedOrRepurchasedInFiscalYear'], header_row.get('aggregateRedeemedInFiscalYear'))
    _add_path_text(root, afi_path + ['item5', 'aggregatePriceOfSecuritiesRedeemedOrRepurchasedAnyPrior'], header_row.get('aggregateRedeemedAnyPrior'))
    _add_path_text(root, afi_path + ['item5', 'totalAvailableRedemptionCredits'], header_row.get('totalRedemptionCredits'))
    _add_path_text(root, afi_path + ['item5', 'netSales'], header_row.get('netSales'))
    _add_path_text(root, afi_path + ['item5', 'redemptionCreditsAvailableForUseInFutureYears'], header_row.get('redemptionCreditsAvailable'))
    _add_path_text(root, afi_path + ['item5', 'multiplierForDeterminingRegistrationFee'], header_row.get('feeMultiplier'))
    _add_path_text(root, afi_path + ['item5', 'registrationFeeDue'], header_row.get('registrationFeeDue'))

    _add_path_text(root, afi_path + ['item6', 'numberOfSharesOrOtherUnitsRemainingUnsold'], header_row.get('sharesRemainingUnsold'))
    _add_path_text(root, afi_path + ['item6', 'amountOfSecuritiesDeducted'], header_row.get('securitiesDeducted'))
    _add_path_text(root, afi_path + ['item6', 'interestDue'], header_row.get('item6InterestDue'))

    _add_path_text(root, afi_path + ['item7', 'interestDue'], header_row.get('item7InterestDue'))
    _add_path_text(root, afi_path + ['item7', 'totalOfRegistrationFeePlusAnyInterestDue'], header_row.get('item7TotalFeePlusInterest'))

    _add_path_text(root, afi_path + ['item8', 'totalOfRegistrationFeePlusAnyInterestDue'], header_row.get('item8TotalFeePlusInterest'))
    _add_path_text(root, afi_path + ['item8', 'explanatoryNotes'], header_row.get('item8ExplanatoryNotes'))

    _add_path_text(root, afi_path + ['item9', 'explanatoryNotes'], header_row.get('item9ExplanatoryNotes'))

    _add_path_text(root, afi_path + ['signature', 'signature'], header_row.get('signature'))
    _add_path_text(root, afi_path + ['signature', 'nameAndTitle'], header_row.get('signatureNameAndTitle'))
    _add_path_text(root, afi_path + ['signature', 'signatureDate'], header_row.get('signatureDate'))

    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")