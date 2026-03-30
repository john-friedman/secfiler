import io
import xml.etree.ElementTree as ET

from ..utils import _add_created_with_comment, _add_path_text, _ensure_path


_FORM_144_XMLNS = "http://www.sec.gov/edgar/ownership"
_COMMON_XMLNS = "http://www.sec.gov/edgar/common"


def _write_securities_to_be_sold(form_data: ET.Element, row: dict) -> None:
    keys = [
        "securitiesClassTitle",
        "acquiredDate",
        "natureOfAcquisitionTransaction",
        "nameOfPersonfromWhomAcquired",
        "isGiftTransaction",
        "amountOfSecuritiesAcquired",
        "donarAcquiredDate",
        "paymentDate",
        "natureOfPayment",
    ]
    if not any(row.get(key) is not None for key in keys):
        return

    node = _ensure_path(form_data, ["securitiesToBeSold"], create_leaf=True)
    _add_path_text(node, ["securitiesClassTitle"], row.get("securitiesClassTitle"))
    _add_path_text(node, ["acquiredDate"], row.get("acquiredDate"))
    _add_path_text(
        node,
        ["natureOfAcquisitionTransaction"],
        row.get("natureOfAcquisitionTransaction"),
    )
    _add_path_text(
        node,
        ["nameOfPersonfromWhomAcquired"],
        row.get("nameOfPersonfromWhomAcquired"),
    )
    _add_path_text(node, ["isGiftTransaction"], row.get("isGiftTransaction"))
    _add_path_text(
        node,
        ["amountOfSecuritiesAcquired"],
        row.get("amountOfSecuritiesAcquired"),
    )
    _add_path_text(node, ["donarAcquiredDate"], row.get("donarAcquiredDate"))
    _add_path_text(node, ["paymentDate"], row.get("paymentDate"))
    _add_path_text(node, ["natureOfPayment"], row.get("natureOfPayment"))


def _write_securities_sold_in_past_3_months(form_data: ET.Element, row: dict) -> None:
    keys = [
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
    ]
    if not any(row.get(key) is not None for key in keys):
        return

    node = _ensure_path(form_data, ["securitiesSoldInPast3Months"], create_leaf=True)
    _add_path_text(node, ["sellerDetails", "name"], row.get("sellerName"))
    _add_path_text(node, ["sellerDetails", "address", "com:street1"], row.get("street1"))
    _add_path_text(node, ["sellerDetails", "address", "com:street2"], row.get("street2"))
    _add_path_text(node, ["sellerDetails", "address", "com:city"], row.get("city"))
    _add_path_text(
        node,
        ["sellerDetails", "address", "com:stateOrCountry"],
        row.get("stateOrCountry"),
    )
    _add_path_text(node, ["sellerDetails", "address", "com:zipCode"], row.get("zipCode"))
    _add_path_text(node, ["securitiesClassTitle"], row.get("securitiesClassTitle"))
    _add_path_text(node, ["saleDate"], row.get("saleDate"))
    _add_path_text(node, ["amountOfSecuritiesSold"], row.get("amountOfSecuritiesSold"))
    _add_path_text(node, ["grossProceeds"], row.get("grossProceeds"))


def _write_notice_signature(form_data: ET.Element, rows: list[dict]) -> None:
    has_notice_data = any(
        row.get("noticeDate") is not None
        or row.get("planAdoptionDate") is not None
        or row.get("signature") is not None
        for row in rows
    )
    if not has_notice_data:
        return

    notice_signature = _ensure_path(form_data, ["noticeSignature"])
    for row in rows:
        _add_path_text(notice_signature, ["noticeDate"], row.get("noticeDate"))
        _add_path_text(notice_signature, ["signature"], row.get("signature"))

        if row.get("planAdoptionDate") is not None:
            plan_adoption_date = _ensure_path(
                notice_signature,
                ["planAdoptionDates", "planAdoptionDate"],
                create_leaf=True,
            )
            if plan_adoption_date.text is None:
                plan_adoption_date.text = row.get("planAdoptionDate")


