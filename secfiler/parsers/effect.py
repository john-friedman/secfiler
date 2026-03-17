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
    return True


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _is_present(value):
        ET.SubElement(parent, tag).text = str(value)


def construct_effect(rows: list) -> bytes:
    row = rows[0] if rows else {}

    root = ET.Element("edgarSubmission")

    schema_version = row.get("schemaVersion", "X0101")
    _add_if_present(root, "schemaVersion", schema_version)
    _add_if_present(root, "submissionType", row.get("submissionType"))
    _add_if_present(root, "act", row.get("act"))
    _add_if_present(root, "testOrLive", row.get("testOrLive"))

    effective_data = ET.SubElement(root, "effectiveData")
    _add_if_present(
        effective_data,
        "finalEffectivenessDispDate",
        row.get("finalEffectivenessDispDate"),
    )
    _add_if_present(
        effective_data,
        "finalEffectivenessDispTime",
        row.get("finalEffectivenessDispTime"),
    )
    _add_if_present(effective_data, "form", row.get("form"))

    filer = ET.SubElement(effective_data, "filer")
    _add_if_present(filer, "cik", row.get("cik"))
    _add_if_present(filer, "entityName", row.get("entityName"))
    _add_if_present(filer, "fileNumber", row.get("fileNumber"))

    existing_fields = (
        "targetClassContractId",
        "targetClassContractName",
        "targetSeriesId",
        "targetSeriesName",
    )
    merger_fields = (
        "acquiringCik",
        "acquiringClassContractId",
        "acquiringClassContractName",
        "acquiringEntityName",
        "acquiringSeriesId",
        "acquiringSeriesName",
        "targetCik",
        "targetEntityName",
    )

    has_existing = any(_is_present(row.get(field)) for field in existing_fields)
    has_merger = any(_is_present(row.get(field)) for field in merger_fields)
    if has_existing or has_merger:
        series_class_contract_data = ET.SubElement(filer, "seriesClassContractData")

        if has_existing:
            existing = ET.SubElement(series_class_contract_data, "existing")
            _add_if_present(existing, "classContractId", row.get("targetClassContractId"))
            _add_if_present(existing, "classContractName", row.get("targetClassContractName"))
            _add_if_present(existing, "seriesId", row.get("targetSeriesId"))
            _add_if_present(existing, "seriesName", row.get("targetSeriesName"))

        if has_merger:
            merger = ET.SubElement(series_class_contract_data, "merger")
            _add_if_present(merger, "acquiringCik", row.get("acquiringCik"))
            _add_if_present(merger, "acquiringClassContractId", row.get("acquiringClassContractId"))
            _add_if_present(merger, "acquiringClassContractName", row.get("acquiringClassContractName"))
            _add_if_present(merger, "acquiringEntityName", row.get("acquiringEntityName"))
            _add_if_present(merger, "acquiringSeriesId", row.get("acquiringSeriesId"))
            _add_if_present(merger, "acquiringSeriesName", row.get("acquiringSeriesName"))
            _add_if_present(merger, "targetCik", row.get("targetCik"))
            _add_if_present(merger, "targetEntityName", row.get("targetEntityName"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
