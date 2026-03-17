import io
import xml.etree.ElementTree as ET
from ..constants import CREATED_WITH_SECFILER_COMMENT

def _add_created_with_comment(root: ET.Element) -> None:
    root.insert(0, ET.Comment(CREATED_WITH_SECFILER_COMMENT))



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


def _ensure_path(parent: ET.Element, tags: list[str], create_leaf: bool = False) -> ET.Element:
    current = parent
    total = len(tags)
    for idx, tag in enumerate(tags):
        found = None
        if not (create_leaf and idx == total - 1):
            for child in current:
                if child.tag == tag:
                    found = child
                    break
        if found is None:
            found = ET.SubElement(current, tag)
        current = found
    return current


def _add_path_text(root: ET.Element, tags: list[str], value) -> None:
    if not _is_present(value):
        return
    target = _ensure_path(root, tags)
    if not _is_present(target.text):
        target.text = _to_text(value)


def _add_path_attr(root: ET.Element, tags: list[str], attr_name: str, value) -> None:
    if not _is_present(value):
        return
    target = _ensure_path(root, tags)
    if attr_name not in target.attrib:
        target.set(attr_name, _to_text(value))


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
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], _first_across_rows(normalized_rows, ['liveTestFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'cik'], _first_across_rows(normalized_rows, ['filerCik']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'ccc'], _first_across_rows(normalized_rows, ['filerCcc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], _first_across_rows(normalized_rows, ['overrideInternetFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], _first_across_rows(normalized_rows, ['confirmingCopyFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], _first_across_rows(normalized_rows, ['returnCopyFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'contactName'], _first_across_rows(normalized_rows, ['contactName']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'contactPhoneNumber'], _first_across_rows(normalized_rows, ['contactPhone']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'contactEmailAddress'], _first_across_rows(normalized_rows, ['contactEmail']))
    _add_path_text(root, ['formData', 'generalInfo', 'applicantCategory', 'applicantType'], _first_across_rows(normalized_rows, ['applicantType']))
    _add_path_text(root, ['formData', 'generalInfo', 'applicantCategory', 'applicantTypeOtherDesc'], _first_across_rows(normalized_rows, ['applicantTypeOtherDesc']))
    _add_path_text(root, ['formData', 'generalInfo', 'applicantCategory', 'applcntTypeConfFlag'], _first_across_rows(normalized_rows, ['applicantTypeConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessName', 'nameOnBusinessConfFlag'], _first_across_rows(normalized_rows, ['businessNameConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'street1'], _first_across_rows(normalized_rows, ['businessStreet1']))
    _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'city'], _first_across_rows(normalized_rows, ['businessCity']))
    _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['businessStateOrCountry']))
    _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'zipCode'], _first_across_rows(normalized_rows, ['businessZipCode']))
    _add_path_text(root, ['formData', 'generalInfo', 'business', 'businessAddress', 'businessAddressConfFlag'], _first_across_rows(normalized_rows, ['businessAddressConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'business', 'previousBusinessName', 'previousBusinessNameConfFlag'], _first_across_rows(normalized_rows, ['previousBusinessNameConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'corpOrgInfo', 'dateOfCoperationOrg'], _first_across_rows(normalized_rows, ['dateOfIncorporation']))
    _add_path_text(root, ['formData', 'generalInfo', 'corpOrgInfo', 'stateCorperationOrOrg'], _first_across_rows(normalized_rows, ['stateOfIncorporation']))
    _add_path_text(root, ['formData', 'generalInfo', 'corpOrgInfo', 'corprtnOrgConfFlag'], _first_across_rows(normalized_rows, ['corpOrgConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'partnershipInfo', 'filingPrtnrConfFlag'], _first_across_rows(normalized_rows, ['partnershipConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'officeConfFlag'], _first_across_rows(normalized_rows, ['officeConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'officeName'], _first_across_rows(normalized_rows, ['officeName']))
    _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'street1'], _first_across_rows(normalized_rows, ['officeStreet1']))
    _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'city'], _first_across_rows(normalized_rows, ['officeCity']))
    _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'stateOrCountry'], _first_across_rows(normalized_rows, ['officeStateOrCountry']))
    _add_path_text(root, ['formData', 'generalInfo', 'officeInfo', 'office', 'zipCode'], _first_across_rows(normalized_rows, ['officeZipCode']))
    _add_path_text(root, ['formData', 'generalInfo', 'successor', 'successionFlag'], _first_across_rows(normalized_rows, ['successionFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'successor', 'successionDateFlag'], _first_across_rows(normalized_rows, ['successionDateFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'successor', 'predecessorNameAddressFlag'], _first_across_rows(normalized_rows, ['predecessorNameAddressFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'successor', 'predecessorCikFlag'], _first_across_rows(normalized_rows, ['predecessorCikFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'successor', 'successorConfFlag'], _first_across_rows(normalized_rows, ['successorConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'assetClasses', 'assetClassesList'], _first_across_rows(normalized_rows, ['assetClassesList']))
    _add_path_text(root, ['formData', 'generalInfo', 'assetClasses', 'assetClassesConfFlag'], _first_across_rows(normalized_rows, ['assetClassesConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'functionDescription', 'functionDescriptionPerformed'], _first_across_rows(normalized_rows, ['functionDescription']))
    _add_path_text(root, ['formData', 'generalInfo', 'functionDescription', 'functionDescriptionConfFlag'], _first_across_rows(normalized_rows, ['functionDescriptionConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentName', 'applicantNameOrApplcblEntity'], _first_across_rows(normalized_rows, ['consentApplicantName']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentName', 'personNameOrOfficerTitle'], _first_across_rows(normalized_rows, ['consentPersonName']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentName', 'consentNameConfFlag'], _first_across_rows(normalized_rows, ['consentNameConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'street1'], _first_across_rows(normalized_rows, ['consentStreet1']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'city'], _first_across_rows(normalized_rows, ['consentCity']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'stateCountry'], _first_across_rows(normalized_rows, ['consentStateOrCountry']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'zipCode'], _first_across_rows(normalized_rows, ['consentZipCode']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentAddress', 'consentAddressConfFlag'], _first_across_rows(normalized_rows, ['consentAddressConfFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentPhone', 'phone'], _first_across_rows(normalized_rows, ['consentPhone']))
    _add_path_text(root, ['formData', 'generalInfo', 'consentPhone', 'consentPhoneConfFlag'], _first_across_rows(normalized_rows, ['consentPhoneConfFlag']))
    _add_path_text(root, ['formData', 'principalInfo', 'applicantName'], _first_across_rows(normalized_rows, ['principalApplicantName']))
    _add_path_text(root, ['formData', 'principalInfo', 'street1'], _first_across_rows(normalized_rows, ['principalStreet1']))
    _add_path_text(root, ['formData', 'principalInfo', 'city'], _first_across_rows(normalized_rows, ['principalCity']))
    _add_path_text(root, ['formData', 'principalInfo', 'stateOrCountry'], _first_across_rows(normalized_rows, ['principalStateOrCountry']))
    _add_path_text(root, ['formData', 'principalInfo', 'zipCode'], _first_across_rows(normalized_rows, ['principalZipCode']))
    _add_path_text(root, ['formData', 'principalInfo', 'prncpalConfFlag'], _first_across_rows(normalized_rows, ['principalConfFlag']))
    _add_path_text(root, ['formData', 'principalInfo', 'amendedItemsList'], _first_across_rows(normalized_rows, ['amendedItemsList']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signatureApplicantName'], _first_across_rows(normalized_rows, ['signatureApplicantName']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signature'], _first_across_rows(normalized_rows, ['signature']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signatureTitle'], _first_across_rows(normalized_rows, ['signatureTitle']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signatureDate'], _first_across_rows(normalized_rows, ['signatureDate']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signatureConfflag'], _first_across_rows(normalized_rows, ['signatureConfFlag']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')
