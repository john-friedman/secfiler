import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text, _ensure_path


def construct_schedule13d(rows: list) -> bytes:
    if not rows:
        rows = [{}]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/schedule13D")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_row = next((r for r in rows if r.get('_table') == 'schedule13d'), rows[0])

    _add_path_text(root, ['headerData', 'submissionType'], header_row.get('submissionType'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'cik'], header_row.get('filerCik'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'ccc'], header_row.get('filerCcc'))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], header_row.get('liveTestFlag'))
    _add_path_text(root, ['headerData', 'previousAccessionNumber'], header_row.get('previousAccessionNumber'))

    _add_path_text(root, ['formData', 'coverPageHeader', 'amendmentNo'], header_row.get('amendmentNo'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'securitiesClassTitle'], header_row.get('securitiesClassTitle'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'dateOfEvent'], header_row.get('dateOfEvent'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'previouslyFiledFlag'], header_row.get('previouslyFiledFlag'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerCIK'], header_row.get('issuerCIK'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerCUSIP'], header_row.get('issuerCUSIP'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'issuerName'], header_row.get('issuerName'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'address', 'com:street1'], header_row.get('issuerStreet1'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'address', 'com:street2'], header_row.get('issuerStreet2'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'address', 'com:city'], header_row.get('issuerCity'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'address', 'com:stateOrCountry'], header_row.get('issuerStateOrCountry'))
    _add_path_text(root, ['formData', 'coverPageHeader', 'issuerInfo', 'address', 'com:zipCode'], header_row.get('issuerZipCode'))

    for row in rows:
        if row.get('_table') != 'schedule13d_authorized_person':
            continue
        notification = _ensure_path(
            _ensure_path(root, ['formData', 'coverPageHeader', 'authorizedPersons']),
            ['notificationInfo'],
            create_leaf=True,
        )
        _add_path_text(notification, ['personName'], row.get('authorizedPersonName'))
        _add_path_text(notification, ['personPhoneNum'], row.get('authorizedPersonPhone'))
        _add_path_text(notification, ['personAddress', 'com:street1'], row.get('authorizedStreet1'))
        _add_path_text(notification, ['personAddress', 'com:street2'], row.get('authorizedStreet2'))
        _add_path_text(notification, ['personAddress', 'com:city'], row.get('authorizedCity'))
        _add_path_text(notification, ['personAddress', 'com:stateOrCountry'], row.get('authorizedStateOrCountry'))
        _add_path_text(notification, ['personAddress', 'com:zipCode'], row.get('authorizedZipCode'))

    for row in rows:
        if row.get('_table') != 'schedule13d_reporting_person':
            continue
        person = _ensure_path(
            _ensure_path(root, ['formData', 'reportingPersons']),
            ['reportingPersonInfo'],
            create_leaf=True,
        )
        _add_path_text(person, ['reportingPersonCIK'], row.get('reportingPersonCIK'))
        _add_path_text(person, ['reportingPersonNoCIK'], row.get('reportingPersonNoCIK'))
        _add_path_text(person, ['reportingPersonName'], row.get('reportingPersonName'))
        _add_path_text(person, ['memberOfGroup'], row.get('memberOfGroup'))
        _add_path_text(person, ['fundType'], row.get('fundType'))
        _add_path_text(person, ['legalProceedings'], row.get('legalProceedings'))
        _add_path_text(person, ['citizenshipOrOrganization'], row.get('citizenshipOrOrganization'))
        _add_path_text(person, ['soleVotingPower'], row.get('soleVotingPower'))
        _add_path_text(person, ['sharedVotingPower'], row.get('sharedVotingPower'))
        _add_path_text(person, ['soleDispositivePower'], row.get('soleDispositivePower'))
        _add_path_text(person, ['sharedDispositivePower'], row.get('sharedDispositivePower'))
        _add_path_text(person, ['aggregateAmountOwned'], row.get('aggregateAmountOwned'))
        _add_path_text(person, ['isAggregateExcludeShares'], row.get('isAggregateExcludeShares'))
        _add_path_text(person, ['percentOfClass'], row.get('percentOfClass'))
        _add_path_text(person, ['typeOfReportingPerson'], row.get('typeOfReportingPerson'))
        _add_path_text(person, ['commentContent'], row.get('commentContent'))

    _add_path_text(root, ['formData', 'items1To7', 'item1', 'securityTitle'], header_row.get('item1SecurityTitle'))
    _add_path_text(root, ['formData', 'items1To7', 'item1', 'issuerName'], header_row.get('item1IssuerName'))
    _add_path_text(root, ['formData', 'items1To7', 'item1', 'issuerPrincipalAddress', 'com:street1'], header_row.get('item1Street1'))
    _add_path_text(root, ['formData', 'items1To7', 'item1', 'issuerPrincipalAddress', 'com:street2'], header_row.get('item1Street2'))
    _add_path_text(root, ['formData', 'items1To7', 'item1', 'issuerPrincipalAddress', 'com:city'], header_row.get('item1City'))
    _add_path_text(root, ['formData', 'items1To7', 'item1', 'issuerPrincipalAddress', 'com:stateOrCountry'], header_row.get('item1StateOrCountry'))
    _add_path_text(root, ['formData', 'items1To7', 'item1', 'issuerPrincipalAddress', 'com:zipCode'], header_row.get('item1ZipCode'))
    _add_path_text(root, ['formData', 'items1To7', 'item1', 'commentText'], header_row.get('item1CommentText'))

    _add_path_text(root, ['formData', 'items1To7', 'item2', 'filingPersonName'], header_row.get('item2FilingPersonName'))
    _add_path_text(root, ['formData', 'items1To7', 'item2', 'principalBusinessAddress'], header_row.get('item2PrincipalBusinessAddress'))
    _add_path_text(root, ['formData', 'items1To7', 'item2', 'principalJob'], header_row.get('item2PrincipalJob'))
    _add_path_text(root, ['formData', 'items1To7', 'item2', 'hasBeenConvicted'], header_row.get('item2HasBeenConvicted'))
    _add_path_text(root, ['formData', 'items1To7', 'item2', 'convictionDescription'], header_row.get('item2ConvictionDescription'))
    _add_path_text(root, ['formData', 'items1To7', 'item2', 'citizenship'], header_row.get('item2Citizenship'))

    _add_path_text(root, ['formData', 'items1To7', 'item3', 'fundsSource'], header_row.get('item3FundsSource'))

    _add_path_text(root, ['formData', 'items1To7', 'item4', 'transactionPurpose'], header_row.get('item4TransactionPurpose'))

    _add_path_text(root, ['formData', 'items1To7', 'item5', 'percentageOfClassSecurities'], header_row.get('item5PercentageOfClass'))
    _add_path_text(root, ['formData', 'items1To7', 'item5', 'numberOfShares'], header_row.get('item5NumberOfShares'))
    _add_path_text(root, ['formData', 'items1To7', 'item5', 'transactionDesc'], header_row.get('item5TransactionDesc'))
    _add_path_text(root, ['formData', 'items1To7', 'item5', 'listOfShareholders'], header_row.get('item5ListOfShareholders'))
    _add_path_text(root, ['formData', 'items1To7', 'item5', 'date5PercentOwnership'], header_row.get('item5Date5PercentOwnership'))

    _add_path_text(root, ['formData', 'items1To7', 'item6', 'contractDescription'], header_row.get('item6ContractDescription'))

    _add_path_text(root, ['formData', 'items1To7', 'item7', 'filedExhibits'], header_row.get('item7FiledExhibits'))

    _add_path_text(root, ['formData', 'signatureInfo', 'commentText'], header_row.get('signatureCommentText'))

    for row in rows:
        if row.get('_table') != 'schedule13d_signature_person':
            continue
        sig_person = _ensure_path(
            _ensure_path(root, ['formData', 'signatureInfo']),
            ['signaturePerson'],
            create_leaf=True,
        )
        _add_path_text(sig_person, ['signatureReportingPerson'], row.get('signatureReportingPerson'))
        _add_path_text(sig_person, ['signatureDetails', 'signature'], row.get('signature'))
        _add_path_text(sig_person, ['signatureDetails', 'title'], row.get('title'))
        _add_path_text(sig_person, ['signatureDetails', 'date'], row.get('date'))

    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")