import io
import xml.etree.ElementTree as ET
from ..utils import (
    _add_created_with_comment,
    _add_path_text,
    _add_footnote_ids,
    _ensure_path,
)


# ---------------------------------------------------------------------------
# Singular header fields (written once from first row)
# ---------------------------------------------------------------------------

def _write_header(root: ET.Element, row: dict) -> None:
    _add_path_text(root, ['schemaVersion'], row.get('schemaVersion'))
    _add_path_text(root, ['documentType'], row.get('documentType'))
    _add_path_text(root, ['periodOfReport'], row.get('periodOfReport'))
    _add_path_text(root, ['dateOfOriginalSubmission'], row.get('dateOfOriginalSubmission'))
    _add_path_text(root, ['notSubjectToSection16'], row.get('notSubjectToSection16'))
    _add_path_text(root, ['noSecuritiesOwned'], row.get('noSecuritiesOwned'))
    _add_path_text(root, ['form3HoldingsReported'], row.get('form3HoldingsReported'))
    _add_path_text(root, ['form4TransactionsReported'], row.get('form4TransactionsReported'))

    # issuer
    _add_path_text(root, ['issuer', 'issuerCik'], row.get('issuerCik'))
    _add_path_text(root, ['issuer', 'issuerName'], row.get('issuerName'))
    _add_path_text(root, ['issuer', 'issuerTradingSymbol'], row.get('issuerTradingSymbol'))
    _add_path_text(root, ['issuer', 'issuerForeignTradingSymbol'], row.get('issuerForeignTradingSymbol'))


def _write_aff10b5_one(root: ET.Element, row: dict) -> None:
    _add_path_text(root, ['aff10B5One'], row.get('aff10B5One'))


def _write_remarks(root: ET.Element, row: dict) -> None:
    _add_path_text(root, ['remarks'], row.get('remarks'))


