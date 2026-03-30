import io
import xml.etree.ElementTree as ET

from ..utils import _add_created_with_comment, _add_path_text


def construct_maw(rows: list) -> bytes:
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
    root.set('xmlns', 'http://www.sec.gov/edgar/mawfiler')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common_ma')
    root.set('xmlns:com1', 'http://www.sec.gov/edgar/common')
    for row in normalized_rows:
        _add_path_text(root, ['formData', 'fileNumber'], row.get('fileNumber'))
        _add_path_text(root, ['formData', 'fullLegalName'], row.get('fullLegalName'))
        _add_path_text(root, ['formData', 'isAdvisoryContract'], row.get('isAdvisoryContract'))
        _add_path_text(root, ['formData', 'isBorrowedNotRepaid'], row.get('isBorrowedNotRepaid'))
        _add_path_text(root, ['formData', 'isReceivedAnyPrepaidFee'], row.get('isReceivedAnyPrepaidFee'))
        _add_path_text(root, ['formData', 'isUnsatisfiedJudgementsOrLiens'], row.get('isUnsatisfiedJudgementsOrLiens'))
        _add_path_text(root, ['headerData', 'submissionType'], row.get('submissionType'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'email'], row.get('email'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'title'], row.get('title'))
        _add_path_text(root, ['headerData', 'filerInfo', 'contactEmail'], row.get('contactEmail'))
        _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'name'], row.get('name'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'phoneNumber'], row.get('phoneNumber'))
        _add_path_text(root, ['formData', 'execution', 'muncipalAdvisoryFirm', 'date'], row.get('date'))
        _add_path_text(root, ['formData', 'execution', 'muncipalAdvisoryFirm', 'signature'], row.get('signature'))
        _add_path_text(root, ['formData', 'execution', 'muncipalAdvisoryFirm', 'signerName'], row.get('signerName'))
        _add_path_text(root, ['formData', 'execution', 'muncipalAdvisoryFirm', 'title'], row.get('muncipalAdvisoryFirmTitle'))
        _add_path_text(root, ['formData', 'execution', 'soleProprietor', 'date'], row.get('soleProprietorDate'))
        _add_path_text(root, ['formData', 'execution', 'soleProprietor', 'signature'], row.get('soleProprietorSignature'))
        _add_path_text(root, ['formData', 'execution', 'soleProprietor', 'signerName'], row.get('soleProprietorSignerName'))
        _add_path_text(root, ['formData', 'execution', 'soleProprietor', 'title'], row.get('soleProprietorTitle'))
        _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'phoneNumber'], row.get('contactPhoneNumber'))
        _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCcc'], row.get('filerCcc'))
        _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerFileNumber'], row.get('filerFileNumber'))
        _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerId'], row.get('filerId'))
        _add_path_text(root, ['headerData', 'filerInfo', 'notifications', 'internetNotificationAddress'], row.get('internetNotificationAddress'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'description'], row.get('description'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'name'], row.get('personInfoName'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'phoneNumber'], row.get('personInfoPhoneNumber'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'individualName', 'firstName'], row.get('firstName'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'individualName', 'lastName'], row.get('lastName'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'individualName', 'middleName'], row.get('middleName'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'stateOrCountry'], row.get('stateOrCountry'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'city'], row.get('city'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'street1'], row.get('street1'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'street2'], row.get('street2'))
        _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'zipCode'], row.get('zipCode'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'name'], row.get('nameAddressPhoneName'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'phoneNumber'], row.get('nameAddressPhonePhoneNumber'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'city'], row.get('addressCity'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'stateOrCountry'], row.get('addressStateOrCountry'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'street1'], row.get('addressStreet1'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'street2'], row.get('addressStreet2'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'zipCode'], row.get('addressZipCode'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'city'], row.get('addressInfoAddressCity'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'stateOrCountry'], row.get('addressInfoAddressStateOrCountry'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'street1'], row.get('addressInfoAddressStreet1'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'street2'], row.get('addressInfoAddressStreet2'))
        _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'zipCode'], row.get('addressInfoAddressZipCode'))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')




