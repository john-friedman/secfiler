import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text, _ensure_path


def construct_1a(rows: list) -> bytes:
    if not rows:
        rows = [{}]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/rega/oneafiler")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_row = next((r for r in rows if r.get('_table') == '1a'), rows[0])

    _add_path_text(root, ['headerData', 'submissionType'], header_row.get('submissionType') or '1-A')
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], header_row.get('liveTestFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'issuerCredentials', 'cik'], header_row.get('filerCik') or header_row.get('cik'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'issuerCredentials', 'ccc'], header_row.get('filerCcc') or header_row.get('ccc'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'offeringFileNumber'], header_row.get('offeringFileNumber'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], header_row.get('returnCopyFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], header_row.get('overrideInternetFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], header_row.get('confirmingCopyFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'sinceLastFiling'], header_row.get('sinceLastFiling'))
    _add_path_text(root, ['headerData', 'coIssuerInfo', 'co-filer', 'coIssuerFileNumber'], header_row.get('coIssuerFileNumber'))
    _add_path_text(root, ['headerData', 'coIssuerInfo', 'co-filer', 'coIssuerCredentials', 'cik'], header_row.get('coIssuerCik'))
    _add_path_text(root, ['headerData', 'coIssuerInfo', 'co-filer', 'coIssuerCredentials', 'ccc'], header_row.get('coIssuerCcc'))

    _add_path_text(root, ['formData', 'employeesInfo', 'issuerName'], header_row.get('issuerName'))
    _add_path_text(root, ['formData', 'employeesInfo', 'jurisdictionOrganization'], header_row.get('jurisdictionOrganization'))
    _add_path_text(root, ['formData', 'employeesInfo', 'yearIncorporation'], header_row.get('yearIncorporation'))
    _add_path_text(root, ['formData', 'employeesInfo', 'cik'], header_row.get('issuerCik') or header_row.get('cik'))
    _add_path_text(root, ['formData', 'employeesInfo', 'sicCode'], header_row.get('sicCode'))
    _add_path_text(root, ['formData', 'employeesInfo', 'irsNum'], header_row.get('irsNum'))
    _add_path_text(root, ['formData', 'employeesInfo', 'fullTimeEmployees'], header_row.get('fullTimeEmployees'))
    _add_path_text(root, ['formData', 'employeesInfo', 'partTimeEmployees'], header_row.get('partTimeEmployees'))

    _add_path_text(root, ['formData', 'issuerInfo', 'street1'], header_row.get('street1'))
    _add_path_text(root, ['formData', 'issuerInfo', 'street2'], header_row.get('street2'))
    _add_path_text(root, ['formData', 'issuerInfo', 'city'], header_row.get('city'))
    _add_path_text(root, ['formData', 'issuerInfo', 'stateOrCountry'], header_row.get('stateOrCountry'))
    _add_path_text(root, ['formData', 'issuerInfo', 'zipCode'], header_row.get('zipCode'))
    _add_path_text(root, ['formData', 'issuerInfo', 'phoneNumber'], header_row.get('phoneNumber'))
    _add_path_text(root, ['formData', 'issuerInfo', 'connectionName'], header_row.get('connectionName'))
    _add_path_text(root, ['formData', 'issuerInfo', 'industryGroup'], header_row.get('industryGroup'))
    _add_path_text(root, ['formData', 'issuerInfo', 'cashEquivalents'], header_row.get('cashEquivalents'))
    _add_path_text(root, ['formData', 'issuerInfo', 'investmentSecurities'], header_row.get('investmentSecurities'))
    _add_path_text(root, ['formData', 'issuerInfo', 'accountsReceivable'], header_row.get('accountsReceivable'))
    _add_path_text(root, ['formData', 'issuerInfo', 'propertyPlantEquipment'], header_row.get('propertyPlantEquipment'))
    _add_path_text(root, ['formData', 'issuerInfo', 'propertyAndEquipment'], header_row.get('propertyAndEquipment'))
    _add_path_text(root, ['formData', 'issuerInfo', 'deposits'], header_row.get('deposits'))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalAssets'], header_row.get('totalAssets'))
    _add_path_text(root, ['formData', 'issuerInfo', 'accountsPayable'], header_row.get('accountsPayable'))
    _add_path_text(root, ['formData', 'issuerInfo', 'longTermDebt'], header_row.get('longTermDebt'))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalLiabilities'], header_row.get('totalLiabilities'))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalStockholderEquity'], header_row.get('totalStockholderEquity'))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalLiabilitiesAndEquity'], header_row.get('totalLiabilitiesAndEquity'))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalRevenues'], header_row.get('totalRevenues'))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalInterestIncome'], header_row.get('totalInterestIncome'))
    _add_path_text(root, ['formData', 'issuerInfo', 'costAndExpensesApplToRevenues'], header_row.get('costAndExpensesApplToRevenues'))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalInterestExpenses'], header_row.get('totalInterestExpenses'))
    _add_path_text(root, ['formData', 'issuerInfo', 'depreciationAndAmortization'], header_row.get('depreciationAndAmortization'))
    _add_path_text(root, ['formData', 'issuerInfo', 'netIncome'], header_row.get('netIncome'))
    _add_path_text(root, ['formData', 'issuerInfo', 'earningsPerShareBasic'], header_row.get('earningsPerShareBasic'))
    _add_path_text(root, ['formData', 'issuerInfo', 'earningsPerShareDiluted'], header_row.get('earningsPerShareDiluted'))
    _add_path_text(root, ['formData', 'issuerInfo', 'loans'], header_row.get('loans'))
    _add_path_text(root, ['formData', 'issuerInfo', 'nameAuditor'], header_row.get('nameAuditor'))

    for row in rows:
        if row.get('_table') != '1a_common_equity':
            continue
        ce = _ensure_path(root, ['formData', 'commonEquity'], create_leaf=True)
        _add_path_text(ce, ['commonEquityClassName'], row.get('commonEquityClassName'))
        _add_path_text(ce, ['outstandingCommonEquity'], row.get('outstandingCommonEquity'))
        _add_path_text(ce, ['commonCusipEquity'], row.get('commonCusipEquity'))
        _add_path_text(ce, ['publiclyTradedCommonEquity'], row.get('publiclyTradedCommonEquity'))

    for row in rows:
        if row.get('_table') != '1a_preferred_equity':
            continue
        pe = _ensure_path(root, ['formData', 'preferredEquity'], create_leaf=True)
        _add_path_text(pe, ['preferredEquityClassName'], row.get('preferredEquityClassName'))
        _add_path_text(pe, ['outstandingPreferredEquity'], row.get('outstandingPreferredEquity'))
        _add_path_text(pe, ['preferredCusipEquity'], row.get('preferredCusipEquity'))
        _add_path_text(pe, ['publiclyTradedPreferredEquity'], row.get('publiclyTradedPreferredEquity'))

    for row in rows:
        if row.get('_table') != '1a_debt_securities':
            continue
        ds = _ensure_path(root, ['formData', 'debtSecurities'], create_leaf=True)
        _add_path_text(ds, ['debtSecuritiesClassName'], row.get('debtSecuritiesClassName'))
        _add_path_text(ds, ['outstandingDebtSecurities'], row.get('outstandingDebtSecurities'))
        _add_path_text(ds, ['cusipDebtSecurities'], row.get('cusipDebtSecurities'))
        _add_path_text(ds, ['publiclyTradedDebtSecurities'], row.get('publiclyTradedDebtSecurities'))

    _add_path_text(root, ['formData', 'issuerEligibility', 'certifyIfTrue'], header_row.get('certifyIfTrue'))
    _add_path_text(root, ['formData', 'applicationRule262', 'certifyIfNotDisqualified'], header_row.get('certifyIfNotDisqualified'))
    _add_path_text(root, ['formData', 'applicationRule262', 'certifyIfBadActor'], header_row.get('certifyIfBadActor'))

    _add_path_text(root, ['formData', 'summaryInfo', 'indicateTier1Tier2Offering'], header_row.get('indicateTier1Tier2Offering'))
    _add_path_text(root, ['formData', 'summaryInfo', 'financialStatementAuditStatus'], header_row.get('financialStatementAuditStatus'))
    _add_path_text(root, ['formData', 'summaryInfo', 'securitiesOffered'], header_row.get('securitiesOffered'))
    # securitiesOfferedTypes is pipe-delimited — _add_path_text splits into repeated elements
    _add_path_text(root, ['formData', 'summaryInfo', 'securitiesOfferedTypes'], header_row.get('securitiesOfferedTypes'))
    _add_path_text(root, ['formData', 'summaryInfo', 'securitiesOfferedOtherDesc'], header_row.get('securitiesOfferedOtherDesc'))
    _add_path_text(root, ['formData', 'summaryInfo', 'offerDelayedContinuousFlag'], header_row.get('offerDelayedContinuousFlag'))
    _add_path_text(root, ['formData', 'summaryInfo', 'offeringYearFlag'], header_row.get('offeringYearFlag'))
    _add_path_text(root, ['formData', 'summaryInfo', 'offeringAfterQualifFlag'], header_row.get('offeringAfterQualifFlag'))
    _add_path_text(root, ['formData', 'summaryInfo', 'offeringBestEffortsFlag'], header_row.get('offeringBestEffortsFlag'))
    _add_path_text(root, ['formData', 'summaryInfo', 'solicitationProposedOfferingFlag'], header_row.get('solicitationProposedOfferingFlag'))
    _add_path_text(root, ['formData', 'summaryInfo', 'resaleSecuritiesAffiliatesFlag'], header_row.get('resaleSecuritiesAffiliatesFlag'))
    _add_path_text(root, ['formData', 'summaryInfo', 'outstandingSecurities'], header_row.get('outstandingSecurities'))
    _add_path_text(root, ['formData', 'summaryInfo', 'pricePerSecurity'], header_row.get('pricePerSecurity'))
    _add_path_text(root, ['formData', 'summaryInfo', 'issuerAggregateOffering'], header_row.get('issuerAggregateOffering'))
    _add_path_text(root, ['formData', 'summaryInfo', 'securityHolderAggegate'], header_row.get('securityHolderAggregate') or header_row.get('securityHolderAggegate'))
    _add_path_text(root, ['formData', 'summaryInfo', 'qualificationOfferingAggregate'], header_row.get('qualificationOfferingAggregate'))
    _add_path_text(root, ['formData', 'summaryInfo', 'concurrentOfferingAggregate'], header_row.get('concurrentOfferingAggregate'))
    _add_path_text(root, ['formData', 'summaryInfo', 'totalAggregateOffering'], header_row.get('totalAggregateOffering'))
    _add_path_text(root, ['formData', 'summaryInfo', 'underwritersServiceProviderName'], header_row.get('underwritersServiceProviderName'))
    _add_path_text(root, ['formData', 'summaryInfo', 'underwritersFees'], header_row.get('underwritersFees'))
    _add_path_text(root, ['formData', 'summaryInfo', 'salesCommissionsServiceProviderName'], header_row.get('salesCommissionsServiceProviderName'))
    _add_path_text(root, ['formData', 'summaryInfo', 'salesCommissionsServiceProviderFees'], header_row.get('salesCommissionsServiceProviderFees'))
    _add_path_text(root, ['formData', 'summaryInfo', 'findersFeesServiceProviderName'], header_row.get('findersFeesServiceProviderName'))
    _add_path_text(root, ['formData', 'summaryInfo', 'finderFeesFee'], header_row.get('finderFeesFee'))
    _add_path_text(root, ['formData', 'summaryInfo', 'auditorServiceProviderName'], header_row.get('auditorServiceProviderName'))
    _add_path_text(root, ['formData', 'summaryInfo', 'auditorFees'], header_row.get('auditorFees'))
    _add_path_text(root, ['formData', 'summaryInfo', 'legalServiceProviderName'], header_row.get('legalServiceProviderName'))
    _add_path_text(root, ['formData', 'summaryInfo', 'legalFees'], header_row.get('legalFees'))
    _add_path_text(root, ['formData', 'summaryInfo', 'promotersServiceProviderName'], header_row.get('promotersServiceProviderName'))
    _add_path_text(root, ['formData', 'summaryInfo', 'promotersFees'], header_row.get('promotersFees'))
    _add_path_text(root, ['formData', 'summaryInfo', 'blueSkyServiceProviderName'], header_row.get('blueSkyServiceProviderName'))
    _add_path_text(root, ['formData', 'summaryInfo', 'blueSkyFees'], header_row.get('blueSkyFees'))
    _add_path_text(root, ['formData', 'summaryInfo', 'brokerDealerCrdNumber'], header_row.get('brokerDealerCrdNumber'))
    _add_path_text(root, ['formData', 'summaryInfo', 'estimatedNetAmount'], header_row.get('estimatedNetAmount'))
    _add_path_text(root, ['formData', 'summaryInfo', 'clarificationResponses'], header_row.get('clarificationResponses'))

    # pipe or comma delimited — _add_path_text splits into repeated elements
    _add_path_text(root, ['formData', 'juridictionSecuritiesOffered', 'jurisdictionsOfSecOfferedNone'], header_row.get('jurisdictionsOfSecOfferedNone'))
    _add_path_text(root, ['formData', 'juridictionSecuritiesOffered', 'jurisdictionsOfSecOfferedSame'], header_row.get('jurisdictionsOfSecOfferedSame'))
    _add_path_text(root, ['formData', 'juridictionSecuritiesOffered', 'issueJuridicationSecuritiesOffering'], header_row.get('issueJurisdiction'))
    _add_path_text(root, ['formData', 'juridictionSecuritiesOffered', 'dealersJuridicationSecuritiesOffering'], header_row.get('dealersJurisdiction'))

    _add_path_text(root, ['formData', 'unregisteredSecurities', 'ifUnregsiteredNone'], header_row.get('ifUnregisteredNone') or header_row.get('ifUnregsiteredNone'))

    for row in rows:
        if row.get('_table') != '1a_securities_issued':
            continue
        si = _ensure_path(root, ['formData', 'securitiesIssued'], create_leaf=True)
        _add_path_text(si, ['securitiesIssuerName'], row.get('securitiesIssuerName'))
        _add_path_text(si, ['securitiesIssuerTitle'], row.get('securitiesIssuerTitle'))
        _add_path_text(si, ['securitiesIssuedTotalAmount'], row.get('securitiesIssuedTotalAmount'))
        _add_path_text(si, ['securitiesPrincipalHolderAmount'], row.get('securitiesPrincipalHolderAmount'))
        _add_path_text(si, ['securitiesIssuedAggregateAmount'], row.get('securitiesIssuedAggregateAmount'))
        _add_path_text(si, ['aggregateConsiderationBasis'], row.get('aggregateConsiderationBasis'))

    _add_path_text(root, ['formData', 'unregisteredSecuritiesAct', 'securitiesActExcemption'], header_row.get('securitiesActExemption') or header_row.get('securitiesActExcemption'))

    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")