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
    if not text.strip():
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


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _is_present(value):
        ET.SubElement(parent, tag).text = _to_text(value)


def _add_if_defined(parent: ET.Element, tag: str, row: dict, key: str) -> None:
    if key in row and row.get(key) is not None:
        ET.SubElement(parent, tag).text = _to_text(row.get(key))


def _record_signature(record: dict) -> tuple:
    return tuple((k, "" if record.get(k) is None else _to_text(record[k])) for k in sorted(record))


def _collect_records(rows: list[dict], keys: list[str], marker_keys: list[str]) -> list[dict]:
    records = []
    seen = set()
    for row in rows:
        if not any(_is_present(row.get(k)) for k in marker_keys):
            continue

        lists = {}
        max_items = 0
        for key in keys:
            vals = _normalize_values(row.get(key))
            lists[key] = vals
            max_items = max(max_items, len(vals))
        if max_items == 0:
            continue

        for idx in range(max_items):
            record = {}
            for key, vals in lists.items():
                if not vals:
                    record[key] = None
                elif len(vals) == 1:
                    record[key] = vals[0]
                elif idx < len(vals):
                    record[key] = vals[idx]
                else:
                    record[key] = None

            sig = _record_signature(record)
            if sig in seen:
                continue
            seen.add(sig)
            records.append(record)
    return records


