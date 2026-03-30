import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment



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
        values = []
        for item in value:
            values.extend(_normalize_values(item))
        return values

    text = _to_text(value).strip()
    if not text:
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


def _first_in_row(row: dict, aliases: list[str]):
    for alias in aliases:
        value = row.get(alias)
        if _is_present(value):
            return value
    return None


def _first_across_rows(rows: list[dict], aliases: list[str]):
    for row in rows:
        value = _first_in_row(row, aliases)
        if _is_present(value):
            return value
    return None


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _is_present(value):
        ET.SubElement(parent, tag).text = _to_text(value)


def _add_if_defined(parent: ET.Element, tag: str, row: dict, key: str) -> None:
    if key in row and row.get(key) is not None:
        ET.SubElement(parent, tag).text = _to_text(row.get(key))


def _record_signature(record: dict) -> tuple:
    return tuple((k, "" if record.get(k) is None else _to_text(record[k])) for k in sorted(record))


def _collect_records(
    rows: list[dict],
    keys: list[str],
    marker_keys: list[str] | None = None,
) -> list[dict]:
    records = []
    seen = set()

    for row in rows:
        if marker_keys and not any(_is_present(row.get(k)) for k in marker_keys):
            continue

        lists: dict[str, list[str]] = {}
        max_items = 0
        for key in keys:
            values = _normalize_values(row.get(key))
            lists[key] = values
            max_items = max(max_items, len(values))

        if max_items == 0:
            continue

        for idx in range(max_items):
            record = {}
            for key, values in lists.items():
                if not values:
                    record[key] = None
                elif len(values) == 1:
                    record[key] = values[0]
                elif idx < len(values):
                    record[key] = values[idx]
                else:
                    record[key] = None

            if not any(_is_present(v) for v in record.values()):
                continue

            sig = _record_signature(record)
            if sig in seen:
                continue
            seen.add(sig)
            records.append(record)

    return records


