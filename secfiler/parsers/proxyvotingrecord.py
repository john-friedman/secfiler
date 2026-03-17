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


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _is_present(value):
        ET.SubElement(parent, tag).text = _to_text(value)


def _add_if_defined(parent: ET.Element, tag: str, value) -> None:
    if value is not None:
        ET.SubElement(parent, tag).text = _to_text(value)


def _collect_records(
    rows: list[dict],
    field_aliases: dict[str, list[str]],
    marker_keys: list[str],
) -> list[dict]:
    records: list[dict] = []

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

            if any(_is_present(value) for value in record.values()):
                records.append(record)

    return records


def _record_signature(record: dict, keys: list[str]) -> tuple:
    return tuple((key, "" if record.get(key) is None else _to_text(record.get(key))) for key in keys)


def construct_proxy_voting_record(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    record_rows = _collect_records(
        normalized_rows,
        {
            "issuerName": ["issuerName"],
            "isin": ["isin"],
            "cusip": ["cusip"],
            "figi": ["figi"],
            "meetingDate": ["meetingDate"],
            "sharesVoted": ["sharesVoted"],
            "sharesOnLoan": ["sharesOnLoan"],
            "voteDescription": ["voteDescription"],
            "voteOtherInfo": ["voteOtherInfo"],
            "otherVoteDescription": ["otherVoteDescription"],
            "voteSource": ["voteSource"],
            "voteSeries": ["voteSeries"],
            "voteManagerOtherManager": ["voteManagerOtherManager"],
            "categoryType": ["categoryType"],
            "howVoted": ["howVoted"],
            "managementRecommendation": ["managementRecommendation"],
            "voteRecordSharesVoted": ["voteRecordSharesVoted"],
        },
        marker_keys=["issuerName", "meetingDate", "voteDescription", "howVoted"],
    )

    grouped_tables = []
    grouped_index = {}
    for record in record_rows:
        table_sig = _record_signature(
            record,
            [
                "issuerName",
                "isin",
                "cusip",
                "figi",
                "meetingDate",
                "sharesVoted",
                "sharesOnLoan",
                "voteDescription",
                "voteOtherInfo",
                "otherVoteDescription",
                "voteSource",
                "voteSeries",
            ],
        )
        if table_sig not in grouped_index:
            grouped_index[table_sig] = len(grouped_tables)
            grouped_tables.append(
                {
                    "table": {
                        "issuerName": record.get("issuerName"),
                        "isin": record.get("isin"),
                        "cusip": record.get("cusip"),
                        "figi": record.get("figi"),
                        "meetingDate": record.get("meetingDate"),
                        "sharesVoted": record.get("sharesVoted"),
                        "sharesOnLoan": record.get("sharesOnLoan"),
                        "voteDescription": record.get("voteDescription"),
                        "voteOtherInfo": record.get("voteOtherInfo"),
                        "otherVoteDescription": record.get("otherVoteDescription"),
                        "voteSource": record.get("voteSource"),
                        "voteSeries": record.get("voteSeries"),
                    },
                    "categories": [],
                    "otherManagers": [],
                    "voteRecords": [],
                }
            )

        grouped = grouped_tables[grouped_index[table_sig]]

        category_type = record.get("categoryType")
        if _is_present(category_type) and category_type not in grouped["categories"]:
            grouped["categories"].append(category_type)

        other_manager = record.get("voteManagerOtherManager")
        if _is_present(other_manager) and other_manager not in grouped["otherManagers"]:
            grouped["otherManagers"].append(other_manager)

        vote_record = {
            "howVoted": record.get("howVoted"),
            "managementRecommendation": record.get("managementRecommendation"),
            "voteRecordSharesVoted": record.get("voteRecordSharesVoted"),
        }
        if any(_is_present(vote_record[k]) for k in vote_record):
            vote_sig = _record_signature(vote_record, ["howVoted", "managementRecommendation", "voteRecordSharesVoted"])
            existing_sigs = {
                _record_signature(item, ["howVoted", "managementRecommendation", "voteRecordSharesVoted"])
                for item in grouped["voteRecords"]
            }
            if vote_sig not in existing_sigs:
                grouped["voteRecords"].append(vote_record)

    root = ET.Element("proxyVoteTable")
    root.set("xmlns", "http://www.sec.gov/edgar/document/npxproxy/informationtable")

    for grouped in grouped_tables:
        table = grouped["table"]
        proxy_table = ET.SubElement(root, "proxyTable")
        _add_if_defined(proxy_table, "issuerName", table.get("issuerName"))
        _add_if_defined(proxy_table, "isin", table.get("isin"))
        _add_if_defined(proxy_table, "cusip", table.get("cusip"))
        _add_if_defined(proxy_table, "figi", table.get("figi"))
        _add_if_defined(proxy_table, "meetingDate", table.get("meetingDate"))
        _add_if_defined(proxy_table, "voteDescription", table.get("voteDescription"))

        if grouped["categories"]:
            vote_categories = ET.SubElement(proxy_table, "voteCategories")
            for category in grouped["categories"]:
                vote_category = ET.SubElement(vote_categories, "voteCategory")
                _add_if_defined(vote_category, "categoryType", category)

        _add_if_defined(proxy_table, "voteSource", table.get("voteSource"))
        _add_if_defined(proxy_table, "sharesVoted", table.get("sharesVoted"))
        _add_if_defined(proxy_table, "sharesOnLoan", table.get("sharesOnLoan"))

        if grouped["otherManagers"]:
            vote_manager = ET.SubElement(proxy_table, "voteManager")
            other_managers = ET.SubElement(vote_manager, "otherManagers")
            for manager in grouped["otherManagers"]:
                _add_if_defined(other_managers, "otherManager", manager)

        _add_if_defined(proxy_table, "voteSeries", table.get("voteSeries"))
        _add_if_defined(proxy_table, "voteOtherInfo", table.get("voteOtherInfo"))
        _add_if_defined(proxy_table, "otherVoteDescription", table.get("otherVoteDescription"))

        if grouped["voteRecords"]:
            vote = ET.SubElement(proxy_table, "vote")
            for record in grouped["voteRecords"]:
                vote_record = ET.SubElement(vote, "voteRecord")
                _add_if_defined(vote_record, "howVoted", record.get("howVoted"))
                _add_if_defined(vote_record, "sharesVoted", record.get("voteRecordSharesVoted"))
                _add_if_defined(vote_record, "managementRecommendation", record.get("managementRecommendation"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
