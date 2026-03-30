import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text, _ensure_path



def _is_present(value) -> bool:
    if value is None:
        return False
    if isinstance(value, str):
        return bool(value.strip())
    if isinstance(value, (list, tuple, set)):
        return any(_is_present(item) for item in value)
    return True


def _to_text(value) -> str:
    if isinstance(value, bool):
        return "true" if value else "false"
    return str(value)


def _normalize_values(value) -> list[str]:
    if value is None:
        return []
    if isinstance(value, (list, tuple, set)):
        out = []
        for item in value:
            out.extend(_normalize_values(item))
        return out

    text = _to_text(value)
    if text == "":
        return [""]

    stripped = text.strip()
    if not stripped:
        return []

    if any(token in text for token in ("|", ";", "\n", "\r")):
        normalized = (
            text.replace("\r\n", "\n")
            .replace("\r", "\n")
            .replace(";", "|")
            .replace("\n", "|")
        )
        return [part.strip() for part in normalized.split("|") if part.strip()]

    return [text]


def _first_across_rows(rows: list[dict], keys: list[str]):
    for row in rows:
        for key in keys:
            value = row.get(key)
            if _is_present(value):
                return value
    return None





def _collect_records(rows: list[dict], key_names: list[str]) -> list[dict]:
    records = []
    for row in rows:
        value_lists = {k: _normalize_values(row.get(k)) for k in key_names}
        max_items = max((len(v) for v in value_lists.values()), default=0)
        if max_items == 0:
            continue
        for i in range(max_items):
            record = {}
            for key, values in value_lists.items():
                if not values:
                    record[key] = None
                elif len(values) == 1:
                    record[key] = values[0]
                elif i < len(values):
                    record[key] = values[i]
                else:
                    record[key] = None
            if any(_is_present(v) for v in record.values()):
                records.append(record)
    return records

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
    _add_path_text(root, ['formData', 'fileNumber'], _first_across_rows(normalized_rows, ['fileNumber']))
    _add_path_text(root, ['formData', 'fullLegalName'], _first_across_rows(normalized_rows, ['fullLegalName']))
    _add_path_text(root, ['formData', 'isAdvisoryContract'], _first_across_rows(normalized_rows, ['isAdvisoryContract']))
    _add_path_text(root, ['formData', 'isBorrowedNotRepaid'], _first_across_rows(normalized_rows, ['isBorrowedNotRepaid']))
    _add_path_text(root, ['formData', 'isReceivedAnyPrepaidFee'], _first_across_rows(normalized_rows, ['isReceivedAnyPrepaidFee']))
    _add_path_text(root, ['formData', 'isUnsatisfiedJudgementsOrLiens'], _first_across_rows(normalized_rows, ['isUnsatisfiedJudgementsOrLiens']))
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'email'], _first_across_rows(normalized_rows, ['email']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'title'], _first_across_rows(normalized_rows, ['title']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contactEmail'], _first_across_rows(normalized_rows, ['contactEmail']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'name'], _first_across_rows(normalized_rows, ['name']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'phoneNumber'], _first_across_rows(normalized_rows, ['phoneNumber']))
    _add_path_text(root, ['formData', 'execution', 'muncipalAdvisoryFirm', 'date'], _first_across_rows(normalized_rows, ['date']))
    _add_path_text(root, ['formData', 'execution', 'muncipalAdvisoryFirm', 'signature'], _first_across_rows(normalized_rows, ['signature']))
    _add_path_text(root, ['formData', 'execution', 'muncipalAdvisoryFirm', 'signerName'], _first_across_rows(normalized_rows, ['signerName']))
    _add_path_text(root, ['formData', 'execution', 'muncipalAdvisoryFirm', 'title'], _first_across_rows(normalized_rows, ['muncipalAdvisoryFirmTitle']))
    _add_path_text(root, ['formData', 'execution', 'soleProprietor', 'date'], _first_across_rows(normalized_rows, ['soleProprietorDate']))
    _add_path_text(root, ['formData', 'execution', 'soleProprietor', 'signature'], _first_across_rows(normalized_rows, ['soleProprietorSignature']))
    _add_path_text(root, ['formData', 'execution', 'soleProprietor', 'signerName'], _first_across_rows(normalized_rows, ['soleProprietorSignerName']))
    _add_path_text(root, ['formData', 'execution', 'soleProprietor', 'title'], _first_across_rows(normalized_rows, ['soleProprietorTitle']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'phoneNumber'], _first_across_rows(normalized_rows, ['contactPhoneNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCcc'], _first_across_rows(normalized_rows, ['filerCcc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerFileNumber'], _first_across_rows(normalized_rows, ['filerFileNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerId'], _first_across_rows(normalized_rows, ['filerId']))
    _add_path_text(root, ['headerData', 'filerInfo', 'notifications', 'internetNotificationAddress'], _first_across_rows(normalized_rows, ['internetNotificationAddress']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'description'], _first_across_rows(normalized_rows, ['description']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'name'], _first_across_rows(normalized_rows, ['personInfoName']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'phoneNumber'], _first_across_rows(normalized_rows, ['personInfoPhoneNumber']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'individualName', 'firstName'], _first_across_rows(normalized_rows, ['firstName']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'individualName', 'lastName'], _first_across_rows(normalized_rows, ['lastName']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'individualName', 'middleName'], _first_across_rows(normalized_rows, ['middleName']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'stateOrCountry'], _first_across_rows(normalized_rows, ['stateOrCountry']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'city'], _first_across_rows(normalized_rows, ['city']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'street1'], _first_across_rows(normalized_rows, ['street1']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'street2'], _first_across_rows(normalized_rows, ['street2']))
    _add_path_text(root, ['formData', 'contactPersonInfo', 'nameAddressPhone', 'addressInfo', 'address', 'zipCode'], _first_across_rows(normalized_rows, ['zipCode']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'name'], _first_across_rows(normalized_rows, ['nameAddressPhoneName']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'phoneNumber'], _first_across_rows(normalized_rows, ['nameAddressPhonePhoneNumber']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'city'], _first_across_rows(normalized_rows, ['addressCity']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'stateOrCountry'], _first_across_rows(normalized_rows, ['addressStateOrCountry']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'street1'], _first_across_rows(normalized_rows, ['addressStreet1']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'street2'], _first_across_rows(normalized_rows, ['addressStreet2']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'personInfo', 'addressInfo', 'address', 'zipCode'], _first_across_rows(normalized_rows, ['addressZipCode']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'city'], _first_across_rows(normalized_rows, ['addressInfoAddressCity']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'stateOrCountry'], _first_across_rows(normalized_rows, ['addressInfoAddressStateOrCountry']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'street1'], _first_across_rows(normalized_rows, ['addressInfoAddressStreet1']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'street2'], _first_across_rows(normalized_rows, ['addressInfoAddressStreet2']))
    _add_path_text(root, ['formData', 'booksAndRecords', 'personLocation', 'locationInfo', 'nameAddressPhone', 'addressInfo', 'address', 'zipCode'], _first_across_rows(normalized_rows, ['addressInfoAddressZipCode']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')


