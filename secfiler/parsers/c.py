import io
import xml.etree.ElementTree as ET

from ..utils import _add_created_with_comment, _add_path_text, _ensure_path


def _write_form_c(root: ET.Element, row: dict) -> None:
    _add_path_text(root, ['headerData', 'submissionType'], row.get('submissionType'))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], row.get('liveTestFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'period'], row.get('period'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'fileNumber'], row.get('fileNumber'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'filerCcc'], row.get('filerCcc'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'filerCik'], row.get('filerCik'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], row.get('confirmingCopyFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], row.get('overrideInternetFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], row.get('returnCopyFlag'))

    _add_path_text(root, ['formData', 'issuerInformation', 'commissionCik'], row.get('commissionCik'))
    _add_path_text(root, ['formData', 'issuerInformation', 'commissionFileNumber'], row.get('commissionFileNumber'))
    _add_path_text(root, ['formData', 'issuerInformation', 'companyName'], row.get('companyName'))
    _add_path_text(root, ['formData', 'issuerInformation', 'crdNumber'], row.get('crdNumber'))
    _add_path_text(root, ['formData', 'issuerInformation', 'isAmendment'], row.get('isAmendment'))
    _add_path_text(root, ['formData', 'issuerInformation', 'isCoIssuer'], row.get('isCoIssuer'))
    _add_path_text(root, ['formData', 'issuerInformation', 'natureOfAmendment'], row.get('natureOfAmendment'))
    _add_path_text(root, ['formData', 'issuerInformation', 'progressUpdate'], row.get('progressUpdate'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'nameOfIssuer'], row.get('nameOfIssuer'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerWebsite'], row.get('issuerWebsite'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'street1'], row.get('street1'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'street2'], row.get('street2'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'city'], row.get('city'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'stateOrCountry'], row.get('stateOrCountry'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'zipCode'], row.get('zipCode'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'legalStatusForm'], row.get('legalStatusForm'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'jurisdictionOrganization'], row.get('jurisdictionOrganization'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'dateIncorporation'], row.get('dateIncorporation'))

    _add_path_text(root, ['formData', 'offeringInformation', 'compensationAmount'], row.get('compensationAmount'))
    _add_path_text(root, ['formData', 'offeringInformation', 'deadlineDate'], row.get('deadlineDate'))
    _add_path_text(root, ['formData', 'offeringInformation', 'descOverSubscription'], row.get('descOverSubscription'))
    _add_path_text(root, ['formData', 'offeringInformation', 'financialInterest'], row.get('financialInterest'))
    _add_path_text(root, ['formData', 'offeringInformation', 'maximumOfferingAmount'], row.get('maximumOfferingAmount'))
    _add_path_text(root, ['formData', 'offeringInformation', 'noOfSecurityOffered'], row.get('noOfSecurityOffered'))
    _add_path_text(root, ['formData', 'offeringInformation', 'offeringAmount'], row.get('offeringAmount'))
    _add_path_text(root, ['formData', 'offeringInformation', 'overSubscriptionAccepted'], row.get('overSubscriptionAccepted'))
    _add_path_text(root, ['formData', 'offeringInformation', 'overSubscriptionAllocationType'], row.get('overSubscriptionAllocationType'))
    _add_path_text(root, ['formData', 'offeringInformation', 'price'], row.get('price'))
    _add_path_text(root, ['formData', 'offeringInformation', 'priceDeterminationMethod'], row.get('priceDeterminationMethod'))
    _add_path_text(root, ['formData', 'offeringInformation', 'securityOfferedOtherDesc'], row.get('securityOfferedOtherDesc'))
    _add_path_text(root, ['formData', 'offeringInformation', 'securityOfferedType'], row.get('securityOfferedType'))

    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'actReceivedMostRecentFiscalYear'], row.get('actReceivedMostRecentFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'actReceivedPriorFiscalYear'], row.get('actReceivedPriorFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'cashEquiMostRecentFiscalYear'], row.get('cashEquiMostRecentFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'cashEquiPriorFiscalYear'], row.get('cashEquiPriorFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'costGoodsSoldMostRecentFiscalYear'], row.get('costGoodsSoldMostRecentFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'costGoodsSoldPriorFiscalYear'], row.get('costGoodsSoldPriorFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'currentEmployees'], row.get('currentEmployees'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'issueJurisdictionSecuritiesOffering'], row.get('issueJurisdictionSecuritiesOffering'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'longTermDebtMostRecentFiscalYear'], row.get('longTermDebtMostRecentFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'longTermDebtPriorFiscalYear'], row.get('longTermDebtPriorFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'netIncomeMostRecentFiscalYear'], row.get('netIncomeMostRecentFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'netIncomePriorFiscalYear'], row.get('netIncomePriorFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'revenueMostRecentFiscalYear'], row.get('revenueMostRecentFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'revenuePriorFiscalYear'], row.get('revenuePriorFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'shortTermDebtMostRecentFiscalYear'], row.get('shortTermDebtMostRecentFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'shortTermDebtPriorFiscalYear'], row.get('shortTermDebtPriorFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'taxPaidMostRecentFiscalYear'], row.get('taxPaidMostRecentFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'taxPaidPriorFiscalYear'], row.get('taxPaidPriorFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'totalAssetMostRecentFiscalYear'], row.get('totalAssetMostRecentFiscalYear'))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'totalAssetPriorFiscalYear'], row.get('totalAssetPriorFiscalYear'))

    _add_path_text(root, ['formData', 'signatureInfo', 'issuerSignature', 'issuer'], row.get('issuer'))
    _add_path_text(root, ['formData', 'signatureInfo', 'issuerSignature', 'issuerSignature'], row.get('issuerSignature'))
    _add_path_text(root, ['formData', 'signatureInfo', 'issuerSignature', 'issuerTitle'], row.get('issuerTitle'))
    _add_path_text(root, ['formData', 'signatureInfo', 'signaturePersons', 'signaturePerson', 'personSignature'], row.get('personSignature'))
    _add_path_text(root, ['formData', 'signatureInfo', 'signaturePersons', 'signaturePerson', 'personTitle'], row.get('personTitle'))
    _add_path_text(root, ['formData', 'signatureInfo', 'signaturePersons', 'signaturePerson', 'signatureDate'], row.get('signatureDate'))


