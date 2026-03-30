import io
import xml.etree.ElementTree as ET

from ..utils import _add_created_with_comment, _add_path_text


def construct_sdr(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element('edgarSubmission')
    root.set('xmlns', 'http://www.sec.gov/edgar/sdrfiler')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')
    for row in normalized_rows:
        _add_path_text(root, ['headerData', 'submissionType'], row.get('submissionType'))
        _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], row.get('liveTestFlag'))
        _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'cik'], row.get('filerCik'))
        _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'ccc'], row.get('filerCcc'))
        _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], row.get('overrideInternetFlag'))
        _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], row.get('confirmingCopyFlag'))
        _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], row.get('returnCopyFlag'))
        _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'contactName'], row.get('contactName'))
        _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'contactPhoneNumber'], row.get('contactPhone'))
        _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'contactEmailAddress'], row.get('contactEmail'))
        _add_path_text(root, ['formData', 'generalInfo', 'applicantCategory', 'applicantType'], row.get('applicantType'))
        _add_path_text(root, ['formData', 'generalInfo', 'applicantCategory', 'applicantTypeOtherDesc'], row.get('applicantTypeOtherDesc'))
        _add_path_text(root, ['formData', 'generalInfo', 'applicantCategory', 'applcntTypeConfFlag'], row.get('applicantTypeConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessName', 'nameOnBusinessConfFlag'], row.get('businessNameConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'street1'], row.get('businessStreet1'))
        _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'city'], row.get('businessCity'))
        _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'stateOrCountry'], row.get('businessStateOrCountry'))
        _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'zipCode'], row.get('businessZipCode'))
        _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'businessAddressConfFlag'], row.get('businessAddressConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'business', 'previousBusinessName', 'previousBusinessNameConfFlag'], row.get('previousBusinessNameConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'corpOrgInfo', 'dateOfCoperationOrg'], row.get('dateOfIncorporation'))
        _add_path_text(root, ['formData', 'generalInfo', 'corpOrgInfo', 'stateCorperationOrOrg'], row.get('stateOfIncorporation'))
        _add_path_text(root, ['formData', 'generalInfo', 'corpOrgInfo', 'corprtnOrgConfFlag'], row.get('corpOrgConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'partnershipInfo', 'filingPrtnrConfFlag'], row.get('partnershipConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'officeConfFlag'], row.get('officeConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'officeName'], row.get('officeName'))
        _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'street1'], row.get('officeStreet1'))
        _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'city'], row.get('officeCity'))
        _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'stateOrCountry'], row.get('officeStateOrCountry'))
        _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'zipCode'], row.get('officeZipCode'))
        _add_path_text(root, ['formData', 'generalInfo', 'successor', 'successionFlag'], row.get('successionFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'successor', 'successionDateFlag'], row.get('successionDateFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'successor', 'predecessorNameAddressFlag'], row.get('predecessorNameAddressFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'successor', 'predecessorCikFlag'], row.get('predecessorCikFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'successor', 'successorConfFlag'], row.get('successorConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'assetClasses', 'assetClassesList'], row.get('assetClassesList'))
        _add_path_text(root, ['formData', 'generalInfo', 'assetClasses', 'assetClassesConfFlag'], row.get('assetClassesConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'functionDescription', 'functionDescriptionPerformed'], row.get('functionDescription'))
        _add_path_text(root, ['formData', 'generalInfo', 'functionDescription', 'functionDescriptionConfFlag'], row.get('functionDescriptionConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentName', 'applicantNameOrApplcblEntity'], row.get('consentApplicantName'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentName', 'personNameOrOfficerTitle'], row.get('consentPersonName'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentName', 'consentNameConfFlag'], row.get('consentNameConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'street1'], row.get('consentStreet1'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'city'], row.get('consentCity'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'stateCountry'], row.get('consentStateOrCountry'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'zipCode'], row.get('consentZipCode'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'consentAddressConfFlag'], row.get('consentAddressConfFlag'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentPhone', 'phone'], row.get('consentPhone'))
        _add_path_text(root, ['formData', 'generalInfo', 'consentPhone', 'consentPhoneConfFlag'], row.get('consentPhoneConfFlag'))
        _add_path_text(root, ['formData', 'principalInfo', 'applicantName'], row.get('principalApplicantName'))
        _add_path_text(root, ['formData', 'principalInfo', 'street1'], row.get('principalStreet1'))
        _add_path_text(root, ['formData', 'principalInfo', 'city'], row.get('principalCity'))
        _add_path_text(root, ['formData', 'principalInfo', 'stateOrCountry'], row.get('principalStateOrCountry'))
        _add_path_text(root, ['formData', 'principalInfo', 'zipCode'], row.get('principalZipCode'))
        _add_path_text(root, ['formData', 'principalInfo', 'prncpalConfFlag'], row.get('principalConfFlag'))
        _add_path_text(root, ['formData', 'principalInfo', 'amendedItemsList'], row.get('amendedItemsList'))
        _add_path_text(root, ['formData', 'signatureInfo', 'signatureApplicantName'], row.get('signatureApplicantName'))
        _add_path_text(root, ['formData', 'signatureInfo', 'signature'], row.get('signature'))
        _add_path_text(root, ['formData', 'signatureInfo', 'signatureTitle'], row.get('signatureTitle'))
        _add_path_text(root, ['formData', 'signatureInfo', 'signatureDate'], row.get('signatureDate'))
        _add_path_text(root, ['formData', 'signatureInfo', 'signatureConfflag'], row.get('signatureConfFlag'))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')




