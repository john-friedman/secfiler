import io
import xml.etree.ElementTree as ET
from ..constants import CREATED_WITH_SECFILER_COMMENT


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
    has_section_hints = any(
        any(_is_present(row.get(key)) for key in _SECTION_HINT_KEYS)
        for row in rows
    )
    if has_section_hints:
        return []
    return [row for row in rows if any(_is_present(row.get(key)) for key in marker_keys)]


def _normalize_rows(rows: list) -> list[dict]:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]
    return normalized_rows


def _first_present(record: dict, keys: list[str]):
    for key in keys:
        value = record.get(key)
        if _is_present(value):
            return value
    return None


def _add_text(parent: ET.Element, tag: str, value):
    if not _is_present(value):
        return None
    child = ET.SubElement(parent, tag)
    child.text = _to_text(value)
    return child


def _add_footnote_ids(parent: ET.Element, raw_ids) -> None:
    for footnote_id in _normalize_values(raw_ids):
        if _is_present(footnote_id):
            ET.SubElement(parent, "footnoteId", {"id": _to_text(footnote_id)})


def _add_value_with_footnotes(
    parent: ET.Element,
    tag: str,
    value,
    footnote_ids,
    *,
    allow_footnote_only: bool,
):
    has_value = _is_present(value)
    has_footnotes = _is_present(footnote_ids)
    if not has_value and not (allow_footnote_only and has_footnotes):
        return None
    node = ET.SubElement(parent, tag)
    if has_value:
        ET.SubElement(node, "value").text = _to_text(value)
    _add_footnote_ids(node, footnote_ids)
    return node


def _build_reporting_owners(root: ET.Element, rows: list[dict]) -> None:
    marker_keys = [
        "rptOwnerCik",
        "rptOwnerCcc",
        "rptOwnerName",
        "rptOwnerStreet1",
        "rptOwnerStreet2",
        "rptOwnerCity",
        "rptOwnerNonUSStateTerritory",
        "rptOwnerState",
        "rptOwnerCountry",
        "rptOwnerZipCode",
        "isDirector",
        "isOfficer",
        "isTenPercentOwner",
        "isOther",
        "officerTitle",
        "otherText",
    ]
    section_rows = _rows_for_section(rows, "345_reporting_owner", marker_keys)
    records = _collect_records(section_rows, marker_keys + [
        "rptOwnerStateDescription",
        "rptOwnerGoodAddress",
        "rptOwnerNonUSAddressFlag",
        "rptOwnerCounrty",
    ])

    if not records:
        fallback = {key: _first_across_rows(rows, [key]) for key in marker_keys}
        if any(_is_present(v) for v in fallback.values()):
            records = [fallback]

    for record in records:
        owner = ET.SubElement(root, "reportingOwner")

        owner_id = ET.SubElement(owner, "reportingOwnerId")
        _add_text(owner_id, "rptOwnerCik", record.get("rptOwnerCik"))
        _add_text(owner_id, "rptOwnerCcc", record.get("rptOwnerCcc"))
        _add_text(owner_id, "rptOwnerName", record.get("rptOwnerName"))

        address_values = [
            record.get("rptOwnerNonUSAddressFlag"),
            record.get("rptOwnerStreet1"),
            record.get("rptOwnerStreet2"),
            record.get("rptOwnerCity"),
            record.get("rptOwnerNonUSStateTerritory"),
            record.get("rptOwnerState"),
            _first_present(record, ["rptOwnerCountry", "rptOwnerCounrty"]),
            record.get("rptOwnerZipCode"),
            record.get("rptOwnerStateDescription"),
            record.get("rptOwnerGoodAddress"),
        ]
        if any(_is_present(v) for v in address_values):
            address = ET.SubElement(owner, "reportingOwnerAddress")
            _add_text(address, "rptOwnerNonUSAddressFlag", record.get("rptOwnerNonUSAddressFlag"))
            _add_text(address, "rptOwnerStreet1", record.get("rptOwnerStreet1"))
            _add_text(address, "rptOwnerStreet2", record.get("rptOwnerStreet2"))
            _add_text(address, "rptOwnerCity", record.get("rptOwnerCity"))
            _add_text(address, "rptOwnerNonUSStateTerritory", record.get("rptOwnerNonUSStateTerritory"))
            _add_text(address, "rptOwnerState", record.get("rptOwnerState"))
            _add_text(address, "rptOwnerCountry", _first_present(record, ["rptOwnerCountry", "rptOwnerCounrty"]))
            _add_text(address, "rptOwnerZipCode", record.get("rptOwnerZipCode"))
            _add_text(address, "rptOwnerStateDescription", record.get("rptOwnerStateDescription"))
            _add_text(address, "rptOwnerGoodAddress", record.get("rptOwnerGoodAddress"))

        relationship = ET.SubElement(owner, "reportingOwnerRelationship")
        _add_text(relationship, "isDirector", record.get("isDirector"))
        _add_text(relationship, "isOfficer", record.get("isOfficer"))
        _add_text(relationship, "isTenPercentOwner", record.get("isTenPercentOwner"))
        _add_text(relationship, "isOther", record.get("isOther"))
        _add_text(relationship, "officerTitle", record.get("officerTitle"))
        _add_text(relationship, "otherText", record.get("otherText"))


