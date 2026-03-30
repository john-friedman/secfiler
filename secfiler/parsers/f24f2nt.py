import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment



NS_MAIN = "http://www.sec.gov/edgar/twentyfourf2filer"
NS_FEEC = "http://www.sec.gov/edgar/feecommon"
NS_COM = "http://www.sec.gov/edgar/common"


ET.register_namespace("", NS_MAIN)
ET.register_namespace("feec", NS_FEEC)
ET.register_namespace("com", NS_COM)


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
        out: list[str] = []
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


def _collect_records(
    rows: list[dict],
    field_aliases: dict[str, list[str]],
    marker_keys: list[str],
) -> list[dict]:
    records: list[dict] = []
    seen = set()

    for row in rows:
        if not any(_is_present(row.get(key)) for key in marker_keys):
            continue

        value_lists: dict[str, list[str]] = {}
        max_items = 0
        for field_name, aliases in field_aliases.items():
            value = _first_in_row(row, aliases)
            normalized = _normalize_values(value)
            value_lists[field_name] = normalized
            max_items = max(max_items, len(normalized))

        if max_items == 0:
            continue

        for index in range(max_items):
            record = {}
            for field_name, normalized in value_lists.items():
                if not normalized:
                    record[field_name] = None
                elif len(normalized) == 1:
                    record[field_name] = normalized[0]
                elif index < len(normalized):
                    record[field_name] = normalized[index]
                else:
                    record[field_name] = None

            if not any(_is_present(v) for v in record.values()):
                continue

            sig = tuple((k, "" if record.get(k) is None else _to_text(record.get(k))) for k in sorted(record))
            if sig in seen:
                continue
            seen.add(sig)
            records.append(record)

    return records


