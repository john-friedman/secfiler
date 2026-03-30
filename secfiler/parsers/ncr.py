import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text


def construct_ncr(rows: list) -> bytes:
    header_row = next((r for r in rows if r.get("_table") == "ncr"), rows[0] if rows else {})

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/ncrfiler")

    _add_path_text(root, ["schemaVersion"], header_row.get("schemaVersion") or "X0101")
    _add_path_text(root, ["headerData", "submissionType"], header_row.get("submissionType") or "N-CR")
    _add_path_text(root, ["headerData", "filerInfo", "liveTestFlag"], header_row.get("liveTestFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "issuerCredentials", "cik"], header_row.get("filerCik"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "issuerCredentials", "ccc"], header_row.get("filerCcc"))
    _add_path_text(root, ["headerData", "filerInfo", "periodOfReport"], header_row.get("periodOfReport"))

    _add_path_text(root, ["formData", "generalInfo", "reportDate"], header_row.get("reportDate"))
    _add_path_text(root, ["formData", "generalInfo", "registrantName"], header_row.get("registrantName"))
    _add_path_text(root, ["formData", "generalInfo", "registrantCik"], header_row.get("registrantCik"))
    _add_path_text(root, ["formData", "generalInfo", "registrantLei"], header_row.get("registrantLei"))
    _add_path_text(root, ["formData", "generalInfo", "seriesName"], header_row.get("seriesName"))
    _add_path_text(root, ["formData", "generalInfo", "seriesId"], header_row.get("seriesId"))
    _add_path_text(root, ["formData", "generalInfo", "seriesLei"], header_row.get("seriesLei"))
    _add_path_text(root, ["formData", "generalInfo", "fileNumber"], header_row.get("fileNumber"))

    _add_path_text(root, ["formData", "liquidityThresholdEvent", "dateOfDailyAssets"], header_row.get("dateOfDailyAssets"))
    _add_path_text(root, ["formData", "liquidityThresholdEvent", "percentageOfWeeklyAssets"], header_row.get("percentageOfWeeklyAssets"))
    _add_path_text(root, ["formData", "liquidityThresholdEvent", "percentageOfDailyAssets"], header_row.get("percentageOfDailyAssets"))
    _add_path_text(root, ["formData", "liquidityThresholdEvent", "factsDescription"], header_row.get("factsDescription"))

    _add_path_text(root, ["formData", "disclosure", "supportDescription"], header_row.get("supportDescription"))
    _add_path_text(root, ["formData", "disclosure", "supportPersonName"], header_row.get("supportPersonName"))
    _add_path_text(root, ["formData", "disclosure", "relationshipDescription"], header_row.get("relationshipDescription"))
    _add_path_text(root, ["formData", "disclosure", "supportDate"], header_row.get("supportDate"))
    _add_path_text(root, ["formData", "disclosure", "supportAmtDescription"], header_row.get("supportAmtDescription"))
    _add_path_text(root, ["formData", "disclosure", "reasonDescription"], header_row.get("reasonDescription"))
    _add_path_text(root, ["formData", "disclosure", "termOfSupport"], header_row.get("termOfSupport"))
    _add_path_text(root, ["formData", "disclosure", "contractRestrictionsDesc"], header_row.get("contractRestrictionsDesc"))

    _add_path_text(root, ["formData", "optionalDisclosure", "optionalDisclosure"], header_row.get("optionalDisclosure"))

    _add_path_text(root, ["formData", "signatureBlock", "name"], header_row.get("signatureName"))
    _add_path_text(root, ["formData", "signatureBlock", "title"], header_row.get("signatureTitle"))
    _add_path_text(root, ["formData", "signatureBlock", "signature"], header_row.get("signature"))
    _add_path_text(root, ["formData", "signatureBlock", "signatureDate"], header_row.get("signatureDate"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
