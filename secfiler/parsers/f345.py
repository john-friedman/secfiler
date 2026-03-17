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



_SECTION_HINT_KEYS = [
    "table",
    "tableName",
    "sourceTable",
    "_table",
    "section",
    "mapping",
    "group",
    "recordType",
    "rowType",
]


def _normalize_token(value: str) -> str:
    return "".join(ch for ch in str(value).lower() if ch.isalnum())


def _row_matches_section(row: dict, section_name: str) -> bool:
    section_token = _normalize_token(section_name)
    if not section_token:
        return False
    for key in _SECTION_HINT_KEYS:
        value = row.get(key)
        if not _is_present(value):
            continue
        if section_token in _normalize_token(value):
            return True
    return False


def _rows_for_section(rows: list[dict], section_name: str, marker_keys: list[str]) -> list[dict]:
    matched = [row for row in rows if _row_matches_section(row, section_name)]
    if matched:
        return matched
    # Signature sections share identical keys; without section hints they collide.
    # Only build table-level signatures from explicitly tagged rows.
    if section_name in {"345_derivative_table_signature", "345_non_derivative_table_signature"}:
        return []
    has_section_hints = any(
        any(_is_present(row.get(key)) for key in _SECTION_HINT_KEYS)
        for row in rows
    )
    if has_section_hints:
        return []
    return [row for row in rows if any(_is_present(row.get(key)) for key in marker_keys)]