def construct_144(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    main_row = None
    for row in normalized_rows:
        if _is_present(row.get("issuerCik")) or _is_present(row.get("issuerName")):
            main_row = row
            break
    if main_row is None:
        main_row = normalized_rows[0]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/ownership")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_data = ET.SubElement(root, "headerData")
    _add_if_present(header_data, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]))
    _add_if_present(
        header_data,
        "previousAccessionNumber",
        _first_across_rows(normalized_rows, ["previousAccessionNumber"]),
    )

    filer_info = ET.SubElement(header_data, "filerInfo")
    filer = ET.SubElement(filer_info, "filer")
    filer_credentials = ET.SubElement(filer, "filerCredentials")
    _add_if_present(filer_credentials, "cik", _first_across_rows(normalized_rows, ["filerCik"]))
    _add_if_present(filer_credentials, "ccc", _first_across_rows(normalized_rows, ["filerCcc"]))
    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    contact_fields = ("contactName", "contactPhoneNumber", "contactEmailAddress")
    if any(_is_present(_first_across_rows(normalized_rows, [field])) for field in contact_fields):
        contact = ET.SubElement(filer_info, "contact")
        _add_if_present(contact, "contactName", _first_across_rows(normalized_rows, ["contactName"]))
        _add_if_present(contact, "contactPhoneNumber", _first_across_rows(normalized_rows, ["contactPhoneNumber"]))
        _add_if_present(contact, "contactEmailAddress", _first_across_rows(normalized_rows, ["contactEmailAddress"]))

    if _is_present(_first_across_rows(normalized_rows, ["overrideInternetFlag"])):
        header_flags = ET.SubElement(filer_info, "flags")
        _add_if_present(header_flags, "overrideInternetFlag", _first_across_rows(normalized_rows, ["overrideInternetFlag"]))

    form_data = ET.SubElement(root, "formData")

    issuer_info = ET.SubElement(form_data, "issuerInfo")
    _add_if_present(issuer_info, "issuerCik", _first_across_rows(normalized_rows, ["issuerCik"]))
    _add_if_present(issuer_info, "issuerName", _first_across_rows(normalized_rows, ["issuerName"]))
    _add_if_present(issuer_info, "secFileNumber", _first_across_rows(normalized_rows, ["secFileNumber"]))

    issuer_address = ET.SubElement(issuer_info, "issuerAddress")
    _add_if_present(issuer_address, "com:street1", _first_across_rows(normalized_rows, ["street1"]))
    if "street2" in main_row:
        _add_if_defined(issuer_address, "com:street2", main_row, "street2")
    _add_if_present(issuer_address, "com:city", _first_across_rows(normalized_rows, ["city"]))
    _add_if_present(issuer_address, "com:stateOrCountry", _first_across_rows(normalized_rows, ["stateOrCountry"]))
    _add_if_present(issuer_address, "com:zipCode", _first_across_rows(normalized_rows, ["zipCode"]))

    _add_if_present(issuer_info, "issuerContactPhone", _first_across_rows(normalized_rows, ["issuerContactPhone"]))
    _add_if_present(
        issuer_info,
        "nameOfPersonForWhoseAccountTheSecuritiesAreToBeSold",
        _first_across_rows(normalized_rows, ["nameOfPersonForWhoseAccount"]),
    )

    relationship = _first_across_rows(normalized_rows, ["relationshipToIssuer"])
    if _is_present(relationship):
        relationships = ET.SubElement(issuer_info, "relationshipsToIssuer")
        _add_if_present(relationships, "relationshipToIssuer", relationship)

    securities_information = ET.SubElement(form_data, "securitiesInformation")
    _add_if_present(securities_information, "securitiesClassTitle", _first_across_rows(normalized_rows, ["securitiesInfoClassTitle"]))

    broker_details = ET.SubElement(securities_information, "brokerOrMarketmakerDetails")
    _add_if_present(broker_details, "name", _first_across_rows(normalized_rows, ["brokerName"]))
    broker_address = ET.SubElement(broker_details, "address")
    _add_if_present(broker_address, "com:street1", _first_across_rows(normalized_rows, ["brokerStreet1"]))
    if _is_present(_first_across_rows(normalized_rows, ["brokerStreet2"])) or ("brokerStreet2" in main_row):
        _add_if_defined(broker_address, "com:street2", main_row, "brokerStreet2")
    _add_if_present(broker_address, "com:city", _first_across_rows(normalized_rows, ["brokerCity"]))
    _add_if_present(broker_address, "com:stateOrCountry", _first_across_rows(normalized_rows, ["brokerStateOrCountry"]))
    _add_if_present(broker_address, "com:zipCode", _first_across_rows(normalized_rows, ["brokerZipCode"]))

    _add_if_present(securities_information, "noOfUnitsSold", _first_across_rows(normalized_rows, ["noOfUnitsSold"]))
    _add_if_present(securities_information, "aggregateMarketValue", _first_across_rows(normalized_rows, ["aggregateMarketValue"]))
    _add_if_present(securities_information, "noOfUnitsOutstanding", _first_across_rows(normalized_rows, ["noOfUnitsOutstanding"]))
    _add_if_present(securities_information, "approxSaleDate", _first_across_rows(normalized_rows, ["approxSaleDate"]))
    _add_if_present(securities_information, "securitiesExchangeName", _first_across_rows(normalized_rows, ["securitiesExchangeName"]))

    securities_to_be_sold_records = _collect_records(
        normalized_rows,
        [
            "securitiesClassTitle",
            "acquiredDate",
            "natureOfAcquisitionTransaction",
            "nameOfPersonfromWhomAcquired",
            "isGiftTransaction",
            "amountOfSecuritiesAcquired",
            "donarAcquiredDate",
            "paymentDate",
            "natureOfPayment",
        ],
        marker_keys=["acquiredDate", "amountOfSecuritiesAcquired", "nameOfPersonfromWhomAcquired"],
    )
    if not securities_to_be_sold_records:
        securities_to_be_sold_records = [{}]
    for record in securities_to_be_sold_records:
        securities_to_be_sold = ET.SubElement(form_data, "securitiesToBeSold")
        _add_if_present(securities_to_be_sold, "securitiesClassTitle", record.get("securitiesClassTitle"))
        _add_if_present(securities_to_be_sold, "acquiredDate", record.get("acquiredDate"))
        _add_if_present(
            securities_to_be_sold,
            "natureOfAcquisitionTransaction",
            record.get("natureOfAcquisitionTransaction"),
        )
        _add_if_present(
            securities_to_be_sold,
            "nameOfPersonfromWhomAcquired",
            record.get("nameOfPersonfromWhomAcquired"),
        )
        _add_if_present(securities_to_be_sold, "isGiftTransaction", record.get("isGiftTransaction"))
        _add_if_present(
            securities_to_be_sold,
            "amountOfSecuritiesAcquired",
            record.get("amountOfSecuritiesAcquired"),
        )
        _add_if_present(securities_to_be_sold, "donarAcquiredDate", record.get("donarAcquiredDate"))
        _add_if_present(securities_to_be_sold, "paymentDate", record.get("paymentDate"))
        _add_if_present(securities_to_be_sold, "natureOfPayment", record.get("natureOfPayment"))

    _add_if_present(
        form_data,
        "nothingToReportFlagOnSecuritiesSoldInPast3Months",
        _first_across_rows(normalized_rows, ["nothingToReportFlag"]),
    )

    securities_sold_records = _collect_records(
        normalized_rows,
        [
            "sellerName",
            "street1",
            "street2",
            "city",
            "stateOrCountry",
            "zipCode",
            "securitiesClassTitle",
            "saleDate",
            "amountOfSecuritiesSold",
            "grossProceeds",
        ],
        marker_keys=["amountOfSecuritiesSold", "saleDate", "grossProceeds", "sellerName"],
    )
    for record in securities_sold_records:
        sold = ET.SubElement(form_data, "securitiesSoldInPast3Months")
        seller = ET.SubElement(sold, "sellerDetails")
        _add_if_present(seller, "name", record.get("sellerName"))
        seller_addr = ET.SubElement(seller, "address")
        _add_if_present(seller_addr, "com:street1", record.get("street1"))
        if record.get("street2") is not None:
            ET.SubElement(seller_addr, "com:street2").text = _to_text(record.get("street2"))
        _add_if_present(seller_addr, "com:city", record.get("city"))
        _add_if_present(seller_addr, "com:stateOrCountry", record.get("stateOrCountry"))
        _add_if_present(seller_addr, "com:zipCode", record.get("zipCode"))
        _add_if_present(sold, "securitiesClassTitle", record.get("securitiesClassTitle"))
        _add_if_present(sold, "saleDate", record.get("saleDate"))
        _add_if_present(sold, "amountOfSecuritiesSold", record.get("amountOfSecuritiesSold"))
        _add_if_present(sold, "grossProceeds", record.get("grossProceeds"))

    _add_if_present(form_data, "remarks", _first_across_rows(normalized_rows, ["remarks"]))

    notice_signature = ET.SubElement(form_data, "noticeSignature")
    _add_if_present(notice_signature, "noticeDate", _first_across_rows(normalized_rows, ["noticeDate"]))
    plan_dates = _normalize_values(_first_across_rows(normalized_rows, ["planAdoptionDate"]))
    if plan_dates:
        plan_adoption_dates = ET.SubElement(notice_signature, "planAdoptionDates")
        for plan_date in plan_dates:
            ET.SubElement(plan_adoption_dates, "planAdoptionDate").text = plan_date
    _add_if_present(notice_signature, "signature", _first_across_rows(normalized_rows, ["signature"]))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