def _build_non_derivative_table(root: ET.Element, rows: list[dict]) -> None:
    holding_keys = [
        "value",
        "securityTitleValue",
        "sharesOwnedFollowingTransactionValue",
        "valueOwnedFollowingTransactionValue",
        "directOrIndirectOwnershipValue",
        "natureOfOwnershipValue",
        "id",
        "securityTitleFootnoteIdId",
        "directOrIndirectOwnershipFootnoteIdId",
        "natureOfOwnershipFootnoteIdId",
        "sharesOwnedFollowingTransactionFootnoteIdId",
        "valueOwnedFollowingTransactionFootnoteIdId",
    ]
    transaction_keys = [
        "securityTitleValue",
        "transactionDateValue",
        "deemedExecutionDateValue",
        "equitySwapInvolved",
        "transactionCode",
        "transactionFormType",
        "transactionTimelinessValue",
        "directOrIndirectOwnershipValue",
        "natureOfOwnershipValue",
        "transactionAcquiredDisposedCodeValue",
        "transactionPricePerShareValue",
        "transactionSharesValue",
        "sharesOwnedFollowingTransactionValue",
        "valueOwnedFollowingTransactionValue",
        "footnoteIdId",
        "securityTitleFootnoteIdId",
        "transactionDateFootnoteIdId",
        "deemedExecutionDateFootnoteIdId",
        "transactionCodingFootnoteIdId",
        "transactionTimelinessFootnoteIdId",
        "transactionSharesFootnoteIdId",
        "transactionPricePerShareFootnoteIdId",
        "transactionAcquiredDisposedCodeFootnoteIdId",
        "sharesOwnedFollowingTransactionFootnoteIdId",
        "valueOwnedFollowingTransactionFootnoteIdId",
        "directOrIndirectOwnershipFootnoteIdId",
        "natureOfOwnershipFootnoteIdId",
        "id",
        "value",
    ]

    holding_rows = _rows_for_section(rows, "345_non_derivative_holding", holding_keys)
    transaction_rows = _rows_for_section(rows, "345_non_derivative_transaction", transaction_keys)
    legacy_transaction_rows = _rows_for_section(rows, "345_non_derivative_transaction_legacy", transaction_keys)

    holding_records = _collect_records(holding_rows, holding_keys)
    transaction_records = _collect_records(transaction_rows + legacy_transaction_rows, transaction_keys)

    if not holding_records and not transaction_records:
        return

    table = ET.SubElement(root, "nonDerivativeTable")

    for record in transaction_records:
        transaction = ET.SubElement(table, "nonDerivativeTransaction")
        security_title = _first_present(record, ["securityTitleValue"])
        security_title_footnotes = _first_present(record, ["securityTitleFootnoteIdId", "footnoteIdId"])
        _add_value_with_footnotes(
            transaction,
            "securityTitle",
            security_title,
            security_title_footnotes,
            allow_footnote_only=False,
        )
        _add_value_with_footnotes(
            transaction,
            "transactionDate",
            record.get("transactionDateValue"),
            record.get("transactionDateFootnoteIdId"),
            allow_footnote_only=False,
        )
        _add_value_with_footnotes(
            transaction,
            "deemedExecutionDate",
            _first_present(record, ["deemedExecutionDateValue", "value"]),
            _first_present(record, ["deemedExecutionDateFootnoteIdId", "id"]),
            allow_footnote_only=True,
        )

        if any(_is_present(record.get(key)) for key in ["transactionFormType", "transactionCode", "equitySwapInvolved", "transactionCodingFootnoteIdId"]):
            coding = ET.SubElement(transaction, "transactionCoding")
            _add_text(coding, "transactionFormType", record.get("transactionFormType"))
            _add_text(coding, "transactionCode", record.get("transactionCode"))
            _add_text(coding, "equitySwapInvolved", record.get("equitySwapInvolved"))
            _add_footnote_ids(coding, record.get("transactionCodingFootnoteIdId"))

        _add_value_with_footnotes(
            transaction,
            "transactionTimeliness",
            record.get("transactionTimelinessValue"),
            record.get("transactionTimelinessFootnoteIdId"),
            allow_footnote_only=True,
        )

        if any(
            _is_present(record.get(key))
            for key in [
                "transactionSharesValue",
                "transactionPricePerShareValue",
                "transactionAcquiredDisposedCodeValue",
            ]
        ):
            amounts = ET.SubElement(transaction, "transactionAmounts")
            _add_value_with_footnotes(
                amounts,
                "transactionShares",
                record.get("transactionSharesValue"),
                record.get("transactionSharesFootnoteIdId"),
                allow_footnote_only=False,
            )
            _add_value_with_footnotes(
                amounts,
                "transactionPricePerShare",
                record.get("transactionPricePerShareValue"),
                record.get("transactionPricePerShareFootnoteIdId"),
                allow_footnote_only=True,
            )
            _add_value_with_footnotes(
                amounts,
                "transactionAcquiredDisposedCode",
                record.get("transactionAcquiredDisposedCodeValue"),
                record.get("transactionAcquiredDisposedCodeFootnoteIdId"),
                allow_footnote_only=False,
            )

        if _is_present(record.get("sharesOwnedFollowingTransactionValue")) or _is_present(record.get("valueOwnedFollowingTransactionValue")):
            post_transaction = ET.SubElement(transaction, "postTransactionAmounts")
            if _is_present(record.get("sharesOwnedFollowingTransactionValue")):
                _add_value_with_footnotes(
                    post_transaction,
                    "sharesOwnedFollowingTransaction",
                    record.get("sharesOwnedFollowingTransactionValue"),
                    record.get("sharesOwnedFollowingTransactionFootnoteIdId"),
                    allow_footnote_only=False,
                )
            else:
                _add_value_with_footnotes(
                    post_transaction,
                    "valueOwnedFollowingTransaction",
                    record.get("valueOwnedFollowingTransactionValue"),
                    record.get("valueOwnedFollowingTransactionFootnoteIdId"),
                    allow_footnote_only=False,
                )

        if _is_present(record.get("directOrIndirectOwnershipValue")) or _is_present(record.get("natureOfOwnershipValue")):
            ownership = ET.SubElement(transaction, "ownershipNature")
            _add_value_with_footnotes(
                ownership,
                "directOrIndirectOwnership",
                record.get("directOrIndirectOwnershipValue"),
                record.get("directOrIndirectOwnershipFootnoteIdId"),
                allow_footnote_only=False,
            )
            if _is_present(record.get("natureOfOwnershipValue")):
                _add_value_with_footnotes(
                    ownership,
                    "natureOfOwnership",
                    record.get("natureOfOwnershipValue"),
                    record.get("natureOfOwnershipFootnoteIdId"),
                    allow_footnote_only=False,
                )

    for record in holding_records:
        holding = ET.SubElement(table, "nonDerivativeHolding")
        _add_value_with_footnotes(
            holding,
            "securityTitle",
            _first_present(record, ["securityTitleValue", "value"]),
            _first_present(record, ["securityTitleFootnoteIdId", "id"]),
            allow_footnote_only=False,
        )

        post_transaction = ET.SubElement(holding, "postTransactionAmounts")
        if _is_present(record.get("sharesOwnedFollowingTransactionValue")):
            _add_value_with_footnotes(
                post_transaction,
                "sharesOwnedFollowingTransaction",
                record.get("sharesOwnedFollowingTransactionValue"),
                record.get("sharesOwnedFollowingTransactionFootnoteIdId"),
                allow_footnote_only=False,
            )
        else:
            _add_value_with_footnotes(
                post_transaction,
                "valueOwnedFollowingTransaction",
                record.get("valueOwnedFollowingTransactionValue"),
                record.get("valueOwnedFollowingTransactionFootnoteIdId"),
                allow_footnote_only=False,
            )

        ownership = ET.SubElement(holding, "ownershipNature")
        _add_value_with_footnotes(
            ownership,
            "directOrIndirectOwnership",
            record.get("directOrIndirectOwnershipValue"),
            record.get("directOrIndirectOwnershipFootnoteIdId"),
            allow_footnote_only=False,
        )
        if _is_present(record.get("natureOfOwnershipValue")):
            _add_value_with_footnotes(
                ownership,
                "natureOfOwnership",
                record.get("natureOfOwnershipValue"),
                record.get("natureOfOwnershipFootnoteIdId"),
                allow_footnote_only=False,
            )


