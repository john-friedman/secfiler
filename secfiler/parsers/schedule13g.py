import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text, _ensure_path


def construct_schedule13g(rows: list) -> bytes:
    if not rows:
        rows = [{}]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/schedule13g")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_row = next((r for r in rows if r.get('_table') == 'schedule13g'), rows[0])

    _add_path_text(root, ['headerData', 'submissionType'], header_row.get('submissionType'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'cik'], header_row.get('filerCik'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'ccc'], header_row.get('filerCcc'))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], header_row.get('liveTestFlag'))
    _add_path_text(root, ['headerData', 'previousAccessionNumber'], header_row.get('previousAccessionNumber'))

    _add_path_text(root, ['formData', 'coverPageHeader', 'amendmentNo'], header_row.get('amendmentNo'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'securitiesClassTitle'], header_row.get('securitiesClassTitle'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'eventDateRequiresFilingThisStatement'], header_row.get('eventDateRequiresFilingThisStatement'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerCik'], header_row.get('issuerCik'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerName'], header_row.get('issuerName'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerCusip'], header_row.get('issuerCusip'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerPrincipalExecutiveOfficeAddress', 'com:street1'], header_row.get('issuerStreet1'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerPrincipalExecutiveOfficeAddress', 'com:street2'], header_row.get('issuerStreet2'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerPrincipalExecutiveOfficeAddress', 'com:city'], header_row.get('issuerCity'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerPrincipalExecutiveOfficeAddress', 'com:stateOrCountry'], header_row.get('issuerStateOrCountry'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerPrincipalExecutiveOfficeAddress', 'com:zipCode'], header_row.get('issuerZipCode'))

    # pipe-delimited — _add_path_text handles splitting into repeated elements
    _add_path_text(root, ['formData', 'coverPageHeader', 'designateRulesPursuantThisScheduleFiled', 'designateRulePursuantThisScheduleFiled'], header_row.get('designateRulePursuantThisScheduleFiled'))

    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'reportingPersonName'], header_row.get('reportingPersonName'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'citizenshipOrOrganization'], header_row.get('citizenshipOrOrganization'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'reportingPersonBeneficiallyOwnedNumberOfShares', 'soleVotingPower'], header_row.get('soleVotingPower'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'reportingPersonBeneficiallyOwnedNumberOfShares', 'sharedVotingPower'], header_row.get('sharedVotingPower'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'reportingPersonBeneficiallyOwnedNumberOfShares', 'soleDispositivePower'], header_row.get('soleDispositivePower'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'reportingPersonBeneficiallyOwnedNumberOfShares', 'sharedDispositivePower'], header_row.get('sharedDispositivePower'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'reportingPersonBeneficiallyOwnedAggregateNumberOfShares'], header_row.get('aggregateSharesOwned'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'aggregateAmountExcludesCertainSharesFlag'], header_row.get('aggregateAmountExcludesCertainSharesFlag'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'classPercent'], header_row.get('classPercent'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'memberGroup'], header_row.get('memberGroup'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'typeOfReportingPerson'], header_row.get('typeOfReportingPerson'))
    _add_path_text(root, ['formData', 'coverPageHeaderReportingPersonDetails', 'comments'], header_row.get('comments'))

    _add_path_text(root, ['formData', 'items', 'item1', 'issuerName'], header_row.get('item1IssuerName'))
    _add_path_text(root, ['formData', 'items', 'item1', 'issuerPrincipalExecutiveOfficeAddress'], header_row.get('item1IssuerAddress'))

    _add_path_text(root, ['formData', 'items', 'item2', 'filingPersonName'], header_row.get('item2FilingPersonName'))
    _add_path_text(root, ['formData', 'items', 'item2', 'principalBusinessOfficeOrResidenceAddress'], header_row.get('item2PrincipalAddress'))
    _add_path_text(root, ['formData', 'items', 'item2', 'citizenship'], header_row.get('item2Citizenship'))

    _add_path_text(root, ['formData', 'items', 'item3', 'notApplicableFlag'], header_row.get('item3NotApplicable'))
    _add_path_text(root, ['formData', 'items', 'item3', 'typeOfPersonFiling'], header_row.get('item3TypeOfPersonFiling'))
    _add_path_text(root, ['formData', 'items', 'item3', 'otherTypeOfPersonFiling'], header_row.get('item3OtherTypeOfPersonFiling'))

    _add_path_text(root, ['formData', 'items', 'item4', 'amountBeneficiallyOwned'], header_row.get('item4AmountBeneficiallyOwned'))
    _add_path_text(root, ['formData', 'items', 'item4', 'classPercent'], header_row.get('item4ClassPercent'))
    _add_path_text(root, ['formData', 'items', 'item4', 'numberOfSharesPersonHas', 'solePowerOrDirectToVote'], header_row.get('item4SoleVotingPower'))
    _add_path_text(root, ['formData', 'items', 'item4', 'numberOfSharesPersonHas', 'sharedPowerOrDirectToVote'], header_row.get('item4SharedVotingPower'))
    _add_path_text(root, ['formData', 'items', 'item4', 'numberOfSharesPersonHas', 'solePowerOrDirectToDispose'], header_row.get('item4SoleDispositivePower'))
    _add_path_text(root, ['formData', 'items', 'item4', 'numberOfSharesPersonHas', 'sharedPowerOrDirectToDispose'], header_row.get('item4SharedDispositivePower'))

    _add_path_text(root, ['formData', 'items', 'item5', 'notApplicableFlag'], header_row.get('item5NotApplicable'))
    _add_path_text(root, ['formData', 'items', 'item5', 'classOwnership5PercentOrLess'], header_row.get('item5ClassOwnership5PercentOrLess'))

    _add_path_text(root, ['formData', 'items', 'item6', 'notApplicableFlag'], header_row.get('item6NotApplicable'))
    _add_path_text(root, ['formData', 'items', 'item6', 'ownershipMoreThan5PercentOnBehalfOfAnotherPerson'], header_row.get('item6OwnershipMoreThan5Percent'))

    _add_path_text(root, ['formData', 'items', 'item7', 'notApplicableFlag'], header_row.get('item7NotApplicable'))
    _add_path_text(root, ['formData', 'items', 'item7', 'subsidiaryIdentificationAndClassification'], header_row.get('item7SubsidiaryIdentification'))

    _add_path_text(root, ['formData', 'items', 'item8', 'notApplicableFlag'], header_row.get('item8NotApplicable'))
    _add_path_text(root, ['formData', 'items', 'item8', 'identificationAndClassificationOfGroupMembers'], header_row.get('item8GroupMembers'))

    _add_path_text(root, ['formData', 'items', 'item9', 'notApplicableFlag'], header_row.get('item9NotApplicable'))
    _add_path_text(root, ['formData', 'items', 'item9', 'groupDissolutionNotice'], header_row.get('item9GroupDissolutionNotice'))

    _add_path_text(root, ['formData', 'items', 'item10', 'notApplicableFlag'], header_row.get('item10NotApplicable'))
    _add_path_text(root, ['formData', 'items', 'item10', 'certifications'], header_row.get('item10Certifications'))

    _add_path_text(root, ['formData', 'signatureInformation', 'reportingPersonName'], header_row.get('signatureReportingPersonName'))
    _add_path_text(root, ['formData', 'signatureInformation', 'signatureDetails', 'signature'], header_row.get('signature'))
    _add_path_text(root, ['formData', 'signatureInformation', 'signatureDetails', 'title'], header_row.get('signatureTitle'))
    _add_path_text(root, ['formData', 'signatureInformation', 'signatureDetails', 'date'], header_row.get('signatureDate'))

    _add_path_text(root, ['formData', 'signatureComments'], header_row.get('signatureComments'))
    _add_path_text(root, ['formData', 'exhibitInfo'], header_row.get('exhibitInfo'))

    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")