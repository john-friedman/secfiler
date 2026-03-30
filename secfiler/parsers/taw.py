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

def construct_taw(rows: list) -> bytes:
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
    root.set('xmlns', 'http://www.sec.gov/edgar/ta/tawfiler')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')
    _add_path_text(root, ['formVersion'], _first_across_rows(normalized_rows, ['formVersion']))
    _add_path_text(root, ['schemaVersion'], _first_across_rows(normalized_rows, ['schemaVersion']))
    _add_path_text(root, ['submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['testOrLive'], _first_across_rows(normalized_rows, ['testOrLive']))
    _add_path_text(root, ['filer', 'cik'], _first_across_rows(normalized_rows, ['cik']))
    _add_path_text(root, ['filer', 'fileNumber'], _first_across_rows(normalized_rows, ['fileNumber']))
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['headerDataSubmissionType']))
    _add_path_text(root, ['registrant', 'entityName'], _first_across_rows(normalized_rows, ['entityName']))
    _add_path_text(root, ['registrant', 'futureTransferAgentFunctions'], _first_across_rows(normalized_rows, ['futureTransferAgentFunctions']))
    _add_path_text(root, ['registrant', 'lastActionDate'], _first_across_rows(normalized_rows, ['lastActionDate']))
    _add_path_text(root, ['registrant', 'withdrawalDescription'], _first_across_rows(normalized_rows, ['withdrawalDescription']))
    _add_path_text(root, ['signatureData', 'signatureDate'], _first_across_rows(normalized_rows, ['signatureDate']))
    _add_path_text(root, ['signatureData', 'signatureName'], _first_across_rows(normalized_rows, ['signatureName']))
    _add_path_text(root, ['signatureData', 'signaturePhoneNumber'], _first_across_rows(normalized_rows, ['signaturePhoneNumber']))
    _add_path_text(root, ['signatureData', 'signatureTitle'], _first_across_rows(normalized_rows, ['signatureTitle']))
    _add_path_text(root, ['formData', 'documentRetention', 'successorTransferAgents'], _first_across_rows(normalized_rows, ['successorTransferAgents']))
    _add_path_text(root, ['formData', 'legalAction', 'involved'], _first_across_rows(normalized_rows, ['involved']))
    _add_path_text(root, ['formData', 'legalAction', 'unsatisfiedJudgmentsInvolved'], _first_across_rows(normalized_rows, ['unsatisfiedJudgmentsInvolved']))
    _add_path_text(root, ['formData', 'registrant', 'entityName'], _first_across_rows(normalized_rows, ['registrantEntityName']))
    _add_path_text(root, ['formData', 'registrant', 'fileNumber'], _first_across_rows(normalized_rows, ['registrantFileNumber']))
    _add_path_text(root, ['formData', 'signatureData', 'signatureDate'], _first_across_rows(normalized_rows, ['signatureDataSignatureDate']))
    _add_path_text(root, ['formData', 'signatureData', 'signatureName'], _first_across_rows(normalized_rows, ['signatureDataSignatureName']))
    _add_path_text(root, ['formData', 'signatureData', 'signaturePhoneNumber'], _first_across_rows(normalized_rows, ['signatureDataSignaturePhoneNumber']))
    _add_path_text(root, ['formData', 'signatureData', 'signatureTitle'], _first_across_rows(normalized_rows, ['signatureDataSignatureTitle']))
    _add_path_text(root, ['formData', 'withdrawal', 'futureTransferAgentFunctions'], _first_across_rows(normalized_rows, ['withdrawalFutureTransferAgentFunctions']))
    _add_path_text(root, ['formData', 'withdrawal', 'lastActionDate'], _first_across_rows(normalized_rows, ['withdrawalLastActionDate']))
    _add_path_text(root, ['formData', 'withdrawal', 'withdrawalDescription'], _first_across_rows(normalized_rows, ['withdrawalWithdrawalDescription']))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], _first_across_rows(normalized_rows, ['liveTestFlag']))
    _add_path_text(root, ['registrant', 'businessAddress', 'city'], _first_across_rows(normalized_rows, ['city']))
    _add_path_text(root, ['registrant', 'businessAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['stateOrCountry']))
    _add_path_text(root, ['registrant', 'businessAddress', 'stateOrCountryCode'], _first_across_rows(normalized_rows, ['stateOrCountryCode']))
    _add_path_text(root, ['registrant', 'businessAddress', 'street1'], _first_across_rows(normalized_rows, ['street1']))
    _add_path_text(root, ['registrant', 'businessAddress', 'street2'], _first_across_rows(normalized_rows, ['street2']))
    _add_path_text(root, ['registrant', 'businessAddress', 'zipCode'], _first_across_rows(normalized_rows, ['zipCode']))
    _add_path_text(root, ['registrant', 'subjectOfProceedings', 'involved'], _first_across_rows(normalized_rows, ['subjectOfProceedingsInvolved']))
    _add_path_text(root, ['registrant', 'unsatisfiedJudgementsOrLiens', 'involved'], _first_across_rows(normalized_rows, ['unsatisfiedJudgementsOrLiensInvolved']))
    _add_path_text(root, ['tawDetails', 'tawCustodians', 'entityName'], _first_across_rows(normalized_rows, ['tawCustodiansEntityName']))
    _add_path_text(root, ['tawDetails', 'tawSuccessors', 'successorTransferAgents'], _first_across_rows(normalized_rows, ['tawSuccessorsSuccessorTransferAgents']))
    _add_path_text(root, ['formData', 'documentRetention', 'tawCustodians', 'entityName'], _first_across_rows(normalized_rows, ['documentRetentionTawCustodiansEntityName']))
    _add_path_text(root, ['tawDetails', 'tawSuccessors', 'tawSuccessorDetails', 'successorRegistered'], _first_across_rows(normalized_rows, ['successorRegistered']))
    _add_path_text(root, ['formData', 'registrant', 'businessAddress', 'city'], _first_across_rows(normalized_rows, ['businessAddressCity']))
    _add_path_text(root, ['formData', 'registrant', 'businessAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['businessAddressStateOrCountry']))
    _add_path_text(root, ['formData', 'registrant', 'businessAddress', 'street1'], _first_across_rows(normalized_rows, ['businessAddressStreet1']))
    _add_path_text(root, ['formData', 'registrant', 'businessAddress', 'street2'], _first_across_rows(normalized_rows, ['businessAddressStreet2']))
    _add_path_text(root, ['formData', 'registrant', 'businessAddress', 'zipCode'], _first_across_rows(normalized_rows, ['businessAddressZipCode']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], _first_across_rows(normalized_rows, ['returnCopyFlag']))
    _add_path_text(root, ['tawDetails', 'tawSuccessors', 'tawSuccessorDetails', 'entityName'], _first_across_rows(normalized_rows, ['tawSuccessorDetailsEntityName']))
    _add_path_text(root, ['tawDetails', 'tawCustodians', 'tawCustodianAddress', 'city'], _first_across_rows(normalized_rows, ['tawCustodianAddressCity']))
    _add_path_text(root, ['tawDetails', 'tawCustodians', 'tawCustodianAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['tawCustodianAddressStateOrCountry']))
    _add_path_text(root, ['tawDetails', 'tawCustodians', 'tawCustodianAddress', 'stateOrCountryCode'], _first_across_rows(normalized_rows, ['tawCustodianAddressStateOrCountryCode']))
    _add_path_text(root, ['tawDetails', 'tawCustodians', 'tawCustodianAddress', 'street1'], _first_across_rows(normalized_rows, ['tawCustodianAddressStreet1']))
    _add_path_text(root, ['tawDetails', 'tawCustodians', 'tawCustodianAddress', 'street2'], _first_across_rows(normalized_rows, ['tawCustodianAddressStreet2']))
    _add_path_text(root, ['tawDetails', 'tawCustodians', 'tawCustodianAddress', 'zipCode'], _first_across_rows(normalized_rows, ['tawCustodianAddressZipCode']))
    _add_path_text(root, ['formData', 'documentRetention', 'tawCustodians', 'tawCustodianAddress', 'city'], _first_across_rows(normalized_rows, ['tawCustodiansTawCustodianAddressCity']))
    _add_path_text(root, ['formData', 'documentRetention', 'tawCustodians', 'tawCustodianAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['tawCustodiansTawCustodianAddressStateOrCountry']))
    _add_path_text(root, ['formData', 'documentRetention', 'tawCustodians', 'tawCustodianAddress', 'street1'], _first_across_rows(normalized_rows, ['tawCustodiansTawCustodianAddressStreet1']))
    _add_path_text(root, ['formData', 'documentRetention', 'tawCustodians', 'tawCustodianAddress', 'zipCode'], _first_across_rows(normalized_rows, ['tawCustodiansTawCustodianAddressZipCode']))
    _add_path_text(root, ['tawDetails', 'tawSuccessors', 'tawSuccessorDetails', 'tawSuccessorAddress', 'city'], _first_across_rows(normalized_rows, ['tawSuccessorAddressCity']))
    _add_path_text(root, ['tawDetails', 'tawSuccessors', 'tawSuccessorDetails', 'tawSuccessorAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['tawSuccessorAddressStateOrCountry']))
    _add_path_text(root, ['tawDetails', 'tawSuccessors', 'tawSuccessorDetails', 'tawSuccessorAddress', 'street1'], _first_across_rows(normalized_rows, ['tawSuccessorAddressStreet1']))
    _add_path_text(root, ['tawDetails', 'tawSuccessors', 'tawSuccessorDetails', 'tawSuccessorAddress', 'zipCode'], _first_across_rows(normalized_rows, ['tawSuccessorAddressZipCode']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'ccc'], _first_across_rows(normalized_rows, ['ccc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'cik'], _first_across_rows(normalized_rows, ['filerCredentialsCik']))
    _add_path_text(root, ['tawDetails', 'tawSuccessors', 'tawSuccessorDetails', 'tawSuccessorAddress', 'stateOrCountryCode'], _first_across_rows(normalized_rows, ['tawSuccessorAddressStateOrCountryCode']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')