def _build_derivative_table(root: ET.Element, rows: list[dict]) -> None:
    holding_keys = [
        "securityTitleValue",
        "value",
        "exerciseDateValue",
        "expirationDateValue",
        "underlyingSecurityTitleValue",
        "underlyingSecuritySharesValue",
        "underlyingSecurityValueValue",
        "sharesOwnedFollowingTransactionValue",
        "valueOwnedFollowingTransactionValue",
        "directOrIndirectOwnershipValue",
        "natureOfOwnershipValue",
        "id",
        "footnoteIdId",
        "securityTitleFootnoteIdId",
        "exerciseDateFootnoteIdId",
        "expirationDateFootnoteIdId",
        "underlyingSecurityTitleFootnoteIdId",
        "underlyingSecuritySharesFootnoteIdId",
        "underlyingSecurityValueFootnoteIdId",
        "sharesOwnedFollowingTransactionFootnoteIdId",
        "valueOwnedFollowingTransactionFootnoteIdId",
        "directOrIndirectOwnershipFootnoteIdId",
        "natureOfOwnershipFootnoteIdId",
    ]
    transaction_keys = [
        "securityTitleValue",
        "value",
        "transactionDateValue",
        "deemedExecutionDateValue",
        "transactionFormType",
        "transactionCode",
        "equitySwapInvolved",
        "transactionTimelinessValue",
        "transactionSharesValue",
        "transactionTotalValueValue",
        "transactionPricePerShareValue",
        "transactionAcquiredDisposedCodeValue",
        "exerciseDateValue",
        "expirationDateValue",
        "underlyingSecurityTitleValue",
        "underlyingSecuritySharesValue",
        "underlyingSecurityValueValue",
        "sharesOwnedFollowingTransactionValue",
        "valueOwnedFollowingTransactionValue",
        "directOrIndirectOwnershipValue",
        "natureOfOwnershipValue",
        "securityTitleFootnoteIdId",
        "transactionDateFootnoteIdId",
        "deemedExecutionDateFootnoteIdId",
        "transactionCodingFootnoteIdId",
        "transactionTimelinessFootnoteIdId",
        "transactionSharesFootnoteIdId",
        "transactionTotalValueFootnoteIdId",
        "transactionPricePerShareFootnoteIdId",
        "exerciseDateFootnoteIdId",
        "expirationDateFootnoteIdId",
        "underlyingSecurityTitleFootnoteIdId",
        "underlyingSecuritySharesFootnoteIdId",
        "underlyingSecurityValueFootnoteIdId",
        "sharesOwnedFollowingTransactionFootnoteIdId",
        "valueOwnedFollowingTransactionFootnoteIdId",
        "directOrIndirectOwnershipFootnoteIdId",
        "natureOfOwnershipFootnoteIdId",
        "id",
        "footnoteIdId",
    ]

    holding_rows = _rows_for_section(rows, "345_derivative_holding", holding_keys)
    transaction_rows = _rows_for_section(rows, "345_derivative_transaction", transaction_keys)

    holding_records = _collect_records(holding_rows, holding_keys)
    transaction_records = _collect_records(transaction_rows, transaction_keys)

    if not holding_records and not transaction_records:
        return

    table = ET.SubElement(root, "derivativeTable")

    for record in transaction_records:
        transaction = ET.SubElement(table, "derivativeTransaction")
        _add_value_with_footnotes(
            transaction,
            "securityTitle",
            record.get("securityTitleValue"),
            record.get("securityTitleFootnoteIdId"),
            allow_footnote_only=False,
        )
        _add_value_with_footnotes(
            transaction,
            "conversionOrExercisePrice",
            record.get("value"),
            record.get("id"),
            allow_footnote_only=True,
        )
        _add_value_with_footnotes(
            transaction,
            "transactionDate",
            record.get("transactionDateValue"),
            record.get("transactionDateFootnoteIdId"),
            allow_footnote_only=False,
        )
        _add_value_with_footnotes(
            transaction,
            "deemedExecutionDate",
            record.get("deemedExecutionDateValue"),
            _first_present(record, ["deemedExecutionDateFootnoteIdId", "footnoteIdId"]),
            allow_footnote_only=True,
        )

        if any(_is_present(record.get(key)) for key in ["transactionFormType", "transactionCode", "equitySwapInvolved", "transactionCodingFootnoteIdId"]):
            coding = ET.SubElement(transaction, "transactionCoding")
            _add_text(coding, "transactionFormType", record.get("transactionFormType"))
            _add_text(coding, "transactionCode", record.get("transactionCode"))
            _add_text(coding, "equitySwapInvolved", record.get("equitySwapInvolved"))
            _add_footnote_ids(coding, record.get("transactionCodingFootnoteIdId"))

        _add_value_with_footnotes(
            transaction,
            "transactionTimeliness",
            record.get("transactionTimelinessValue"),
            record.get("transactionTimelinessFootnoteIdId"),
            allow_footnote_only=True,
        )

        if any(
            _is_present(record.get(key))
            for key in [
                "transactionSharesValue",
                "transactionTotalValueValue",
                "transactionPricePerShareValue",
                "transactionAcquiredDisposedCodeValue",
            ]
        ):
            amounts = ET.SubElement(transaction, "transactionAmounts")
            if _is_present(record.get("transactionSharesValue")):
                _add_value_with_footnotes(
                    amounts,
                    "transactionShares",
                    record.get("transactionSharesValue"),
                    record.get("transactionSharesFootnoteIdId"),
                    allow_footnote_only=False,
                )
            else:
                _add_value_with_footnotes(
                    amounts,
                    "transactionTotalValue",
                    record.get("transactionTotalValueValue"),
                    record.get("transactionTotalValueFootnoteIdId"),
                    allow_footnote_only=False,
                )
            _add_value_with_footnotes(
                amounts,
                "transactionPricePerShare",
                record.get("transactionPricePerShareValue"),
                record.get("transactionPricePerShareFootnoteIdId"),
                allow_footnote_only=True,
            )
            _add_value_with_footnotes(
                amounts,
                "transactionAcquiredDisposedCode",
                record.get("transactionAcquiredDisposedCodeValue"),
                None,
                allow_footnote_only=False,
            )

        _add_value_with_footnotes(
            transaction,
            "exerciseDate",
            record.get("exerciseDateValue"),
            record.get("exerciseDateFootnoteIdId"),
            allow_footnote_only=True,
        )
        _add_value_with_footnotes(
            transaction,
            "expirationDate",
            record.get("expirationDateValue"),
            record.get("expirationDateFootnoteIdId"),
            allow_footnote_only=True,
        )

        if any(
            _is_present(record.get(key))
            for key in [
                "underlyingSecurityTitleValue",
                "underlyingSecuritySharesValue",
                "underlyingSecurityValueValue",
            ]
        ):
            underlying = ET.SubElement(transaction, "underlyingSecurity")
            _add_value_with_footnotes(
                underlying,
                "underlyingSecurityTitle",
                record.get("underlyingSecurityTitleValue"),
                record.get("underlyingSecurityTitleFootnoteIdId"),
                allow_footnote_only=False,
            )
            if _is_present(record.get("underlyingSecuritySharesValue")):
                _add_value_with_footnotes(
                    underlying,
                    "underlyingSecurityShares",
                    record.get("underlyingSecuritySharesValue"),
                    record.get("underlyingSecuritySharesFootnoteIdId"),
                    allow_footnote_only=True,
                )
            else:
                _add_value_with_footnotes(
                    underlying,
                    "underlyingSecurityValue",
                    record.get("underlyingSecurityValueValue"),
                    record.get("underlyingSecurityValueFootnoteIdId"),
                    allow_footnote_only=True,
                )

        if _is_present(record.get("sharesOwnedFollowingTransactionValue")) or _is_present(record.get("valueOwnedFollowingTransactionValue")):
            post_transaction = ET.SubElement(transaction, "postTransactionAmounts")
            if _is_present(record.get("sharesOwnedFollowingTransactionValue")):
                _add_value_with_footnotes(
                    post_transaction,
                    "sharesOwnedFollowingTransaction",
                    record.get("sharesOwnedFollowingTransactionValue"),
                    record.get("sharesOwnedFollowingTransactionFootnoteIdId"),
                    allow_footnote_only=False,
                )
            else:
                _add_value_with_footnotes(
                    post_transaction,
                    "valueOwnedFollowingTransaction",
                    record.get("valueOwnedFollowingTransactionValue"),
                    record.get("valueOwnedFollowingTransactionFootnoteIdId"),
                    allow_footnote_only=False,
                )

        if _is_present(record.get("directOrIndirectOwnershipValue")) or _is_present(record.get("natureOfOwnershipValue")):
            ownership = ET.SubElement(transaction, "ownershipNature")
            _add_value_with_footnotes(
                ownership,
                "directOrIndirectOwnership",
                record.get("directOrIndirectOwnershipValue"),
                record.get("directOrIndirectOwnershipFootnoteIdId"),
                allow_footnote_only=False,
            )
            if _is_present(record.get("natureOfOwnershipValue")):
                _add_value_with_footnotes(
                    ownership,
                    "natureOfOwnership",
                    record.get("natureOfOwnershipValue"),
                    record.get("natureOfOwnershipFootnoteIdId"),
                    allow_footnote_only=False,
                )

    for record in holding_records:
        holding = ET.SubElement(table, "derivativeHolding")
        _add_value_with_footnotes(
            holding,
            "securityTitle",
            record.get("securityTitleValue"),
            record.get("securityTitleFootnoteIdId"),
            allow_footnote_only=False,
        )
        _add_value_with_footnotes(
            holding,
            "conversionOrExercisePrice",
            record.get("value"),
            record.get("id"),
            allow_footnote_only=True,
        )
        _add_value_with_footnotes(
            holding,
            "exerciseDate",
            record.get("exerciseDateValue"),
            _first_present(record, ["exerciseDateFootnoteIdId", "footnoteIdId"]),
            allow_footnote_only=True,
        )
        _add_value_with_footnotes(
            holding,
            "expirationDate",
            record.get("expirationDateValue"),
            record.get("expirationDateFootnoteIdId"),
            allow_footnote_only=True,
        )

        if any(
            _is_present(record.get(key))
            for key in [
                "underlyingSecurityTitleValue",
                "underlyingSecuritySharesValue",
                "underlyingSecurityValueValue",
            ]
        ):
            underlying = ET.SubElement(holding, "underlyingSecurity")
            _add_value_with_footnotes(
                underlying,
                "underlyingSecurityTitle",
                record.get("underlyingSecurityTitleValue"),
                record.get("underlyingSecurityTitleFootnoteIdId"),
                allow_footnote_only=False,
            )
            if _is_present(record.get("underlyingSecuritySharesValue")):
                _add_value_with_footnotes(
                    underlying,
                    "underlyingSecurityShares",
                    record.get("underlyingSecuritySharesValue"),
                    record.get("underlyingSecuritySharesFootnoteIdId"),
                    allow_footnote_only=True,
                )
            else:
                _add_value_with_footnotes(
                    underlying,
                    "underlyingSecurityValue",
                    record.get("underlyingSecurityValueValue"),
                    record.get("underlyingSecurityValueFootnoteIdId"),
                    allow_footnote_only=True,
                )

        if _is_present(record.get("sharesOwnedFollowingTransactionValue")) or _is_present(record.get("valueOwnedFollowingTransactionValue")):
            post_transaction = ET.SubElement(holding, "postTransactionAmounts")
            if _is_present(record.get("sharesOwnedFollowingTransactionValue")):
                _add_value_with_footnotes(
                    post_transaction,
                    "sharesOwnedFollowingTransaction",
                    record.get("sharesOwnedFollowingTransactionValue"),
                    record.get("sharesOwnedFollowingTransactionFootnoteIdId"),
                    allow_footnote_only=False,
                )
            else:
                _add_value_with_footnotes(
                    post_transaction,
                    "valueOwnedFollowingTransaction",
                    record.get("valueOwnedFollowingTransactionValue"),
                    record.get("valueOwnedFollowingTransactionFootnoteIdId"),
                    allow_footnote_only=False,
                )

        if _is_present(record.get("directOrIndirectOwnershipValue")) or _is_present(record.get("natureOfOwnershipValue")):
            ownership = ET.SubElement(holding, "ownershipNature")
            _add_value_with_footnotes(
                ownership,
                "directOrIndirectOwnership",
                record.get("directOrIndirectOwnershipValue"),
                record.get("directOrIndirectOwnershipFootnoteIdId"),
                allow_footnote_only=False,
            )
            if _is_present(record.get("natureOfOwnershipValue")):
                _add_value_with_footnotes(
                    ownership,
                    "natureOfOwnership",
                    record.get("natureOfOwnershipValue"),
                    record.get("natureOfOwnershipFootnoteIdId"),
                    allow_footnote_only=False,
                )


