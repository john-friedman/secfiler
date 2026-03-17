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


def _add_if_defined(parent: ET.Element, tag: str, value) -> None:
    if value is not None:
        ET.SubElement(parent, tag).text = _to_text(value)


def _record_signature(record: dict, keys: list[str]) -> tuple:
    return tuple((key, "" if record.get(key) is None else _to_text(record.get(key))) for key in keys)


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

            if not any(_is_present(value) for value in record.values()):
                continue

            signature = _record_signature(record, sorted(record))
            if signature in seen:
                continue
            seen.add(signature)
            records.append(record)

    return records


def _rows_with_any_keys(rows: list[dict], keys: list[str]) -> list[dict]:
    out = []
    for row in rows:
        if any(key in row for key in keys):
            out.append(row)
    return out


def construct_npx(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    investment_manager_rows = _collect_records(
        normalized_rows,
        {
            "serialNo": ["serialNo"],
            "form13FFileNumber": ["form13FFileNumber"],
            "crdNumber": ["crdNumber"],
            "secFileNumber": ["secFileNumber"],
            "leiNumber": ["leiNumber"],
            "name": ["name"],
        },
        marker_keys=["serialNo", "form13FFileNumber", "secFileNumber", "name"],
    )

    other_manager_rows = _collect_records(
        normalized_rows,
        {
            "managerName": ["managerName"],
            "crdNumber": ["crdNumber"],
            "icaOr13FFileNumber": ["icaOr13FFileNumber"],
            "otherFileNumber": ["otherFileNumber"],
            "leiNumberOM": ["leiNumberOM", "otherManagerLeiNumber", "leiNumber"],
        },
        marker_keys=["managerName", "icaOr13FFileNumber", "otherFileNumber"],
    )

    series_report_rows = _collect_records(
        normalized_rows,
        {
            "idOfSeries": ["idOfSeries"],
            "nameOfSeries": ["nameOfSeries"],
            "leiOfSeries": ["leiOfSeries"],
            "rptIncludeAllSeriesFlag": ["rptIncludeAllSeriesFlag", "includeAllClassesFlag"],
        },
        marker_keys=["idOfSeries", "nameOfSeries", "leiOfSeries"],
    )

    secondary_signature_rows = _collect_records(
        normalized_rows,
        {
            "printedSign": ["printedSign"],
            "txSignature": ["txSignature"],
            "txTitle": ["txTitle"],
            "txAsOfDate": ["txAsOfDate"],
        },
        marker_keys=["printedSign"],
    )

    core_rows = _rows_with_any_keys(
        normalized_rows,
        [
            "submissionType",
            "registrantType",
            "investmentCompanyType",
            "liveTestFlag",
            "filerCik",
            "filerCcc",
            "fileNumber",
            "confirmingCopyFlag",
            "overrideInternetFlag",
            "periodOfReport",
            "yearOrQuarter",
            "reportCalendarYear",
            "reportQuarterYear",
            "coverFileNumber",
            "leiNumber",
            "reportingSecFileNumber",
            "reportingCrdNumber",
            "reportingPersonName",
            "reportingPersonPhone",
            "street1",
            "street2",
            "city",
            "stateOrCountry",
            "zipCode",
            "agentName",
            "agentStreet1",
            "agentStreet2",
            "agentCity",
            "agentStateOrCountry",
            "agentZipCode",
            "reportType",
            "confidentialTreatment",
            "noticeExplanation",
            "isAmendment",
            "amendmentNo",
            "amendmentType",
            "confDeniedExpired",
            "dateExpiredDenied",
            "dateReported",
            "reasonForNonConfidentiality",
            "explanatoryChoice",
            "explanatoryNotes",
            "otherIncludedManagersCount",
            "seriesCount",
            "signatureReportingPerson",
            "txSignature",
            "txPrintedSignature",
            "txTitle",
            "txAsOfDate",
        ],
    ) or normalized_rows

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/npx")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_data = ET.SubElement(root, "headerData")
    _add_if_present(header_data, "submissionType", _first_across_rows(core_rows, ["submissionType"]) or "N-PX")

    filer_info = ET.SubElement(header_data, "filerInfo")
    _add_if_present(filer_info, "registrantType", _first_across_rows(core_rows, ["registrantType"]))
    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(core_rows, ["liveTestFlag"]))

    filer = ET.SubElement(filer_info, "filer")
    issuer_credentials = ET.SubElement(filer, "issuerCredentials")
    _add_if_present(issuer_credentials, "cik", _first_across_rows(core_rows, ["filerCik"]))
    _add_if_present(issuer_credentials, "ccc", _first_across_rows(core_rows, ["filerCcc"]))
    _add_if_present(filer, "fileNumber", _first_across_rows(core_rows, ["fileNumber"]))

    flags = ET.SubElement(filer_info, "flags")
    _add_if_present(flags, "overrideInternetFlag", _first_across_rows(core_rows, ["overrideInternetFlag"]))
    _add_if_present(flags, "confirmingCopyFlag", _first_across_rows(core_rows, ["confirmingCopyFlag"]))

    _add_if_present(filer_info, "investmentCompanyType", _first_across_rows(core_rows, ["investmentCompanyType"]))
    _add_if_present(filer_info, "periodOfReport", _first_across_rows(core_rows, ["periodOfReport"]))

    if series_report_rows:
        series_class = ET.SubElement(header_data, "seriesClass")
        report_series_class = ET.SubElement(series_class, "reportSeriesClass")

        include_all_series_flag = _first_across_rows(core_rows, ["rptIncludeAllSeriesFlag"])
        if _is_present(include_all_series_flag):
            _add_if_present(report_series_class, "rptIncludeAllSeriesFlag", include_all_series_flag)

        for record in series_report_rows:
            rpt_series_class_info = ET.SubElement(report_series_class, "rptSeriesClassInfo")
            _add_if_present(rpt_series_class_info, "seriesId", record.get("idOfSeries"))

            include_all_classes = record.get("rptIncludeAllSeriesFlag")
            if not _is_present(include_all_classes):
                include_all_classes = "true"
            _add_if_present(rpt_series_class_info, "includeAllClassesFlag", include_all_classes)

    form_data = ET.SubElement(root, "formData")

    cover_page = ET.SubElement(form_data, "coverPage")
    _add_if_present(cover_page, "yearOrQuarter", _first_across_rows(core_rows, ["yearOrQuarter"]))
    _add_if_present(cover_page, "reportCalendarYear", _first_across_rows(core_rows, ["reportCalendarYear"]))
    _add_if_present(cover_page, "reportQuarterYear", _first_across_rows(core_rows, ["reportQuarterYear"]))

    has_amendment = any(
        _is_present(_first_across_rows(core_rows, [key]))
        for key in (
            "isAmendment",
            "amendmentNo",
            "amendmentType",
            "confDeniedExpired",
            "dateExpiredDenied",
            "dateReported",
            "reasonForNonConfidentiality",
        )
    )
    if has_amendment:
        amendment_info = ET.SubElement(cover_page, "amendmentInfo")
        _add_if_present(amendment_info, "isAmendment", _first_across_rows(core_rows, ["isAmendment"]))
        _add_if_present(amendment_info, "amendmentNo", _first_across_rows(core_rows, ["amendmentNo"]))
        _add_if_present(amendment_info, "amendmentType", _first_across_rows(core_rows, ["amendmentType"]))
        _add_if_present(amendment_info, "confDeniedExpired", _first_across_rows(core_rows, ["confDeniedExpired"]))
        _add_if_present(amendment_info, "dateExpiredDenied", _first_across_rows(core_rows, ["dateExpiredDenied"]))
        _add_if_present(amendment_info, "dateReported", _first_across_rows(core_rows, ["dateReported"]))
        _add_if_present(
            amendment_info,
            "reasonForNonConfidentiality",
            _first_across_rows(core_rows, ["reasonForNonConfidentiality"]),
        )

    reporting_person = ET.SubElement(cover_page, "reportingPerson")
    _add_if_present(reporting_person, "name", _first_across_rows(core_rows, ["reportingPersonName"]))
    _add_if_present(reporting_person, "phoneNumber", _first_across_rows(core_rows, ["reportingPersonPhone"]))

    has_reporting_address = any(
        _is_present(_first_across_rows(core_rows, [key]))
        for key in ("street1", "street2", "city", "stateOrCountry", "zipCode")
    )
    if has_reporting_address:
        reporting_address = ET.SubElement(reporting_person, "address")
        _add_if_present(reporting_address, "com:street1", _first_across_rows(core_rows, ["street1"]))
        _add_if_present(reporting_address, "com:street2", _first_across_rows(core_rows, ["street2"]))
        _add_if_present(reporting_address, "com:city", _first_across_rows(core_rows, ["city"]))
        _add_if_present(reporting_address, "com:stateOrCountry", _first_across_rows(core_rows, ["stateOrCountry"]))
        _add_if_present(reporting_address, "com:zipCode", _first_across_rows(core_rows, ["zipCode"]))

    has_agent_for_service = any(
        _is_present(_first_across_rows(core_rows, [key]))
        for key in ("agentName", "agentStreet1", "agentStreet2", "agentCity", "agentStateOrCountry", "agentZipCode")
    )
    if has_agent_for_service:
        agent_for_service = ET.SubElement(cover_page, "agentForService")
        _add_if_present(agent_for_service, "name", _first_across_rows(core_rows, ["agentName"]))

        agent_address = ET.SubElement(agent_for_service, "address")
        _add_if_present(agent_address, "com:street1", _first_across_rows(core_rows, ["agentStreet1"]))
        _add_if_present(agent_address, "com:street2", _first_across_rows(core_rows, ["agentStreet2"]))
        _add_if_present(agent_address, "com:city", _first_across_rows(core_rows, ["agentCity"]))
        _add_if_present(agent_address, "com:stateOrCountry", _first_across_rows(core_rows, ["agentStateOrCountry"]))
        _add_if_present(agent_address, "com:zipCode", _first_across_rows(core_rows, ["agentZipCode"]))

    report_info = ET.SubElement(cover_page, "reportInfo")
    _add_if_present(report_info, "reportType", _first_across_rows(core_rows, ["reportType"]))
    _add_if_present(report_info, "confidentialTreatment", _first_across_rows(core_rows, ["confidentialTreatment"]))
    _add_if_present(report_info, "noticeExplanation", _first_across_rows(core_rows, ["noticeExplanation"]))

    _add_if_present(cover_page, "fileNumber", _first_across_rows(core_rows, ["coverFileNumber"]))
    _add_if_present(cover_page, "leiNumber", _first_across_rows(core_rows, ["leiNumber"]))
    _add_if_present(cover_page, "reportingSecFileNumber", _first_across_rows(core_rows, ["reportingSecFileNumber"]))
    _add_if_present(cover_page, "reportingCrdNumber", _first_across_rows(core_rows, ["reportingCrdNumber"]))

    has_explanatory = any(
        _is_present(_first_across_rows(core_rows, [key]))
        for key in ("explanatoryChoice", "explanatoryNotes")
    )
    if has_explanatory:
        explanatory_information = ET.SubElement(cover_page, "explanatoryInformation")
        _add_if_present(
            explanatory_information,
            "explanatoryChoice",
            _first_across_rows(core_rows, ["explanatoryChoice"]),
        )
        _add_if_present(
            explanatory_information,
            "explanatoryNotes",
            _first_across_rows(core_rows, ["explanatoryNotes"]),
        )

    if other_manager_rows:
        other_managers_info = ET.SubElement(cover_page, "otherManagersInfo")
        for record in other_manager_rows:
            other_manager = ET.SubElement(other_managers_info, "otherManager")
            _add_if_present(other_manager, "managerName", record.get("managerName"))
            _add_if_present(other_manager, "crdNumber", record.get("crdNumber"))
            _add_if_present(other_manager, "icaOr13FFileNumber", record.get("icaOr13FFileNumber"))
            _add_if_present(other_manager, "otherFileNumber", record.get("otherFileNumber"))
            _add_if_present(other_manager, "leiNumberOM", record.get("leiNumberOM"))

    summary_page = ET.SubElement(form_data, "summaryPage")
    _add_if_present(
        summary_page,
        "otherIncludedManagersCount",
        _first_across_rows(core_rows, ["otherIncludedManagersCount"]),
    )

    if investment_manager_rows:
        other_managers2 = ET.SubElement(summary_page, "otherManagers2")
        for record in investment_manager_rows:
            investment_managers = ET.SubElement(other_managers2, "investmentManagers")
            _add_if_present(investment_managers, "serialNo", record.get("serialNo"))
            _add_if_present(investment_managers, "form13FFileNumber", record.get("form13FFileNumber"))
            _add_if_present(investment_managers, "crdNumber", record.get("crdNumber"))
            _add_if_present(investment_managers, "secFileNumber", record.get("secFileNumber"))
            _add_if_present(investment_managers, "leiNumber", record.get("leiNumber"))
            _add_if_present(investment_managers, "name", record.get("name"))

    if series_report_rows:
        series_page = ET.SubElement(form_data, "seriesPage")
        _add_if_present(series_page, "seriesCount", _first_across_rows(core_rows, ["seriesCount"]))

        series_details = ET.SubElement(series_page, "seriesDetails")
        for record in series_report_rows:
            series_reports = ET.SubElement(series_details, "seriesReports")
            _add_if_present(series_reports, "idOfSeries", record.get("idOfSeries"))
            _add_if_present(series_reports, "nameOfSeries", record.get("nameOfSeries"))
            _add_if_present(series_reports, "leiOfSeries", record.get("leiOfSeries"))

    signature_page = ET.SubElement(form_data, "signaturePage")
    _add_if_present(signature_page, "reportingPerson", _first_across_rows(core_rows, ["signatureReportingPerson"]))
    _add_if_present(signature_page, "txSignature", _first_across_rows(core_rows, ["txSignature"]))
    _add_if_present(signature_page, "txPrintedSignature", _first_across_rows(core_rows, ["txPrintedSignature"]))
    _add_if_present(signature_page, "txTitle", _first_across_rows(core_rows, ["txTitle"]))
    _add_if_present(signature_page, "txAsOfDate", _first_across_rows(core_rows, ["txAsOfDate"]))

    if secondary_signature_rows:
        secondary_records = ET.SubElement(signature_page, "secondaryRecords")
        for record in secondary_signature_rows:
            secondary_record = ET.SubElement(secondary_records, "secondaryRecord")
            _add_if_present(secondary_record, "printedSign", record.get("printedSign"))
            _add_if_present(secondary_record, "txSignature", record.get("txSignature"))
            _add_if_present(secondary_record, "txTitle", record.get("txTitle"))
            _add_if_present(secondary_record, "txAsOfDate", record.get("txAsOfDate"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