def construct_24f2nt(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", NS_MAIN)
    root.set("xmlns:feec", NS_FEEC)
    root.set("xmlns:com", NS_COM)

    _add_if_present(root, "schemaVersion", _first_across_rows(normalized_rows, ["schemaVersion"]) or "X0102")

    header_data = ET.SubElement(root, "headerData")
    _add_if_present(header_data, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]) or "24F-2NT")

    filer_info = ET.SubElement(header_data, "filerInfo")
    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    filer = ET.SubElement(filer_info, "filer")
    issuer_credentials = ET.SubElement(filer, "issuerCredentials")
    _add_if_present(issuer_credentials, "cik", _first_across_rows(normalized_rows, ["filerCik"]))
    _add_if_present(issuer_credentials, "ccc", _first_across_rows(normalized_rows, ["filerCcc"]))
    _add_if_present(filer, "fileNumber", _first_across_rows(normalized_rows, ["fileNumber"]))

    has_flags = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("overrideInternetFlag", "confirmingCopyFlag")
    )
    if has_flags:
        flags = ET.SubElement(filer_info, "flags")
        _add_if_present(flags, "overrideInternetFlag", _first_across_rows(normalized_rows, ["overrideInternetFlag"]))
        _add_if_present(flags, "confirmingCopyFlag", _first_across_rows(normalized_rows, ["confirmingCopyFlag"]))

    _add_if_present(filer_info, "investmentCompanyType", _first_across_rows(normalized_rows, ["investmentCompanyType"]))

    form_data = ET.SubElement(root, "formData")
    annual_filings = ET.SubElement(form_data, "annualFilings")
    annual_filing_info = ET.SubElement(annual_filings, "annualFilingInfo")

    item1 = ET.SubElement(annual_filing_info, "item1")
    _add_if_present(item1, "nameOfIssuer", _first_across_rows(normalized_rows, ["issuerName"]))

    address_of_issuer = ET.SubElement(item1, "addressOfIssuer")
    _add_if_present(address_of_issuer, "street1", _first_across_rows(normalized_rows, ["street1"]))
    _add_if_present(address_of_issuer, "street2", _first_across_rows(normalized_rows, ["street2"]))
    _add_if_present(address_of_issuer, "city", _first_across_rows(normalized_rows, ["city"]))
    _add_if_present(address_of_issuer, "state", _first_across_rows(normalized_rows, ["state"]))
    _add_if_present(address_of_issuer, "country", _first_across_rows(normalized_rows, ["country"]))
    _add_if_present(address_of_issuer, "zipCode", _first_across_rows(normalized_rows, ["zipCode"]))

    item2 = ET.SubElement(annual_filing_info, "item2")

    has_report_series_class = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("rptIncludeAllSeriesFlag", "seriesId", "seriesName", "includeAllClassesFlag", "classId", "className")
    )
    if has_report_series_class:
        report_series_class = ET.SubElement(item2, "reportSeriesClass")
        _add_if_present(
            report_series_class,
            "rptIncludeAllSeriesFlag",
            _first_across_rows(normalized_rows, ["rptIncludeAllSeriesFlag"]),
        )

        series_records = _collect_records(
            normalized_rows,
            {
                "seriesId": ["seriesId"],
                "seriesName": ["seriesName"],
                "includeAllClassesFlag": ["includeAllClassesFlag"],
                "classId": ["classId"],
                "className": ["className"],
            },
            marker_keys=["seriesId", "seriesName", "classId", "className"],
        )
        for record in series_records:
            rpt_series_class_info = ET.SubElement(report_series_class, "rptSeriesClassInfo")
            _add_if_present(rpt_series_class_info, "seriesName", record.get("seriesName"))
            _add_if_present(rpt_series_class_info, "seriesId", record.get("seriesId"))
            _add_if_present(rpt_series_class_info, "includeAllClassesFlag", record.get("includeAllClassesFlag"))

            if _is_present(record.get("classId")) or _is_present(record.get("className")):
                class_info = ET.SubElement(rpt_series_class_info, "classInfo")
                _add_if_present(class_info, "classId", record.get("classId"))
                _add_if_present(class_info, "className", record.get("className"))

    has_report_class = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("rptIncludeAllClassesFlag", "annualClassId", "annualClassName")
    )
    if has_report_class:
        report_class = ET.SubElement(item2, "reportClass")
        _add_if_present(
            report_class,
            "rptIncludeAllClassesFlag",
            _first_across_rows(normalized_rows, ["rptIncludeAllClassesFlag"]),
        )

        annual_class_records = _collect_records(
            normalized_rows,
            {
                "annualClassId": ["annualClassId"],
                "annualClassName": ["annualClassName"],
            },
            marker_keys=["annualClassId", "annualClassName"],
        )
        for record in annual_class_records:
            annual_class_info = ET.SubElement(report_class, "annualClassInfo")
            _add_if_present(annual_class_info, "classId", record.get("annualClassId"))
            _add_if_present(annual_class_info, "className", record.get("annualClassName"))

    has_report_class_name = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("rptIncludeAllFlag", "annualClassNameInfoClassName")
    )
    if has_report_class_name:
        report_class_name = ET.SubElement(item2, "reportClassName")
        _add_if_present(report_class_name, "rptIncludeAllFlag", _first_across_rows(normalized_rows, ["rptIncludeAllFlag"]))

        class_name_values = _normalize_values(_first_across_rows(normalized_rows, ["annualClassNameInfoClassName"]))
        for class_name in class_name_values:
            annual_class_name_info = ET.SubElement(report_class_name, "annualClassNameInfo")
            _add_if_present(annual_class_name_info, "className", class_name)

    item3 = ET.SubElement(annual_filing_info, "item3")
    _add_if_present(item3, "investmentCompActFileNo", _first_across_rows(normalized_rows, ["investmentCompActFileNo"]))

    securities_act_numbers = ET.SubElement(item3, "securitiesActFileNumbers")
    file_numbers = _normalize_values(_first_across_rows(normalized_rows, ["securitiesActFileNo"]))
    for number in file_numbers:
        securities_act_file_no = ET.SubElement(securities_act_numbers, "securitiesActFileNo")
        _add_if_present(securities_act_file_no, "fileNumber", number)

    item4 = ET.SubElement(annual_filing_info, "item4")
    _add_if_present(item4, "lastDayOfFiscalYear", _first_across_rows(normalized_rows, ["lastDayOfFiscalYear"]))
    _add_if_present(item4, "isThisFormBeingFiledLate", _first_across_rows(normalized_rows, ["isFiledLate"]))
    _add_if_present(item4, "isThisTheLastTimeIssuerFilingThisForm", _first_across_rows(normalized_rows, ["isLastFiling"]))

    item5 = ET.SubElement(annual_filing_info, "item5")
    _add_if_present(item5, "seriesOrClassId", _first_across_rows(normalized_rows, ["seriesOrClassId"]))
    _add_if_present(
        item5,
        "aggregateSalePriceOfSecuritiesSold",
        _first_across_rows(normalized_rows, ["aggregateSalePrice"]),
    )
    _add_if_present(
        item5,
        "aggregatePriceOfSecuritiesRedeemedOrRepurchasedInFiscalYear",
        _first_across_rows(normalized_rows, ["aggregateRedeemedInFiscalYear"]),
    )
    _add_if_present(
        item5,
        "aggregatePriceOfSecuritiesRedeemedOrRepurchasedAnyPrior",
        _first_across_rows(normalized_rows, ["aggregateRedeemedAnyPrior"]),
    )
    _add_if_present(
        item5,
        "totalAvailableRedemptionCredits",
        _first_across_rows(normalized_rows, ["totalRedemptionCredits"]),
    )
    _add_if_present(item5, "netSales", _first_across_rows(normalized_rows, ["netSales"]))
    _add_if_present(
        item5,
        "redemptionCreditsAvailableForUseInFutureYears",
        _first_across_rows(normalized_rows, ["redemptionCreditsAvailable"]),
    )
    _add_if_present(
        item5,
        "multiplierForDeterminingRegistrationFee",
        _first_across_rows(normalized_rows, ["feeMultiplier"]),
    )
    _add_if_present(item5, "registrationFeeDue", _first_across_rows(normalized_rows, ["registrationFeeDue"]))

    item6 = ET.SubElement(annual_filing_info, "item6")
    _add_if_present(
        item6,
        "numberOfSharesOrOtherUnitsRemainingUnsold",
        _first_across_rows(normalized_rows, ["sharesRemainingUnsold"]),
    )
    _add_if_present(item6, "amountOfSecuritiesDeducted", _first_across_rows(normalized_rows, ["securitiesDeducted"]))
    _add_if_present(item6, "interestDue", _first_across_rows(normalized_rows, ["item6InterestDue"]))

    has_item7 = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("item7InterestDue", "item7TotalFeePlusInterest")
    )
    if has_item7:
        item7 = ET.SubElement(annual_filing_info, "item7")
        _add_if_present(item7, "interestDue", _first_across_rows(normalized_rows, ["item7InterestDue"]))
        _add_if_present(
            item7,
            "totalOfRegistrationFeePlusAnyInterestDue",
            _first_across_rows(normalized_rows, ["item7TotalFeePlusInterest"]),
        )

    has_item8 = any(
        _is_present(_first_across_rows(normalized_rows, [key]))
        for key in ("item8TotalFeePlusInterest", "item8ExplanatoryNotes")
    )
    if has_item8:
        item8 = ET.SubElement(annual_filing_info, "item8")
        _add_if_present(
            item8,
            "totalOfRegistrationFeePlusAnyInterestDue",
            _first_across_rows(normalized_rows, ["item8TotalFeePlusInterest"]),
        )
        _add_if_present(item8, "explanatoryNotes", _first_across_rows(normalized_rows, ["item8ExplanatoryNotes"]))

    item9_notes = _first_across_rows(normalized_rows, ["item9ExplanatoryNotes"])
    if item9_notes is not None:
        item9 = ET.SubElement(annual_filing_info, "item9")
        _add_if_present(item9, "explanatoryNotes", item9_notes)

    signature = ET.SubElement(annual_filing_info, "signature")
    _add_if_present(signature, "signature", _first_across_rows(normalized_rows, ["signature"]))
    _add_if_present(signature, "nameAndTitle", _first_across_rows(normalized_rows, ["signatureNameAndTitle"]))
    _add_if_present(signature, "signatureDate", _first_across_rows(normalized_rows, ["signatureDate"]))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