def construct_144(rows: list) -> bytes:

    root = ET.Element("edgarSubmission")
    root.set("xmlns", _FORM_144_XMLNS)
    root.set("xmlns:com", _COMMON_XMLNS)

    for row in rows:
        _add_path_text(root, ["headerData", "submissionType"], row.get("submissionType"))
        _add_path_text(
            root,
            ["headerData", "previousAccessionNumber"],
            row.get("previousAccessionNumber"),
        )
        _add_path_text(
            root,
            ["headerData", "filerInfo", "filer", "filerCredentials", "cik"],
            row.get("filerCik"),
        )
        _add_path_text(
            root,
            ["headerData", "filerInfo", "filer", "filerCredentials", "ccc"],
            row.get("filerCcc"),
        )
        _add_path_text(
            root,
            ["headerData", "filerInfo", "liveTestFlag"],
            row.get("liveTestFlag"),
        )
        _add_path_text(
            root,
            ["headerData", "filerInfo", "contact", "contactName"],
            row.get("contactName"),
        )
        _add_path_text(
            root,
            ["headerData", "filerInfo", "contact", "contactPhoneNumber"],
            row.get("contactPhoneNumber"),
        )
        _add_path_text(
            root,
            ["headerData", "filerInfo", "contact", "contactEmailAddress"],
            row.get("contactEmailAddress"),
        )
        _add_path_text(
            root,
            ["headerData", "filerInfo", "flags", "overrideInternetFlag"],
            row.get("overrideInternetFlag"),
        )

        _add_path_text(root, ["formData", "issuerInfo", "issuerCik"], row.get("issuerCik"))
        _add_path_text(root, ["formData", "issuerInfo", "issuerName"], row.get("issuerName"))
        _add_path_text(
            root,
            ["formData", "issuerInfo", "secFileNumber"],
            row.get("secFileNumber"),
        )
        _add_path_text(
            root,
            ["formData", "issuerInfo", "issuerAddress", "com:street1"],
            row.get("street1"),
        )
        _add_path_text(
            root,
            ["formData", "issuerInfo", "issuerAddress", "com:street2"],
            row.get("street2"),
        )
        _add_path_text(
            root,
            ["formData", "issuerInfo", "issuerAddress", "com:city"],
            row.get("city"),
        )
        _add_path_text(
            root,
            ["formData", "issuerInfo", "issuerAddress", "com:stateOrCountry"],
            row.get("stateOrCountry"),
        )
        _add_path_text(
            root,
            ["formData", "issuerInfo", "issuerAddress", "com:zipCode"],
            row.get("zipCode"),
        )
        _add_path_text(
            root,
            ["formData", "issuerInfo", "issuerContactPhone"],
            row.get("issuerContactPhone"),
        )
        _add_path_text(
            root,
            [
                "formData",
                "issuerInfo",
                "nameOfPersonForWhoseAccountTheSecuritiesAreToBeSold",
            ],
            row.get("nameOfPersonForWhoseAccount"),
        )
        _add_path_text(
            root,
            ["formData", "issuerInfo", "relationshipsToIssuer", "relationshipToIssuer"],
            row.get("relationshipToIssuer"),
        )

        _add_path_text(
            root,
            ["formData", "securitiesInformation", "securitiesClassTitle"],
            row.get("securitiesInfoClassTitle"),
        )
        _add_path_text(
            root,
            ["formData", "securitiesInformation", "brokerOrMarketmakerDetails", "name"],
            row.get("brokerName"),
        )
        _add_path_text(
            root,
            [
                "formData",
                "securitiesInformation",
                "brokerOrMarketmakerDetails",
                "address",
                "com:street1",
            ],
            row.get("brokerStreet1"),
        )
        _add_path_text(
            root,
            [
                "formData",
                "securitiesInformation",
                "brokerOrMarketmakerDetails",
                "address",
                "com:street2",
            ],
            row.get("brokerStreet2"),
        )
        _add_path_text(
            root,
            [
                "formData",
                "securitiesInformation",
                "brokerOrMarketmakerDetails",
                "address",
                "com:city",
            ],
            row.get("brokerCity"),
        )
        _add_path_text(
            root,
            [
                "formData",
                "securitiesInformation",
                "brokerOrMarketmakerDetails",
                "address",
                "com:stateOrCountry",
            ],
            row.get("brokerStateOrCountry"),
        )
        _add_path_text(
            root,
            [
                "formData",
                "securitiesInformation",
                "brokerOrMarketmakerDetails",
                "address",
                "com:zipCode",
            ],
            row.get("brokerZipCode"),
        )
        _add_path_text(
            root,
            ["formData", "securitiesInformation", "noOfUnitsSold"],
            row.get("noOfUnitsSold"),
        )
        _add_path_text(
            root,
            ["formData", "securitiesInformation", "aggregateMarketValue"],
            row.get("aggregateMarketValue"),
        )
        _add_path_text(
            root,
            ["formData", "securitiesInformation", "noOfUnitsOutstanding"],
            row.get("noOfUnitsOutstanding"),
        )
        _add_path_text(
            root,
            ["formData", "securitiesInformation", "approxSaleDate"],
            row.get("approxSaleDate"),
        )
        _add_path_text(
            root,
            ["formData", "securitiesInformation", "securitiesExchangeName"],
            row.get("securitiesExchangeName"),
        )

    form_data = _ensure_path(root, ["formData"])

    for row in rows:
        _write_securities_to_be_sold(form_data, row)

    for row in rows:
        _add_path_text(
            form_data,
            ["nothingToReportFlagOnSecuritiesSoldInPast3Months"],
            row.get("nothingToReportFlag"),
        )

    for row in rows:
        _write_securities_sold_in_past_3_months(form_data, row)

    for row in rows:
        _add_path_text(form_data, ["remarks"], row.get("remarks"))

    _write_notice_signature(form_data, rows)

    _add_created_with_comment(root)
    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")