def _build_footnotes(root: ET.Element, rows: list[dict]) -> None:
    records = []

    section_rows = _rows_for_section(rows, "345_footnote", ["footnoteText", "footnoteId"])
    records.extend(_collect_records(section_rows, ["footnoteText", "footnoteId"]))

    derivative_rows = _rows_for_section(rows, "345_derivative_footnote", ["footnoteText", "id"])
    records.extend(_collect_records(derivative_rows, ["footnoteText", "id"]))

    seen = set()
    normalized = []
    for record in records:
        footnote_id = _first_present(record, ["footnoteId", "id"])
        text = record.get("footnoteText")
        if not _is_present(footnote_id):
            continue
        key = (_to_text(footnote_id), _to_text(text) if _is_present(text) else "")
        if key in seen:
            continue
        seen.add(key)
        normalized.append((footnote_id, text))

    if not normalized:
        return

    footnotes = ET.SubElement(root, "footnotes")
    for footnote_id, text in normalized:
        footnote = ET.SubElement(footnotes, "footnote", {"id": _to_text(footnote_id)})
        if _is_present(text):
            footnote.text = _to_text(text)


def _build_signatures(root: ET.Element, rows: list[dict]) -> None:
    section_rows = _rows_for_section(rows, "345_owner_signature", ["signatureDate", "signatureName"])
    records = _collect_records(section_rows, ["signatureDate", "signatureName"])

    if not records:
        fallback = {
            "signatureDate": _first_across_rows(rows, ["signatureDate"]),
            "signatureName": _first_across_rows(rows, ["signatureName"]),
        }
        if any(_is_present(v) for v in fallback.values()):
            records = [fallback]

    for record in records:
        signature = ET.SubElement(root, "ownerSignature")
        _add_text(signature, "signatureName", record.get("signatureName"))
        _add_text(signature, "signatureDate", record.get("signatureDate"))