def construct_c(rows: list) -> bytes:
    root = ET.Element('edgarSubmission')
    root.set('xmlns', 'http://www.sec.gov/edgar/formc')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')

    header_row = next((r for r in rows if r.get('_table') == 'c'), rows[0] if rows else {})
    _write_form_c(root, header_row)

    for row in rows:
        if row.get('_table') != 'c_co_issuer':
            continue
        co = _ensure_path(
            _ensure_path(root, ['formData', 'issuerInformation', 'coIssuers']),
            ['coIssuerInfo'],
            create_leaf=True,
        )
        _add_path_text(co, ['coIssuerCik'], row.get('coIssuerCik'))
        _add_path_text(co, ['coIssuerWebsite'], row.get('coIssuerWebsite'))
        _add_path_text(co, ['isEdgarFiler'], row.get('isEdgarFiler'))
        _add_path_text(co, ['nameOfCoIssuer'], row.get('nameOfCoIssuer'))
        _add_path_text(co, ['coIssuerAddress', 'street1'], row.get('coIssuerAddressStreet1'))
        _add_path_text(co, ['coIssuerAddress', 'city'], row.get('coIssuerAddressCity'))
        _add_path_text(co, ['coIssuerAddress', 'stateOrCountry'], row.get('coIssuerAddressStateOrCountry'))
        _add_path_text(co, ['coIssuerAddress', 'zipCode'], row.get('coIssuerAddressZipCode'))
        _add_path_text(co, ['coIssuerLegalStatus', 'legalStatusForm'], row.get('coIssuerLegalStatusLegalStatusForm'))
        _add_path_text(co, ['coIssuerLegalStatus', 'jurisdictionOrganization'], row.get('coIssuerLegalStatusJurisdictionOrganization'))
        _add_path_text(co, ['coIssuerLegalStatus', 'dateIncorporation'], row.get('coIssuerLegalStatusDateIncorporation'))

    _add_created_with_comment(root)
    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')