def _write_reporting_owner(root: ET.Element, row: dict) -> None:
    parent = _ensure_path(root, ['reportingOwner'], create_leaf=True)
    _add_path_text(parent, ['reportingOwnerId', 'rptOwnerCik'], row.get('rptOwnerCik'))
    _add_path_text(parent, ['reportingOwnerId', 'rptOwnerCcc'], row.get('rptOwnerCcc'))
    _add_path_text(parent, ['reportingOwnerId', 'rptOwnerName'], row.get('rptOwnerName'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerNonUSAddressFlag'], row.get('rptOwnerNonUSAddressFlag'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerStreet1'], row.get('rptOwnerStreet1'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerStreet2'], row.get('rptOwnerStreet2'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerCity'], row.get('rptOwnerCity'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerNonUSStateTerritory'], row.get('rptOwnerNonUSStateTerritory'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerState'], row.get('rptOwnerState'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerCountry'], row.get('rptOwnerCountry'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerZipCode'], row.get('rptOwnerZipCode'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerStateDescription'], row.get('rptOwnerStateDescription'))
    _add_path_text(parent, ['reportingOwnerAddress', 'rptOwnerGoodAddress'], row.get('rptOwnerGoodAddress'))
    _add_path_text(parent, ['reportingOwnerRelationship', 'isDirector'], row.get('isDirector'))
    _add_path_text(parent, ['reportingOwnerRelationship', 'isOfficer'], row.get('isOfficer'))
    _add_path_text(parent, ['reportingOwnerRelationship', 'isTenPercentOwner'], row.get('isTenPercentOwner'))
    _add_path_text(parent, ['reportingOwnerRelationship', 'isOther'], row.get('isOther'))
    _add_path_text(parent, ['reportingOwnerRelationship', 'officerTitle'], row.get('officerTitle'))
    _add_path_text(parent, ['reportingOwnerRelationship', 'otherText'], row.get('otherText'))


def _write_footnote(root: ET.Element, row: dict) -> None:
    footnote_id = row.get('footnoteId')
    footnote_text = row.get('footnoteText')
    if not footnote_id and not footnote_text:
        return
    parent = _ensure_path(root, ['footnotes', 'footnote'], create_leaf=True)
    if footnote_id:
        parent.set('id', footnote_id)
    if footnote_text:
        parent.text = footnote_text


def _write_owner_signature(root: ET.Element, row: dict) -> None:
    sig_name = row.get('signatureName')
    sig_date = row.get('signatureDate')
    if not sig_name and not sig_date:
        return
    parent = _ensure_path(root, ['ownerSignature'], create_leaf=True)
    _add_path_text(parent, ['signatureName'], sig_name)
    _add_path_text(parent, ['signatureDate'], sig_date)


# ---------------------------------------------------------------------------
# Shared field writers (reused across transaction/holding types)
# ---------------------------------------------------------------------------

def _write_transaction_coding(parent: ET.Element, row: dict, include_equity_swap: bool = True) -> None:
    _add_path_text(parent, ['transactionCoding', 'transactionFormType'], row.get('transactionFormType'))
    _add_path_text(parent, ['transactionCoding', 'transactionCode'], row.get('transactionCode'))
    if include_equity_swap:
        _add_path_text(parent, ['transactionCoding', 'equitySwapInvolved'], row.get('equitySwapInvolved'))
    _add_footnote_ids(parent, ['transactionCoding'], row.get('transactionCodingFootnoteIdId'))


def _write_ownership_nature(parent: ET.Element, row: dict) -> None:
    _add_path_text(parent, ['ownershipNature', 'directOrIndirectOwnership', 'value'], row.get('directOrIndirectOwnershipValue'))
    _add_footnote_ids(parent, ['ownershipNature', 'directOrIndirectOwnership'], row.get('directOrIndirectOwnershipFootnoteIdId'))
    _add_path_text(parent, ['ownershipNature', 'natureOfOwnership', 'value'], row.get('natureOfOwnershipValue'))
    _add_footnote_ids(parent, ['ownershipNature', 'natureOfOwnership'], row.get('natureOfOwnershipFootnoteIdId'))


def _write_post_transaction_amounts(parent: ET.Element, row: dict) -> None:
    _add_path_text(parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction', 'value'], row.get('sharesOwnedFollowingTransactionValue'))
    _add_footnote_ids(parent, ['postTransactionAmounts', 'sharesOwnedFollowingTransaction'], row.get('sharesOwnedFollowingTransactionFootnoteIdId'))
    _add_path_text(parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction', 'value'], row.get('valueOwnedFollowingTransactionValue'))
    _add_footnote_ids(parent, ['postTransactionAmounts', 'valueOwnedFollowingTransaction'], row.get('valueOwnedFollowingTransactionFootnoteIdId'))


def _write_underlying_security(parent: ET.Element, row: dict) -> None:
    _add_path_text(parent, ['underlyingSecurity', 'underlyingSecurityTitle', 'value'], row.get('underlyingSecurityTitleValue'))
    _add_footnote_ids(parent, ['underlyingSecurity', 'underlyingSecurityTitle'], row.get('underlyingSecurityTitleFootnoteIdId'))
    _add_path_text(parent, ['underlyingSecurity', 'underlyingSecurityShares', 'value'], row.get('underlyingSecuritySharesValue'))
    _add_footnote_ids(parent, ['underlyingSecurity', 'underlyingSecurityShares'], row.get('underlyingSecuritySharesFootnoteIdId'))
    _add_path_text(parent, ['underlyingSecurity', 'underlyingSecurityValue', 'value'], row.get('underlyingSecurityValueValue'))
    _add_footnote_ids(parent, ['underlyingSecurity', 'underlyingSecurityValue'], row.get('underlyingSecurityValueFootnoteIdId'))


# ---------------------------------------------------------------------------
# Per-table section writers
# ---------------------------------------------------------------------------

def _write_non_derivative_transaction(root: ET.Element, row: dict) -> None:
    table = _ensure_path(root, ['nonDerivativeTable'])
    parent = _ensure_path(table, ['nonDerivativeTransaction'], create_leaf=True)

    _add_path_text(parent, ['securityTitle', 'value'], row.get('securityTitleValue'))
    _add_footnote_ids(parent, ['securityTitle'], row.get('footnoteIdId'))

    _add_path_text(parent, ['transactionDate', 'value'], row.get('transactionDateValue'))
    _add_footnote_ids(parent, ['transactionDate'], row.get('transactionDateFootnoteIdId'))

    _add_path_text(parent, ['deemedExecutionDate', 'value'], row.get('deemedExecutionDateValue'))
    _add_footnote_ids(parent, ['deemedExecutionDate'], row.get('deemedExecutionDateFootnoteIdId'))

    _write_transaction_coding(parent, row)

    _add_path_text(parent, ['transactionTimeliness', 'value'], row.get('transactionTimelinessValue'))
    _add_footnote_ids(parent, ['transactionTimeliness'], row.get('transactionTimelinessFootnoteIdId'))

    _add_path_text(parent, ['transactionAmounts', 'transactionShares', 'value'], row.get('transactionSharesValue'))
    _add_footnote_ids(parent, ['transactionAmounts', 'transactionShares'], row.get('transactionSharesFootnoteIdId'))
    _add_path_text(parent, ['transactionAmounts', 'transactionPricePerShare', 'value'], row.get('transactionPricePerShareValue'))
    _add_footnote_ids(parent, ['transactionAmounts', 'transactionPricePerShare'], row.get('transactionPricePerShareFootnoteIdId'))
    _add_path_text(parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'value'], row.get('transactionAcquiredDisposedCodeValue'))
    _add_footnote_ids(parent, ['transactionAmounts', 'transactionAcquiredDisposedCode'], row.get('transactionAcquiredDisposedCodeFootnoteIdId'))

    _write_post_transaction_amounts(parent, row)
    _write_ownership_nature(parent, row)


def _write_non_derivative_holding(root: ET.Element, row: dict) -> None:
    table = _ensure_path(root, ['nonDerivativeTable'])
    parent = _ensure_path(table, ['nonDerivativeHolding'], create_leaf=True)

    _add_path_text(parent, ['securityTitle', 'value'], row.get('securityTitleValue'))
    _add_footnote_ids(parent, ['securityTitle'], row.get('footnoteIdId'))

    _write_transaction_coding(parent, row, include_equity_swap=False)
    _write_post_transaction_amounts(parent, row)
    _write_ownership_nature(parent, row)


def _write_derivative_transaction(root: ET.Element, row: dict) -> None:
    table = _ensure_path(root, ['derivativeTable'])
    parent = _ensure_path(table, ['derivativeTransaction'], create_leaf=True)

    _add_path_text(parent, ['securityTitle', 'value'], row.get('securityTitleValue'))
    _add_footnote_ids(parent, ['securityTitle'], row.get('footnoteIdId'))

    _add_path_text(parent, ['conversionOrExercisePrice', 'value'], row.get('value'))
    _add_footnote_ids(parent, ['conversionOrExercisePrice'], row.get('conversionOrExercisePriceFootnoteIdId'))

    _add_path_text(parent, ['transactionDate', 'value'], row.get('transactionDateValue'))
    _add_footnote_ids(parent, ['transactionDate'], row.get('transactionDateFootnoteIdId'))

    _add_path_text(parent, ['deemedExecutionDate', 'value'], row.get('deemedExecutionDateValue'))
    _add_footnote_ids(parent, ['deemedExecutionDate'], row.get('deemedExecutionDateFootnoteIdId'))

    _write_transaction_coding(parent, row)

    _add_path_text(parent, ['transactionTimeliness', 'value'], row.get('transactionTimelinessValue'))
    _add_footnote_ids(parent, ['transactionTimeliness'], row.get('transactionTimelinessFootnoteIdId'))

    _add_path_text(parent, ['transactionAmounts', 'transactionShares', 'value'], row.get('transactionSharesValue'))
    _add_footnote_ids(parent, ['transactionAmounts', 'transactionShares'], row.get('transactionSharesFootnoteIdId'))
    _add_path_text(parent, ['transactionAmounts', 'transactionPricePerShare', 'value'], row.get('transactionPricePerShareValue'))
    _add_footnote_ids(parent, ['transactionAmounts', 'transactionPricePerShare'], row.get('transactionPricePerShareFootnoteIdId'))
    _add_path_text(parent, ['transactionAmounts', 'transactionTotalValue', 'value'], row.get('transactionTotalValueValue'))
    _add_footnote_ids(parent, ['transactionAmounts', 'transactionTotalValue'], row.get('transactionTotalValueFootnoteIdId'))
    _add_path_text(parent, ['transactionAmounts', 'transactionAcquiredDisposedCode', 'value'], row.get('transactionAcquiredDisposedCodeValue'))
    _add_footnote_ids(parent, ['transactionAmounts', 'transactionAcquiredDisposedCode'], row.get('transactionAcquiredDisposedCodeFootnoteIdId'))

    _add_path_text(parent, ['exerciseDate', 'value'], row.get('exerciseDateValue'))
    _add_footnote_ids(parent, ['exerciseDate'], row.get('exerciseDateFootnoteIdId'))

    _add_path_text(parent, ['expirationDate', 'value'], row.get('expirationDateValue'))
    _add_footnote_ids(parent, ['expirationDate'], row.get('expirationDateFootnoteIdId'))

    _write_underlying_security(parent, row)
    _write_post_transaction_amounts(parent, row)
    _write_ownership_nature(parent, row)


def _write_derivative_holding(root: ET.Element, row: dict) -> None:
    table = _ensure_path(root, ['derivativeTable'])
    parent = _ensure_path(table, ['derivativeHolding'], create_leaf=True)

    _add_path_text(parent, ['securityTitle', 'value'], row.get('securityTitleValue'))
    _add_footnote_ids(parent, ['securityTitle'], row.get('footnoteIdId'))

    _add_path_text(parent, ['conversionOrExercisePrice', 'value'], row.get('value'))
    _add_footnote_ids(parent, ['conversionOrExercisePrice'], row.get('conversionOrExercisePriceFootnoteIdId'))

    _add_path_text(parent, ['exerciseDate', 'value'], row.get('exerciseDateValue'))
    _add_footnote_ids(parent, ['exerciseDate'], row.get('exerciseDateFootnoteIdId'))

    _add_path_text(parent, ['expirationDate', 'value'], row.get('expirationDateValue'))
    _add_footnote_ids(parent, ['expirationDate'], row.get('expirationDateFootnoteIdId'))

    _write_transaction_coding(parent, row, include_equity_swap=False)
    _write_underlying_security(parent, row)
    _write_post_transaction_amounts(parent, row)
    _write_ownership_nature(parent, row)


# ---------------------------------------------------------------------------
# Table dispatch
# ---------------------------------------------------------------------------

_TABLE_HANDLERS = {
    '345_non_derivative_transaction': _write_non_derivative_transaction,
    '345_non_derivative_holding': _write_non_derivative_holding,
    '345_derivative_transaction': _write_derivative_transaction,
    '345_derivative_holding': _write_derivative_holding,
    '345_footnote': _write_footnote,
    '345_owner_signature': _write_owner_signature,
    '345_reporting_owner': _write_reporting_owner,
}


# ---------------------------------------------------------------------------
# Main entry point
# ---------------------------------------------------------------------------

def construct_345(rows: list) -> bytes:
    root = ET.Element('ownershipDocument')

    header_row = next((row for row in rows if row.get('_table') == '345'), rows[0] if rows else None)
    if header_row:
        _write_header(root, header_row)

    # Enforce deterministic schema ordering regardless of incoming row order.
    for row in rows:
        if row.get('_table') == '345_reporting_owner':
            _write_reporting_owner(root, row)

    if header_row:
        _write_aff10b5_one(root, header_row)

    for row in rows:
        table = row.get('_table')
        if table in {'345_non_derivative_transaction', '345_non_derivative_holding'}:
            _TABLE_HANDLERS[table](root, row)

    for row in rows:
        table = row.get('_table')
        if table in {'345_derivative_transaction', '345_derivative_holding'}:
            _TABLE_HANDLERS[table](root, row)

    for row in rows:
        if row.get('_table') == '345_footnote':
            _write_footnote(root, row)

    if header_row:
        _write_remarks(root, header_row)

    for row in rows:
        if row.get('_table') == '345_owner_signature':
            _write_owner_signature(root, row)

    _add_created_with_comment(root)
    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')
