import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text


def construct_effect(rows: list) -> bytes:
    header_row = next((r for r in rows if r.get("_table") == "effect"), rows[0] if rows else {})

    root = ET.Element("edgarSubmission")

    _add_path_text(root, ["schemaVersion"], header_row.get("schemaVersion", "X0101"))
    _add_path_text(root, ["submissionType"], header_row.get("submissionType"))
    _add_path_text(root, ["act"], header_row.get("act"))
    _add_path_text(root, ["testOrLive"], header_row.get("testOrLive"))

    _add_path_text(
        root,
        ["effectiveData", "finalEffectivenessDispDate"],
        header_row.get("finalEffectivenessDispDate"),
    )
    _add_path_text(
        root,
        ["effectiveData", "finalEffectivenessDispTime"],
        header_row.get("finalEffectivenessDispTime"),
    )
    _add_path_text(root, ["effectiveData", "form"], header_row.get("form"))

    _add_path_text(root, ["effectiveData", "filer", "cik"], header_row.get("cik"))
    _add_path_text(root, ["effectiveData", "filer", "entityName"], header_row.get("entityName"))
    _add_path_text(root, ["effectiveData", "filer", "fileNumber"], header_row.get("fileNumber"))

    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "existing", "classContractId"],
        header_row.get("targetClassContractId"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "existing", "classContractName"],
        header_row.get("targetClassContractName"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "existing", "seriesId"],
        header_row.get("targetSeriesId"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "existing", "seriesName"],
        header_row.get("targetSeriesName"),
    )

    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "merger", "acquiringCik"],
        header_row.get("acquiringCik"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "merger", "acquiringClassContractId"],
        header_row.get("acquiringClassContractId"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "merger", "acquiringClassContractName"],
        header_row.get("acquiringClassContractName"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "merger", "acquiringEntityName"],
        header_row.get("acquiringEntityName"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "merger", "acquiringSeriesId"],
        header_row.get("acquiringSeriesId"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "merger", "acquiringSeriesName"],
        header_row.get("acquiringSeriesName"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "merger", "targetCik"],
        header_row.get("targetCik"),
    )
    _add_path_text(
        root,
        ["effectiveData", "filer", "seriesClassContractData", "merger", "targetEntityName"],
        header_row.get("targetEntityName"),
    )

    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
