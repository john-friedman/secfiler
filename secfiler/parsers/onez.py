import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text


def construct_1z(rows: list) -> bytes:
    header_row = next((r for r in rows if r.get("_table") == "onez"), rows[0] if rows else {})

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/rega/onezfiler")
    root.set("xmlns:ns1", "http://www.sec.gov/edgar/common")

    _add_path_text(root, ["headerData", "submissionType"], header_row.get("submissionType"))
    _add_path_text(root, ["headerData", "filerInfo", "liveTestFlag"], header_row.get("liveTestFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "issuerCredentials", "cik"], header_row.get("filerCik"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "issuerCredentials", "ccc"], header_row.get("filerCcc"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "fileNumber"], header_row.get("fileNumber"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "confirmingCopyFlag"], header_row.get("confirmingCopyFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "successorFilingFlag"], header_row.get("successorFilingFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "returnCopyFlag"], header_row.get("returnCopyFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "overrideInternetFlag"], header_row.get("overrideInternetFlag"))

    _add_path_text(root, ["formData", "item1", "issuerName"], header_row.get("issuerName"))
    _add_path_text(root, ["formData", "item1", "street1"], header_row.get("street1"))
    _add_path_text(root, ["formData", "item1", "street2"], header_row.get("street2"))
    _add_path_text(root, ["formData", "item1", "city"], header_row.get("city"))
    _add_path_text(root, ["formData", "item1", "stateOrCountry"], header_row.get("stateOrCountry"))
    _add_path_text(root, ["formData", "item1", "zipCode"], header_row.get("zipCode"))
    _add_path_text(root, ["formData", "item1", "phone"], header_row.get("phone"))
    _add_path_text(root, ["formData", "item1", "commissionFileNumber"], header_row.get("commissionFileNumber"))

    for field in [
        "offeringQualificationDate",
        "offeringCommenceDate",
        "offeringSecuritiesQualifiedSold",
        "offeringSecuritiesSold",
        "pricePerSecurity",
        "portionSecuritiesSoldIssuer",
        "portionSecuritiesSoldSecurityholders",
        "underwrittenSpName",
        "underwriterFees",
        "salesCommissionsSpName",
        "salesCommissionsFee",
        "findersSpName",
        "findersFees",
        "auditorSpName",
        "auditorFees",
        "legalSpName",
        "legalFees",
        "promoterSpName",
        "promotersFees",
        "blueSkySpName",
        "blueSkyFees",
        "crdNumberBrokerDealer",
        "issuerNetProceeds",
        "clarificationResponses",
    ]:
        _add_path_text(root, ["formData", "summaryInfoOffering", field], header_row.get(field))

    _add_path_text(root, ["formData", "certificationSuspension", "securitiesClassTitle"], header_row.get("securitiesClassTitle"))
    _add_path_text(root, ["formData", "certificationSuspension", "certificationFileNumber"], header_row.get("certificationFileNumber"))
    _add_path_text(root, ["formData", "certificationSuspension", "approxRecordHolders"], header_row.get("approxRecordHolders"))

    _add_path_text(root, ["formData", "signatureTab", "cik"], header_row.get("signatureCik"))
    _add_path_text(root, ["formData", "signatureTab", "regulationIssuerName1"], header_row.get("regulationIssuerName1"))
    _add_path_text(root, ["formData", "signatureTab", "regulationIssuerName2"], header_row.get("regulationIssuerName2"))
    _add_path_text(root, ["formData", "signatureTab", "signatureBy"], header_row.get("signatureBy"))
    _add_path_text(root, ["formData", "signatureTab", "date"], header_row.get("signatureDate"))
    _add_path_text(root, ["formData", "signatureTab", "title"], header_row.get("signatureTitle"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")