def construct_ctr(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    has_address_fields = any(
        any(
            key in row
            for key in ("street1", "street2", "city", "stateOrCountry", "zipCode")
        )
        for row in normalized_rows
    )

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/formc")
    if has_address_fields:
        root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_data = ET.SubElement(root, "headerData")
    _add_if_present(header_data, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]))

    filer_info = ET.SubElement(header_data, "filerInfo")
    filer = ET.SubElement(filer_info, "filer")
    filer_credentials = ET.SubElement(filer, "filerCredentials")
    _add_if_present(filer_credentials, "filerCik", _first_across_rows(normalized_rows, ["filerCik"]))
    _add_if_present(filer_credentials, "filerCcc", _first_across_rows(normalized_rows, ["filerCcc"]))

    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    flags = ET.SubElement(filer_info, "flags")
    ET.SubElement(flags, "confirmingCopyFlag").text = "false"
    ET.SubElement(flags, "returnCopyFlag").text = "false"
    ET.SubElement(flags, "overrideInternetFlag").text = "false"

    form_data = ET.SubElement(root, "formData")
    issuer_information = ET.SubElement(form_data, "issuerInformation")
    issuer_info = ET.SubElement(issuer_information, "issuerInfo")

    _add_if_present(issuer_info, "nameOfIssuer", _first_across_rows(normalized_rows, ["nameOfIssuer"]))

    legal_status_fields = ("legalStatusForm", "jurisdictionOrganization", "dateIncorporation", "legalStatusOtherDesc")
    has_legal_status = any(_is_present(_first_across_rows(normalized_rows, [k])) for k in legal_status_fields)
    if has_legal_status:
        legal_status = ET.SubElement(issuer_info, "legalStatus")
        _add_if_present(legal_status, "legalStatusForm", _first_across_rows(normalized_rows, ["legalStatusForm"]))
        _add_if_present(
            legal_status,
            "jurisdictionOrganization",
            _first_across_rows(normalized_rows, ["jurisdictionOrganization"]),
        )
        _add_if_present(legal_status, "dateIncorporation", _first_across_rows(normalized_rows, ["dateIncorporation"]))
        _add_if_present(legal_status, "legalStatusOtherDesc", _first_across_rows(normalized_rows, ["legalStatusOtherDesc"]))

    issuer_address_keys = ("street1", "street2", "city", "stateOrCountry", "zipCode")
    has_issuer_address = any(key in normalized_rows[0] for key in issuer_address_keys) or any(
        _is_present(_first_across_rows(normalized_rows, [k])) for k in issuer_address_keys
    )
    if has_issuer_address:
        issuer_address = ET.SubElement(issuer_info, "issuerAddress")
        _add_if_present(issuer_address, "com:street1", _first_across_rows(normalized_rows, ["street1"]))
        _add_if_defined(issuer_address, "com:street2", normalized_rows[0], "street2")
        _add_if_present(issuer_address, "com:city", _first_across_rows(normalized_rows, ["city"]))
        _add_if_present(issuer_address, "com:stateOrCountry", _first_across_rows(normalized_rows, ["stateOrCountry"]))
        _add_if_present(issuer_address, "com:zipCode", _first_across_rows(normalized_rows, ["zipCode"]))

    _add_if_present(issuer_info, "issuerWebsite", _first_across_rows(normalized_rows, ["issuerWebsite"]))

    co_issuer_records = _collect_records(
        normalized_rows,
        [
            "nameOfCoIssuer",
            "coIssuerCik",
            "coIssuerWebsite",
            "street1",
            "street2",
            "city",
            "stateOrCountry",
            "zipCode",
            "legalStatusForm",
            "jurisdictionOrganization",
            "dateIncorporation",
            "legalStatusOtherDesc",
        ],
        marker_keys=["nameOfCoIssuer", "coIssuerCik", "coIssuerWebsite"],
    )

    ET.SubElement(issuer_information, "isCoIssuer").text = "Y" if co_issuer_records else "N"

    if co_issuer_records:
        co_issuers = ET.SubElement(issuer_information, "coIssuers")
        for record in co_issuer_records:
            co_issuer_info = ET.SubElement(co_issuers, "coIssuerInfo")
            _add_if_present(co_issuer_info, "nameOfCoIssuer", record.get("nameOfCoIssuer"))
            _add_if_present(co_issuer_info, "coIssuerCik", record.get("coIssuerCik"))

            has_co_legal = any(
                _is_present(record.get(field))
                for field in ("legalStatusForm", "jurisdictionOrganization", "dateIncorporation", "legalStatusOtherDesc")
            )
            if has_co_legal:
                co_issuer_legal = ET.SubElement(co_issuer_info, "coIssuerLegalStatus")
                _add_if_present(co_issuer_legal, "legalStatusForm", record.get("legalStatusForm"))
                _add_if_present(co_issuer_legal, "jurisdictionOrganization", record.get("jurisdictionOrganization"))
                _add_if_present(co_issuer_legal, "dateIncorporation", record.get("dateIncorporation"))
                _add_if_present(co_issuer_legal, "legalStatusOtherDesc", record.get("legalStatusOtherDesc"))

            has_co_address = any(_is_present(record.get(field)) for field in ("street1", "street2", "city", "stateOrCountry", "zipCode"))
            if has_co_address:
                co_addr = ET.SubElement(co_issuer_info, "coIssuerAddress")
                _add_if_present(co_addr, "com:street1", record.get("street1"))
                if record.get("street2") is not None:
                    ET.SubElement(co_addr, "com:street2").text = _to_text(record.get("street2"))
                _add_if_present(co_addr, "com:city", record.get("city"))
                _add_if_present(co_addr, "com:stateOrCountry", record.get("stateOrCountry"))
                _add_if_present(co_addr, "com:zipCode", record.get("zipCode"))

            _add_if_present(co_issuer_info, "coIssuerWebsite", record.get("coIssuerWebsite"))

    signature_info = ET.SubElement(form_data, "signatureInfo")
    issuer_signature = ET.SubElement(signature_info, "issuerSignature")
    _add_if_present(issuer_signature, "issuer", _first_across_rows(normalized_rows, ["issuerSignature", "nameOfIssuer"]))
    _add_if_present(issuer_signature, "issuerSignature", _first_across_rows(normalized_rows, ["issuerSignatureText"]))
    _add_if_present(issuer_signature, "issuerTitle", _first_across_rows(normalized_rows, ["issuerTitle"]))

    signature_person_records = _collect_records(
        normalized_rows,
        ["personSignature", "personTitle", "signatureDate"],
        marker_keys=["personSignature", "personTitle", "signatureDate"],
    )
    if signature_person_records:
        signature_persons = ET.SubElement(signature_info, "signaturePersons")
        for record in signature_person_records:
            signature_person = ET.SubElement(signature_persons, "signaturePerson")
            _add_if_present(signature_person, "personSignature", record.get("personSignature"))
            _add_if_present(signature_person, "personTitle", record.get("personTitle"))
            _add_if_present(signature_person, "signatureDate", record.get("signatureDate"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