def construct_345(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element('ownershipDocument')
    _add_path_text(root, ['aff10b5One'], _first_across_rows(normalized_rows, ['aff10B5One']))
    _add_path_text(root, ['notSubjectToSection16'], _first_across_rows(normalized_rows, ['notSubjectToSection16']))
    _add_path_text(root, ['noSecuritiesOwned'], _first_across_rows(normalized_rows, ['noSecuritiesOwned']))
    _add_path_text(root, ['documentType'], _first_across_rows(normalized_rows, ['documentType']))
    _add_path_text(root, ['form3HoldingsReported'], _first_across_rows(normalized_rows, ['form3HoldingsReported']))
    _add_path_text(root, ['form4TransactionsReported'], _first_across_rows(normalized_rows, ['form4TransactionsReported']))
    _add_path_text(root, ['periodOfReport'], _first_across_rows(normalized_rows, ['periodOfReport']))
    _add_path_text(root, ['remarks'], _first_across_rows(normalized_rows, ['remarks']))
    _add_path_text(root, ['schemaVersion'], _first_across_rows(normalized_rows, ['schemaVersion']))
    _add_path_text(root, ['issuer', 'issuerTradingSymbol'], _first_across_rows(normalized_rows, ['issuerTradingSymbol']))
    _add_path_text(root, ['issuer', 'issuerCik'], _first_across_rows(normalized_rows, ['issuerCik']))
    _add_path_text(root, ['issuer', 'issuerName'], _first_across_rows(normalized_rows, ['issuerName']))

    # section: 345_footnote
    _section_rows = _rows_for_section(normalized_rows, '345_footnote', ['footnoteText', 'footnoteId'])
    _records = _collect_records(_section_rows, ['footnoteText', 'footnoteId'])
    for _record in _records:
        _parent = _ensure_path(root, ['footnotes', 'footnote'], create_leaf=True)
        _add_path_text(_parent, [], _record.get('footnoteText'))
        _add_path_attr(_parent, [], 'id', _record.get('footnoteId'))

    # section: 345_owner_signature
    _section_rows = _rows_for_section(normalized_rows, '345_owner_signature', ['signatureDate', 'signatureName'])
    _records = _collect_records(_section_rows, ['signatureDate', 'signatureName'])
    for _record in _records:
        _parent = _ensure_path(root, ['ownerSignature'], create_leaf=True)
        _add_path_text(_parent, ['signatureDate'], _record.get('signatureDate'))
        _add_path_text(_parent, ['signatureName'], _record.get('signatureName'))

    # section: 345_derivative_security
    _section_rows = _rows_for_section(normalized_rows, '345_derivative_security', ['value', 'equitySwapInvolved', 'transactionCode', 'securityTitleValue', 'exerciseDateValue', 'expirationDateValue', 'transactionFormType', 'transactionDateValue', 'deemedExecutionDateValue', 'securityTitleFootnoteIdId', 'transactionTimelinessValue', 'underlyingSecurityTitleValue', 'underlyingSecuritySharesValue', 'exerciseDateFootnoteIdId', 'expirationDateFootnoteIdId', 'directOrIndirectOwnershipValue', 'natureOfOwnershipValue', 'sharesOwnedFollowingTransactionValue', 'transactionAcquiredDisposedCodeValue', 'transactionSharesValue', 'transactionValueValue', 'transactionCodingFootnoteIdId', 'transactionDateFootnoteIdId', 'id', 'footnoteIdId', 'valueOwnedFollowingTransactionValue', 'underlyingSecurityValueValue', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'transactionValueFootnoteIdId', 'underlyingSecuritySharesFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'transactionAcquiredDisposedCodeFootnoteIdId', 'transactionSharesFootnoteIdId', 'underlyingSecurityTitleFootnoteIdId'])
    _records = _collect_records(_section_rows, ['value', 'equitySwapInvolved', 'transactionCode', 'securityTitleValue', 'exerciseDateValue', 'expirationDateValue', 'transactionFormType', 'transactionDateValue', 'deemedExecutionDateValue', 'securityTitleFootnoteIdId', 'transactionTimelinessValue', 'underlyingSecurityTitleValue', 'underlyingSecuritySharesValue', 'exerciseDateFootnoteIdId', 'expirationDateFootnoteIdId', 'directOrIndirectOwnershipValue', 'natureOfOwnershipValue', 'sharesOwnedFollowingTransactionValue', 'transactionAcquiredDisposedCodeValue', 'transactionSharesValue', 'transactionValueValue', 'transactionCodingFootnoteIdId', 'transactionDateFootnoteIdId', 'id', 'footnoteIdId', 'valueOwnedFollowingTransactionValue', 'underlyingSecurityValueValue', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'transactionValueFootnoteIdId', 'underlyingSecuritySharesFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'transactionAcquiredDisposedCodeFootnoteIdId', 'transactionSharesFootnoteIdId', 'underlyingSecurityTitleFootnoteIdId'])
    for _record in _records:
        _parent = _ensure_path(root, ['derivativeSecurity'], create_leaf=True)
        _add_path_text(_parent, ['conversionOrExercisePrice', 'value'], _record.get('value'))
        _add_path_text(_parent, ['transactionCoding', 'equitySwapInvolved'], _record.get('equitySwapInvolved'))
        _add_path_text(_parent, ['transactionCoding', 'transactionCode'], _record.get('transactionCode'))
        _add_path_text(_parent, ['securityTitle', 'value'], _record.get('securityTitleValue'))
        _add_path_text(_parent, ['exerciseDate', 'value'], _record.get('exerciseDateValue'))
        _add_path_text(_parent, ['expirationDate', 'value'], _record.get('expirationDateValue'))
        _add_path_text(_parent, ['transactionCoding', 'transactionFormType'], _record.get('transactionFormType'))
        _add_path_text(_parent, ['transactionDate', 'value'], _record.get('transactionDateValue'))
        _add_path_text(_parent, ['deemedExecutionDate', 'value'], _record.get('deemedExecutionDateValue'))
        _add_path_attr(_parent, ['securityTitle', 'footnoteId'], 'id', _record.get('securityTitleFootnoteIdId'))
        _add_path_text(_parent, ['transactionTimeliness', 'value'], _record.get('transactionTimelinessValue'))
        _add_path_text(_parent, ['underlyingSecurity', 'underlyingSecurityTitle', 'value'], _record.get('underlyingSecurityTitleValue'))
        _add_path_text(_parent, ['underlyingSecurity', 'underlyingSecurityShares', 'value'], _record.get('underlyingSecuritySharesValue'))
        _add_path_attr(_parent, ['exerciseDate', 'footnoteId'], 'id', _record.get('exerciseDateFootnoteIdId'))
        _add_path_attr(_parent, ['expirationDate', 'footnoteId'], 'id', _record.get('expirationDateFootnoteIdId'))
        _add_path_text(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], _record.get('directOrIndirectOwnershipValue'))
        _add_path_text(_parent, ['ownershipNature', 'natureOfOwnership', 'value'], _record.get('natureOfOwnershipValue'))
        _add_path_text(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], _record.get('sharesOwnedFollowingTransactionValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'value'], _record.get('transactionAcquiredDisposedCodeValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionShares', 'value'], _record.get('transactionSharesValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionValue', 'value'], _record.get('transactionValueValue'))
        _add_path_attr(_parent, ['transactionCoding', 'footnoteId'], 'id', _record.get('transactionCodingFootnoteIdId'))
        _add_path_attr(_parent, ['transactionDate', 'footnoteId'], 'id', _record.get('transactionDateFootnoteIdId'))
        _add_path_attr(_parent, ['conversionOrExercisePrice', 'footnoteId'], 'id', _record.get('id'))
        _add_path_attr(_parent, ['deemedExecutionDate', 'footnoteId'], 'id', _record.get('footnoteIdId'))
        _add_path_text(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'value'], _record.get('valueOwnedFollowingTransactionValue'))
        _add_path_text(_parent, ['underlyingSecurity', 'underlyingSecurityValue', 'value'], _record.get('underlyingSecurityValueValue'))
        _add_path_attr(_parent, ['ownershipNature', 'natureOfOwnership', 'footnoteId'], 'id', _record.get('natureOfOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('sharesOwnedFollowingTransactionFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionValue', 'footnoteId'], 'id', _record.get('transactionValueFootnoteIdId'))
        _add_path_attr(_parent, ['underlyingSecurity', 'underlyingSecurityShares', 'footnoteId'], 'id', _record.get('underlyingSecuritySharesFootnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'footnoteId'], 'id', _record.get('directOrIndirectOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'footnoteId'], 'id', _record.get('transactionAcquiredDisposedCodeFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionShares', 'footnoteId'], 'id', _record.get('transactionSharesFootnoteIdId'))
        _add_path_attr(_parent, ['underlyingSecurity', 'underlyingSecurityTitle', 'footnoteId'], 'id', _record.get('underlyingSecurityTitleFootnoteIdId'))

    # section: 345_non_derivative_security
    _section_rows = _rows_for_section(normalized_rows, '345_non_derivative_security', ['value', 'equitySwapInvolved', 'transactionCode', 'transactionFormType', 'securityTitleValue', 'transactionDateValue', 'transactionTimelinessValue', 'footnoteIdId', 'id', 'directOrIndirectOwnershipValue', 'natureOfOwnershipValue', 'sharesOwnedFollowingTransactionValue', 'valueOwnedFollowingTransactionValue', 'transactionDateFootnoteIdId', 'transactionSharesValue', 'transactionAcquiredDisposedCodeValue', 'transactionValueValue', 'transactionCodingFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'transactionValueFootnoteIdId', 'transactionAcquiredDisposedCodeFootnoteIdId', 'transactionSharesFootnoteIdId'])
    _records = _collect_records(_section_rows, ['value', 'equitySwapInvolved', 'transactionCode', 'transactionFormType', 'securityTitleValue', 'transactionDateValue', 'transactionTimelinessValue', 'footnoteIdId', 'id', 'directOrIndirectOwnershipValue', 'natureOfOwnershipValue', 'sharesOwnedFollowingTransactionValue', 'valueOwnedFollowingTransactionValue', 'transactionDateFootnoteIdId', 'transactionSharesValue', 'transactionAcquiredDisposedCodeValue', 'transactionValueValue', 'transactionCodingFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'transactionValueFootnoteIdId', 'transactionAcquiredDisposedCodeFootnoteIdId', 'transactionSharesFootnoteIdId'])
    for _record in _records:
        _parent = _ensure_path(root, ['nonDerivativeSecurity'], create_leaf=True)
        _add_path_text(_parent, ['deemedExecutionDate', 'value'], _record.get('value'))
        _add_path_text(_parent, ['transactionCoding', 'equitySwapInvolved'], _record.get('equitySwapInvolved'))
        _add_path_text(_parent, ['transactionCoding', 'transactionCode'], _record.get('transactionCode'))
        _add_path_text(_parent, ['transactionCoding', 'transactionFormType'], _record.get('transactionFormType'))
        _add_path_text(_parent, ['securityTitle', 'value'], _record.get('securityTitleValue'))
        _add_path_text(_parent, ['transactionDate', 'value'], _record.get('transactionDateValue'))
        _add_path_text(_parent, ['transactionTimeliness', 'value'], _record.get('transactionTimelinessValue'))
        _add_path_attr(_parent, ['securityTitle', 'footnoteId'], 'id', _record.get('footnoteIdId'))
        _add_path_attr(_parent, ['deemedExecutionDate', 'footnoteId'], 'id', _record.get('id'))
        _add_path_text(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], _record.get('directOrIndirectOwnershipValue'))
        _add_path_text(_parent, ['ownershipNature', 'natureOfOwnership', 'value'], _record.get('natureOfOwnershipValue'))
        _add_path_text(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], _record.get('sharesOwnedFollowingTransactionValue'))
        _add_path_text(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'value'], _record.get('valueOwnedFollowingTransactionValue'))
        _add_path_attr(_parent, ['transactionDate', 'footnoteId'], 'id', _record.get('transactionDateFootnoteIdId'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionShares', 'value'], _record.get('transactionSharesValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'value'], _record.get('transactionAcquiredDisposedCodeValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionValue', 'value'], _record.get('transactionValueValue'))
        _add_path_attr(_parent, ['transactionCoding', 'footnoteId'], 'id', _record.get('transactionCodingFootnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'footnoteId'], 'id', _record.get('directOrIndirectOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'natureOfOwnership', 'footnoteId'], 'id', _record.get('natureOfOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('sharesOwnedFollowingTransactionFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionValue', 'footnoteId'], 'id', _record.get('transactionValueFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'footnoteId'], 'id', _record.get('transactionAcquiredDisposedCodeFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionShares', 'footnoteId'], 'id', _record.get('transactionSharesFootnoteIdId'))

    # section: 345_reporting_owner
    _section_rows = _rows_for_section(normalized_rows, '345_reporting_owner', ['rptOwnerCik', 'rptOwnerName', 'rptOwnerCity', 'rptOwnerState', 'rptOwnerStreet2', 'rptOwnerZipCode', 'rptOwnerStreet1', 'rptOwnerStateDescription', 'isDirector', 'isOfficer', 'isOther', 'isTenPercentOwner', 'officerTitle', 'otherText'])
    _records = _collect_records(_section_rows, ['rptOwnerCik', 'rptOwnerName', 'rptOwnerCity', 'rptOwnerState', 'rptOwnerStreet2', 'rptOwnerZipCode', 'rptOwnerStreet1', 'rptOwnerStateDescription', 'isDirector', 'isOfficer', 'isOther', 'isTenPercentOwner', 'officerTitle', 'otherText'])
    for _record in _records:
        _parent = _ensure_path(root, ['reportingOwner'], create_leaf=True)
        _add_path_text(_parent, ['reportingOwnerId', 'rptOwnerCik'], _record.get('rptOwnerCik'))
        _add_path_text(_parent, ['reportingOwnerId', 'rptOwnerName'], _record.get('rptOwnerName'))
        _add_path_text(_parent, ['reportingOwnerAddress', 'rptOwnerCity'], _record.get('rptOwnerCity'))
        _add_path_text(_parent, ['reportingOwnerAddress', 'rptOwnerState'], _record.get('rptOwnerState'))
        _add_path_text(_parent, ['reportingOwnerAddress', 'rptOwnerStreet2'], _record.get('rptOwnerStreet2'))
        _add_path_text(_parent, ['reportingOwnerAddress', 'rptOwnerZipCode'], _record.get('rptOwnerZipCode'))
        _add_path_text(_parent, ['reportingOwnerAddress', 'rptOwnerStreet1'], _record.get('rptOwnerStreet1'))
        _add_path_text(_parent, ['reportingOwnerAddress', 'rptOwnerStateDescription'], _record.get('rptOwnerStateDescription'))
        _add_path_text(_parent, ['reportingOwnerRelationship', 'isDirector'], _record.get('isDirector'))
        _add_path_text(_parent, ['reportingOwnerRelationship', 'isOfficer'], _record.get('isOfficer'))
        _add_path_text(_parent, ['reportingOwnerRelationship', 'isOther'], _record.get('isOther'))
        _add_path_text(_parent, ['reportingOwnerRelationship', 'isTenPercentOwner'], _record.get('isTenPercentOwner'))
        _add_path_text(_parent, ['reportingOwnerRelationship', 'officerTitle'], _record.get('officerTitle'))
        _add_path_text(_parent, ['reportingOwnerRelationship', 'otherText'], _record.get('otherText'))

    # section: 345_derivative_holding
    _section_rows = _rows_for_section(normalized_rows, '345_derivative_holding', ['value', 'exerciseDateValue', 'expirationDateValue', 'securityTitleValue', 'transactionFormType', 'id', 'footnoteIdId', 'expirationDateFootnoteIdId', 'directOrIndirectOwnershipValue', 'natureOfOwnershipValue', 'sharesOwnedFollowingTransactionValue', 'valueOwnedFollowingTransactionValue', 'securityTitleFootnoteIdId', 'underlyingSecuritySharesValue', 'underlyingSecurityTitleValue', 'underlyingSecurityValueValue', 'transactionCodingFootnoteIdId', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'underlyingSecuritySharesFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'valueOwnedFollowingTransactionFootnoteIdId', 'underlyingSecurityTitleFootnoteIdId', 'underlyingSecurityValueFootnoteIdId'])
    _records = _collect_records(_section_rows, ['value', 'exerciseDateValue', 'expirationDateValue', 'securityTitleValue', 'transactionFormType', 'id', 'footnoteIdId', 'expirationDateFootnoteIdId', 'directOrIndirectOwnershipValue', 'natureOfOwnershipValue', 'sharesOwnedFollowingTransactionValue', 'valueOwnedFollowingTransactionValue', 'securityTitleFootnoteIdId', 'underlyingSecuritySharesValue', 'underlyingSecurityTitleValue', 'underlyingSecurityValueValue', 'transactionCodingFootnoteIdId', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'underlyingSecuritySharesFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'valueOwnedFollowingTransactionFootnoteIdId', 'underlyingSecurityTitleFootnoteIdId', 'underlyingSecurityValueFootnoteIdId'])
    for _record in _records:
        _parent = _ensure_path(root, ['derivativeTable', 'derivativeHolding'], create_leaf=True)
        _add_path_text(_parent, ['conversionOrExercisePrice', 'value'], _record.get('value'))
        _add_path_text(_parent, ['exerciseDate', 'value'], _record.get('exerciseDateValue'))
        _add_path_text(_parent, ['expirationDate', 'value'], _record.get('expirationDateValue'))
        _add_path_text(_parent, ['securityTitle', 'value'], _record.get('securityTitleValue'))
        _add_path_text(_parent, ['transactionCoding', 'transactionFormType'], _record.get('transactionFormType'))
        _add_path_attr(_parent, ['conversionOrExercisePrice', 'footnoteId'], 'id', _record.get('id'))
        _add_path_attr(_parent, ['exerciseDate', 'footnoteId'], 'id', _record.get('footnoteIdId'))
        _add_path_attr(_parent, ['expirationDate', 'footnoteId'], 'id', _record.get('expirationDateFootnoteIdId'))
        _add_path_text(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], _record.get('directOrIndirectOwnershipValue'))
        _add_path_text(_parent, ['ownershipNature', 'natureOfOwnership', 'value'], _record.get('natureOfOwnershipValue'))
        _add_path_text(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], _record.get('sharesOwnedFollowingTransactionValue'))
        _add_path_text(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'value'], _record.get('valueOwnedFollowingTransactionValue'))
        _add_path_attr(_parent, ['securityTitle', 'footnoteId'], 'id', _record.get('securityTitleFootnoteIdId'))
        _add_path_text(_parent, ['underlyingSecurity', 'underlyingSecurityShares', 'value'], _record.get('underlyingSecuritySharesValue'))
        _add_path_text(_parent, ['underlyingSecurity', 'underlyingSecurityTitle', 'value'], _record.get('underlyingSecurityTitleValue'))
        _add_path_text(_parent, ['underlyingSecurity', 'underlyingSecurityValue', 'value'], _record.get('underlyingSecurityValueValue'))
        _add_path_attr(_parent, ['transactionCoding', 'footnoteId'], 'id', _record.get('transactionCodingFootnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'natureOfOwnership', 'footnoteId'], 'id', _record.get('natureOfOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('sharesOwnedFollowingTransactionFootnoteIdId'))
        _add_path_attr(_parent, ['underlyingSecurity', 'underlyingSecurityShares', 'footnoteId'], 'id', _record.get('underlyingSecuritySharesFootnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'footnoteId'], 'id', _record.get('directOrIndirectOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('valueOwnedFollowingTransactionFootnoteIdId'))
        _add_path_attr(_parent, ['underlyingSecurity', 'underlyingSecurityTitle', 'footnoteId'], 'id', _record.get('underlyingSecurityTitleFootnoteIdId'))
        _add_path_attr(_parent, ['underlyingSecurity', 'underlyingSecurityValue', 'footnoteId'], 'id', _record.get('underlyingSecurityValueFootnoteIdId'))

    # section: 345_non_derivative_holding
    _section_rows = _rows_for_section(normalized_rows, '345_non_derivative_holding', ['value', 'transactionFormType', 'sharesOwnedFollowingTransactionValue', 'directOrIndirectOwnershipValue', 'natureOfOwnershipValue', 'id', 'footnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'valueOwnedFollowingTransactionValue', 'valueOwnedFollowingTransactionFootnoteIdId'])
    _records = _collect_records(_section_rows, ['value', 'transactionFormType', 'sharesOwnedFollowingTransactionValue', 'directOrIndirectOwnershipValue', 'natureOfOwnershipValue', 'id', 'footnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'valueOwnedFollowingTransactionValue', 'valueOwnedFollowingTransactionFootnoteIdId'])
    for _record in _records:
        _parent = _ensure_path(root, ['nonDerivativeTable', 'nonDerivativeHolding'], create_leaf=True)
        _add_path_text(_parent, ['securityTitle', 'value'], _record.get('value'))
        _add_path_text(_parent, ['transactionCoding', 'transactionFormType'], _record.get('transactionFormType'))
        _add_path_text(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], _record.get('sharesOwnedFollowingTransactionValue'))
        _add_path_text(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], _record.get('directOrIndirectOwnershipValue'))
        _add_path_text(_parent, ['ownershipNature', 'natureOfOwnership', 'value'], _record.get('natureOfOwnershipValue'))
        _add_path_attr(_parent, ['securityTitle', 'footnoteId'], 'id', _record.get('id'))
        _add_path_attr(_parent, ['transactionCoding', 'footnoteId'], 'id', _record.get('footnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'footnoteId'], 'id', _record.get('directOrIndirectOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'natureOfOwnership', 'footnoteId'], 'id', _record.get('natureOfOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('sharesOwnedFollowingTransactionFootnoteIdId'))
        _add_path_text(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'value'], _record.get('valueOwnedFollowingTransactionValue'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('valueOwnedFollowingTransactionFootnoteIdId'))

    # section: 345_derivative_footnote
    _section_rows = _rows_for_section(normalized_rows, '345_derivative_footnote', ['footnoteText', 'id'])
    _records = _collect_records(_section_rows, ['footnoteText', 'id'])
    for _record in _records:
        _parent = _ensure_path(root, ['derivativeTable', 'footnotes', 'footnote'], create_leaf=True)
        _add_path_text(_parent, [], _record.get('footnoteText'))
        _add_path_attr(_parent, [], 'id', _record.get('id'))

    # section: 345_derivative_table_signature
    _section_rows = _rows_for_section(normalized_rows, '345_derivative_table_signature', ['signatureDate', 'signatureName'])
    _records = _collect_records(_section_rows, ['signatureDate', 'signatureName'])
    for _record in _records:
        _parent = _ensure_path(root, ['derivativeTable', 'ownerSignature'], create_leaf=True)
        _add_path_text(_parent, ['signatureDate'], _record.get('signatureDate'))
        _add_path_text(_parent, ['signatureName'], _record.get('signatureName'))

    # section: 345_non_derivative_table_signature
    _section_rows = _rows_for_section(normalized_rows, '345_non_derivative_table_signature', ['signatureDate', 'signatureName'])
    _records = _collect_records(_section_rows, ['signatureDate', 'signatureName'])
    for _record in _records:
        _parent = _ensure_path(root, ['nonDerivativeTable', 'ownerSignature'], create_leaf=True)
        _add_path_text(_parent, ['signatureDate'], _record.get('signatureDate'))
        _add_path_text(_parent, ['signatureName'], _record.get('signatureName'))

    # section: 345_non_derivative_transaction_legacy
    _section_rows = _rows_for_section(normalized_rows, '345_non_derivative_transaction_legacy', ['equitySwapInvolved', 'transactionCode', 'transactionFormType', 'value', 'transactionDateValue', 'transactionAcquiredDisposedCodeValue', 'transactionPricePerShareValue', 'directOrIndirectOwnershipValue', 'sharesOwnedFollowingTransactionValue', 'transactionSharesValue'])
    _records = _collect_records(_section_rows, ['equitySwapInvolved', 'transactionCode', 'transactionFormType', 'value', 'transactionDateValue', 'transactionAcquiredDisposedCodeValue', 'transactionPricePerShareValue', 'directOrIndirectOwnershipValue', 'sharesOwnedFollowingTransactionValue', 'transactionSharesValue'])
    for _record in _records:
        _parent = _ensure_path(root, ['nonDerivativeTransaction'], create_leaf=True)
        _add_path_text(_parent, ['transactionCoding', 'equitySwapInvolved'], _record.get('equitySwapInvolved'))
        _add_path_text(_parent, ['transactionCoding', 'transactionCode'], _record.get('transactionCode'))
        _add_path_text(_parent, ['transactionCoding', 'transactionFormType'], _record.get('transactionFormType'))
        _add_path_text(_parent, ['securityTitle', 'value'], _record.get('value'))
        _add_path_text(_parent, ['transactionDate', 'value'], _record.get('transactionDateValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'value'], _record.get('transactionAcquiredDisposedCodeValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionPricePerShare', 'value'], _record.get('transactionPricePerShareValue'))
        _add_path_text(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], _record.get('directOrIndirectOwnershipValue'))
        _add_path_text(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], _record.get('sharesOwnedFollowingTransactionValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionShares', 'value'], _record.get('transactionSharesValue'))

    # section: 345_derivative_transaction
    _section_rows = _rows_for_section(normalized_rows, '345_derivative_transaction', ['deemedExecutionDateValue', 'equitySwapInvolved', 'transactionDateValue', 'transactionCode', 'value', 'exerciseDateValue', 'expirationDateValue', 'transactionDateFootnoteIdId', 'securityTitleValue', 'transactionFormType', 'sharesOwnedFollowingTransactionValue', 'transactionTimelinessFootnoteIdId', 'directOrIndirectOwnershipValue', 'transactionTimelinessValue', 'transactionAcquiredDisposedCodeValue', 'transactionPricePerShareValue', 'transactionSharesValue', 'id', 'exerciseDateFootnoteIdId', 'expirationDateFootnoteIdId', 'natureOfOwnershipValue', 'valueOwnedFollowingTransactionValue', 'securityTitleFootnoteIdId', 'transactionTotalValueValue', 'transactionCodingFootnoteIdId', 'underlyingSecuritySharesValue', 'underlyingSecurityTitleValue', 'underlyingSecurityValueValue', 'footnoteIdId', 'transactionSharesFootnoteIdId', 'transactionPricePerShareFootnoteIdId', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'valueOwnedFollowingTransactionFootnoteIdId', 'underlyingSecurityValueFootnoteIdId', 'underlyingSecuritySharesFootnoteIdId', 'underlyingSecurityTitleFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'transactionAcquiredDisposedCodeFootnoteIdId', 'transactionTotalValueFootnoteIdId'])
    _records = _collect_records(_section_rows, ['deemedExecutionDateValue', 'equitySwapInvolved', 'transactionDateValue', 'transactionCode', 'value', 'exerciseDateValue', 'expirationDateValue', 'transactionDateFootnoteIdId', 'securityTitleValue', 'transactionFormType', 'sharesOwnedFollowingTransactionValue', 'transactionTimelinessFootnoteIdId', 'directOrIndirectOwnershipValue', 'transactionTimelinessValue', 'transactionAcquiredDisposedCodeValue', 'transactionPricePerShareValue', 'transactionSharesValue', 'id', 'exerciseDateFootnoteIdId', 'expirationDateFootnoteIdId', 'natureOfOwnershipValue', 'valueOwnedFollowingTransactionValue', 'securityTitleFootnoteIdId', 'transactionTotalValueValue', 'transactionCodingFootnoteIdId', 'underlyingSecuritySharesValue', 'underlyingSecurityTitleValue', 'underlyingSecurityValueValue', 'footnoteIdId', 'transactionSharesFootnoteIdId', 'transactionPricePerShareFootnoteIdId', 'natureOfOwnershipFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'valueOwnedFollowingTransactionFootnoteIdId', 'underlyingSecurityValueFootnoteIdId', 'underlyingSecuritySharesFootnoteIdId', 'underlyingSecurityTitleFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'transactionAcquiredDisposedCodeFootnoteIdId', 'transactionTotalValueFootnoteIdId'])
    for _record in _records:
        _parent = _ensure_path(root, ['derivativeTable', 'derivativeTransaction'], create_leaf=True)
        _add_path_text(_parent, ['deemedExecutionDate', 'value'], _record.get('deemedExecutionDateValue'))
        _add_path_text(_parent, ['transactionCoding', 'equitySwapInvolved'], _record.get('equitySwapInvolved'))
        _add_path_text(_parent, ['transactionDate', 'value'], _record.get('transactionDateValue'))
        _add_path_text(_parent, ['transactionCoding', 'transactionCode'], _record.get('transactionCode'))
        _add_path_text(_parent, ['conversionOrExercisePrice', 'value'], _record.get('value'))
        _add_path_text(_parent, ['exerciseDate', 'value'], _record.get('exerciseDateValue'))
        _add_path_text(_parent, ['expirationDate', 'value'], _record.get('expirationDateValue'))
        _add_path_attr(_parent, ['transactionDate', 'footnoteId'], 'id', _record.get('transactionDateFootnoteIdId'))
        _add_path_text(_parent, ['securityTitle', 'value'], _record.get('securityTitleValue'))
        _add_path_text(_parent, ['transactionCoding', 'transactionFormType'], _record.get('transactionFormType'))
        _add_path_text(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], _record.get('sharesOwnedFollowingTransactionValue'))
        _add_path_attr(_parent, ['transactionTimeliness', 'footnoteId'], 'id', _record.get('transactionTimelinessFootnoteIdId'))
        _add_path_text(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], _record.get('directOrIndirectOwnershipValue'))
        _add_path_text(_parent, ['transactionTimeliness', 'value'], _record.get('transactionTimelinessValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'value'], _record.get('transactionAcquiredDisposedCodeValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionPricePerShare', 'value'], _record.get('transactionPricePerShareValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionShares', 'value'], _record.get('transactionSharesValue'))
        _add_path_attr(_parent, ['conversionOrExercisePrice', 'footnoteId'], 'id', _record.get('id'))
        _add_path_attr(_parent, ['exerciseDate', 'footnoteId'], 'id', _record.get('exerciseDateFootnoteIdId'))
        _add_path_attr(_parent, ['expirationDate', 'footnoteId'], 'id', _record.get('expirationDateFootnoteIdId'))
        _add_path_text(_parent, ['ownershipNature', 'natureOfOwnership', 'value'], _record.get('natureOfOwnershipValue'))
        _add_path_text(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'value'], _record.get('valueOwnedFollowingTransactionValue'))
        _add_path_attr(_parent, ['securityTitle', 'footnoteId'], 'id', _record.get('securityTitleFootnoteIdId'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionTotalValue', 'value'], _record.get('transactionTotalValueValue'))
        _add_path_attr(_parent, ['transactionCoding', 'footnoteId'], 'id', _record.get('transactionCodingFootnoteIdId'))
        _add_path_text(_parent, ['underlyingSecurity', 'underlyingSecurityShares', 'value'], _record.get('underlyingSecuritySharesValue'))
        _add_path_text(_parent, ['underlyingSecurity', 'underlyingSecurityTitle', 'value'], _record.get('underlyingSecurityTitleValue'))
        _add_path_text(_parent, ['underlyingSecurity', 'underlyingSecurityValue', 'value'], _record.get('underlyingSecurityValueValue'))
        _add_path_attr(_parent, ['deemedExecutionDate', 'footnoteId'], 'id', _record.get('footnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionShares', 'footnoteId'], 'id', _record.get('transactionSharesFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionPricePerShare', 'footnoteId'], 'id', _record.get('transactionPricePerShareFootnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'natureOfOwnership', 'footnoteId'], 'id', _record.get('natureOfOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('sharesOwnedFollowingTransactionFootnoteIdId'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('valueOwnedFollowingTransactionFootnoteIdId'))
        _add_path_attr(_parent, ['underlyingSecurity', 'underlyingSecurityValue', 'footnoteId'], 'id', _record.get('underlyingSecurityValueFootnoteIdId'))
        _add_path_attr(_parent, ['underlyingSecurity', 'underlyingSecurityShares', 'footnoteId'], 'id', _record.get('underlyingSecuritySharesFootnoteIdId'))
        _add_path_attr(_parent, ['underlyingSecurity', 'underlyingSecurityTitle', 'footnoteId'], 'id', _record.get('underlyingSecurityTitleFootnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'footnoteId'], 'id', _record.get('directOrIndirectOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'footnoteId'], 'id', _record.get('transactionAcquiredDisposedCodeFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionTotalValue', 'footnoteId'], 'id', _record.get('transactionTotalValueFootnoteIdId'))

    # section: 345_derivative_table_misc
    _section_rows = _rows_for_section(normalized_rows, '345_derivative_table_misc', ['value', 'sharesOwnedFollowingTransactionValue'])
    _records = _collect_records(_section_rows, ['value', 'sharesOwnedFollowingTransactionValue'])
    for _record in _records:
        _parent = _ensure_path(root, ['derivativeTable'], create_leaf=True)
        _add_path_text(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], _record.get('value'))
        _add_path_text(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], _record.get('sharesOwnedFollowingTransactionValue'))

    # section: 345_non_derivative_transaction
    _section_rows = _rows_for_section(normalized_rows, '345_non_derivative_transaction', ['value', 'equitySwapInvolved', 'transactionCode', 'transactionFormType', 'transactionDateValue', 'transactionTimelinessValue', 'securityTitleValue', 'directOrIndirectOwnershipValue', 'transactionDateFootnoteIdId', 'natureOfOwnershipValue', 'transactionAcquiredDisposedCodeValue', 'transactionPricePerShareValue', 'transactionSharesValue', 'footnoteIdId', 'transactionCodingFootnoteIdId', 'sharesOwnedFollowingTransactionValue', 'valueOwnedFollowingTransactionValue', 'id', 'natureOfOwnershipFootnoteIdId', 'transactionSharesFootnoteIdId', 'transactionTimelinessFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'transactionPricePerShareFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'transactionAcquiredDisposedCodeFootnoteIdId', 'valueOwnedFollowingTransactionFootnoteIdId'])
    _records = _collect_records(_section_rows, ['value', 'equitySwapInvolved', 'transactionCode', 'transactionFormType', 'transactionDateValue', 'transactionTimelinessValue', 'securityTitleValue', 'directOrIndirectOwnershipValue', 'transactionDateFootnoteIdId', 'natureOfOwnershipValue', 'transactionAcquiredDisposedCodeValue', 'transactionPricePerShareValue', 'transactionSharesValue', 'footnoteIdId', 'transactionCodingFootnoteIdId', 'sharesOwnedFollowingTransactionValue', 'valueOwnedFollowingTransactionValue', 'id', 'natureOfOwnershipFootnoteIdId', 'transactionSharesFootnoteIdId', 'transactionTimelinessFootnoteIdId', 'sharesOwnedFollowingTransactionFootnoteIdId', 'transactionPricePerShareFootnoteIdId', 'directOrIndirectOwnershipFootnoteIdId', 'transactionAcquiredDisposedCodeFootnoteIdId', 'valueOwnedFollowingTransactionFootnoteIdId'])
    for _record in _records:
        _parent = _ensure_path(root, ['nonDerivativeTable', 'nonDerivativeTransaction'], create_leaf=True)
        _add_path_text(_parent, ['deemedExecutionDate', 'value'], _record.get('value'))
        _add_path_text(_parent, ['transactionCoding', 'equitySwapInvolved'], _record.get('equitySwapInvolved'))
        _add_path_text(_parent, ['transactionCoding', 'transactionCode'], _record.get('transactionCode'))
        _add_path_text(_parent, ['transactionCoding', 'transactionFormType'], _record.get('transactionFormType'))
        _add_path_text(_parent, ['transactionDate', 'value'], _record.get('transactionDateValue'))
        _add_path_text(_parent, ['transactionTimeliness', 'value'], _record.get('transactionTimelinessValue'))
        _add_path_text(_parent, ['securityTitle', 'value'], _record.get('securityTitleValue'))
        _add_path_text(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], _record.get('directOrIndirectOwnershipValue'))
        _add_path_attr(_parent, ['transactionDate', 'footnoteId'], 'id', _record.get('transactionDateFootnoteIdId'))
        _add_path_text(_parent, ['ownershipNature', 'natureOfOwnership', 'value'], _record.get('natureOfOwnershipValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'value'], _record.get('transactionAcquiredDisposedCodeValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionPricePerShare', 'value'], _record.get('transactionPricePerShareValue'))
        _add_path_text(_parent, ['transactionAmounts', 'transactionShares', 'value'], _record.get('transactionSharesValue'))
        _add_path_attr(_parent, ['securityTitle', 'footnoteId'], 'id', _record.get('footnoteIdId'))
        _add_path_attr(_parent, ['transactionCoding', 'footnoteId'], 'id', _record.get('transactionCodingFootnoteIdId'))
        _add_path_text(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], _record.get('sharesOwnedFollowingTransactionValue'))
        _add_path_text(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'value'], _record.get('valueOwnedFollowingTransactionValue'))
        _add_path_attr(_parent, ['deemedExecutionDate', 'footnoteId'], 'id', _record.get('id'))
        _add_path_attr(_parent, ['ownershipNature', 'natureOfOwnership', 'footnoteId'], 'id', _record.get('natureOfOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionShares', 'footnoteId'], 'id', _record.get('transactionSharesFootnoteIdId'))
        _add_path_attr(_parent, ['transactionTimeliness', 'footnoteId'], 'id', _record.get('transactionTimelinessFootnoteIdId'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('sharesOwnedFollowingTransactionFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionPricePerShare', 'footnoteId'], 'id', _record.get('transactionPricePerShareFootnoteIdId'))
        _add_path_attr(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'footnoteId'], 'id', _record.get('directOrIndirectOwnershipFootnoteIdId'))
        _add_path_attr(_parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'footnoteId'], 'id', _record.get('transactionAcquiredDisposedCodeFootnoteIdId'))
        _add_path_attr(_parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'footnoteId'], 'id', _record.get('valueOwnedFollowingTransactionFootnoteIdId'))

    # section: 345_non_derivative_table_misc
    _section_rows = _rows_for_section(normalized_rows, '345_non_derivative_table_misc', ['value', 'sharesOwnedFollowingTransactionValue'])
    _records = _collect_records(_section_rows, ['value', 'sharesOwnedFollowingTransactionValue'])
    for _record in _records:
        _parent = _ensure_path(root, ['nonDerivativeTable'], create_leaf=True)
        _add_path_text(_parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], _record.get('value'))
        _add_path_text(_parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], _record.get('sharesOwnedFollowingTransactionValue'))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')