def construct_form4(rows: list) -> bytes:
    normalized_rows = _normalize_rows(rows)

    root = ET.Element("ownershipDocument")
    _add_text(root, "schemaVersion", _first_across_rows(normalized_rows, ["schemaVersion"]))
    _add_text(root, "documentType", _first_across_rows(normalized_rows, ["documentType"]) or "4")
    _add_text(root, "periodOfReport", _first_across_rows(normalized_rows, ["periodOfReport"]))
    _add_text(root, "notSubjectToSection16", _first_across_rows(normalized_rows, ["notSubjectToSection16"]))

    issuer_values = {
        "issuerCik": _first_across_rows(normalized_rows, ["issuerCik"]),
        "issuerName": _first_across_rows(normalized_rows, ["issuerName"]),
        "issuerTradingSymbol": _first_across_rows(normalized_rows, ["issuerTradingSymbol"]),
        "issuerForeignTradingSymbol": _first_across_rows(normalized_rows, ["issuerForeignTradingSymbol"]),
    }
    if any(_is_present(value) for value in issuer_values.values()):
        issuer = ET.SubElement(root, "issuer")
        _add_text(issuer, "issuerCik", issuer_values["issuerCik"])
        _add_text(issuer, "issuerName", issuer_values["issuerName"])
        _add_text(issuer, "issuerTradingSymbol", issuer_values["issuerTradingSymbol"])
        _add_text(issuer, "issuerForeignTradingSymbol", issuer_values["issuerForeignTradingSymbol"])

    _build_reporting_owners(root, normalized_rows)

    _add_text(
        root,
        "aff10b5One",
        _first_across_rows(normalized_rows, ["aff10B5One", "aff10b5One"]) or "0",
    )

    _build_non_derivative_table(root, normalized_rows)
    _build_derivative_table(root, normalized_rows)
    _build_footnotes(root, normalized_rows)
    _add_text(root, "remarks", _first_across_rows(normalized_rows, ["remarks"]))
    _build_signatures(root, normalized_rows)

    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
