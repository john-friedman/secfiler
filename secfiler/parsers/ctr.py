import io
import xml.etree.ElementTree as ET

from ..utils import _add_created_with_comment, _add_path_text, _ensure_path


def construct_ctr(rows: list) -> bytes:
    root = ET.Element('edgarSubmission')
    root.set('xmlns', 'http://www.sec.gov/edgar/formc')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')

    header_row = next((r for r in rows if r.get('_table') == 'ctr'), rows[0] if rows else {})

    _add_path_text(root, ['headerData', 'submissionType'], header_row.get('submissionType'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'filerCik'], header_row.get('filerCik'))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'filerCcc'], header_row.get('filerCcc'))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], header_row.get('liveTestFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], header_row.get('confirmingCopyFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], header_row.get('returnCopyFlag'))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], header_row.get('overrideInternetFlag'))

    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'nameOfIssuer'], header_row.get('nameOfIssuer'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'legalStatusForm'], header_row.get('legalStatusForm'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'jurisdictionOrganization'], header_row.get('jurisdictionOrganization'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'dateIncorporation'], header_row.get('dateIncorporation'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'legalStatusOtherDesc'], header_row.get('legalStatusOtherDesc'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'com:street1'], header_row.get('street1'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'com:street2'], header_row.get('street2'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'com:city'], header_row.get('city'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'com:stateOrCountry'], header_row.get('stateOrCountry'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'com:zipCode'], header_row.get('zipCode'))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerWebsite'], header_row.get('issuerWebsite'))
    _add_path_text(root, ['formData', 'issuerInformation', 'isCoIssuer'], header_row.get('isCoIssuer'))

    for row in rows:
        if row.get('_table') != 'ctr_co_issuer':
            continue
        co = _ensure_path(
            _ensure_path(root, ['formData', 'issuerInformation', 'coIssuers']),
            ['coIssuerInfo'],
            create_leaf=True,
        )
        _add_path_text(co, ['nameOfCoIssuer'], row.get('nameOfCoIssuer'))
        _add_path_text(co, ['coIssuerCik'], row.get('coIssuerCik'))
        _add_path_text(co, ['coIssuerLegalStatus', 'legalStatusForm'], row.get('legalStatusForm'))
        _add_path_text(co, ['coIssuerLegalStatus', 'jurisdictionOrganization'], row.get('jurisdictionOrganization'))
        _add_path_text(co, ['coIssuerLegalStatus', 'dateIncorporation'], row.get('dateIncorporation'))
        _add_path_text(co, ['coIssuerLegalStatus', 'legalStatusOtherDesc'], row.get('legalStatusOtherDesc'))
        _add_path_text(co, ['coIssuerAddress', 'com:street1'], row.get('street1'))
        _add_path_text(co, ['coIssuerAddress', 'com:street2'], row.get('street2'))
        _add_path_text(co, ['coIssuerAddress', 'com:city'], row.get('city'))
        _add_path_text(co, ['coIssuerAddress', 'com:stateOrCountry'], row.get('stateOrCountry'))
        _add_path_text(co, ['coIssuerAddress', 'com:zipCode'], row.get('zipCode'))
        _add_path_text(co, ['coIssuerWebsite'], row.get('coIssuerWebsite'))

    _add_path_text(root, ['formData', 'signatureInfo', 'issuerSignature', 'issuer'], header_row.get('issuerSignature') or header_row.get('nameOfIssuer'))
    _add_path_text(root, ['formData', 'signatureInfo', 'issuerSignature', 'issuerSignature'], header_row.get('issuerSignatureText'))
    _add_path_text(root, ['formData', 'signatureInfo', 'issuerSignature', 'issuerTitle'], header_row.get('issuerTitle'))

    for row in rows:
        if row.get('_table') != 'ctr_signature_person':
            continue
        person = _ensure_path(
            _ensure_path(root, ['formData', 'signatureInfo', 'signaturePersons']),
            ['signaturePerson'],
            create_leaf=True,
        )
        _add_path_text(person, ['personSignature'], row.get('personSignature'))
        _add_path_text(person, ['personTitle'], row.get('personTitle'))
        _add_path_text(person, ['signatureDate'], row.get('signatureDate'))

    _add_created_with_comment(root)
    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')