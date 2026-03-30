import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text


def construct_1k(rows: list) -> bytes:
    header_row = next((r for r in rows if r.get("_table") == "onek"), rows[0] if rows else {})

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/rega/onekfiler")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    _add_path_text(root, ["headerData", "submissionType"], header_row.get("submissionType"))
    _add_path_text(root, ["headerData", "filerInfo", "liveTestFlag"], header_row.get("liveTestFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "issuerCredentials", "cik"], header_row.get("filerCik"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "issuerCredentials", "ccc"], header_row.get("filerCcc"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "fileNumber"], header_row.get("fileNumber"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "shellCompanyFlag"], header_row.get("shellCompanyFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "confirmingCopyFlag"], header_row.get("confirmingCopyFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "successorFilingFlag"], header_row.get("successorFilingFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "returnCopyFlag"], header_row.get("returnCopyFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "overrideInternetFlag"], header_row.get("overrideInternetFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "reportingPeriod"], header_row.get("reportingPeriod"))

    _add_path_text(root, ["formData", "item1", "formIndication"], header_row.get("formIndication"))
    _add_path_text(root, ["formData", "item1", "fiscalYearEnd"], header_row.get("fiscalYearEnd"))
    _add_path_text(root, ["formData", "item1", "street1"], header_row.get("street1"))
    _add_path_text(root, ["formData", "item1", "street2"], header_row.get("street2"))
    _add_path_text(root, ["formData", "item1", "city"], header_row.get("city"))
    _add_path_text(root, ["formData", "item1", "stateOrCountry"], header_row.get("stateOrCountry"))
    _add_path_text(root, ["formData", "item1", "zipCode"], header_row.get("zipCode"))
    _add_path_text(root, ["formData", "item1", "phoneNumber"], header_row.get("phoneNumber"))

    for row in rows:
        _add_path_text(root, ["formData", "item1", "issuedSecuritiesTitle"], row.get("issuedSecuritiesTitle"))

    _add_path_text(root, ["formData", "item1Info", "issuerName"], header_row.get("issuerName"))
    _add_path_text(root, ["formData", "item1Info", "cik"], header_row.get("issuerCik"))
    _add_path_text(root, ["formData", "item1Info", "jurisdictionOrganization"], header_row.get("jurisdictionOrganization"))
    _add_path_text(root, ["formData", "item1Info", "irsNum"], header_row.get("irsNum"))

    _add_path_text(root, ["formData", "item2", "regArule257"], header_row.get("regArule257"))

    for tag, key in [
        ("commissionFileNumber", "commissionFileNumber"),
        ("offeringQualificationDate", "offeringQualificationDate"),
        ("offeringCommenceDate", "offeringCommenceDate"),
        ("qualifiedSecuritiesSold", "qualifiedSecuritiesSold"),
        ("offeringSecuritiesSold", "offeringSecuritiesSold"),
        ("pricePerSecurity", "pricePerSecurity"),
        ("aggregrateOfferingPrice", "aggregrateOfferingPrice"),
        ("aggregrateOfferingPriceHolders", "aggregrateOfferingPriceHolders"),
        ("underwrittenSpName", "underwrittenSpName"),
        ("underwriterFees", "underwriterFees"),
        ("crdNumberBrokerDealer", "crdNumberBrokerDealer"),
        ("issuerNetProceeds", "issuerNetProceeds"),
        ("clarificationResponses", "clarificationResponses"),
        ("auditorSpName", "auditorSpName"),
        ("auditorFees", "auditorFees"),
        ("legalSpName", "legalSpName"),
        ("legalFees", "legalFees"),
        ("salesCommissionsSpName", "salesCommissionsSpName"),
        ("salesCommissionsFee", "salesCommissionsFee"),
        ("findersSpName", "findersSpName"),
        ("findersFees", "findersFees"),
        ("promoterSpName", "promoterSpName"),
        ("promotersFees", "promotersFees"),
        ("blueSkySpName", "blueSkySpName"),
        ("blueSkyFees", "blueSkyFees"),
    ]:
        _add_path_text(root, ["formData", "summaryInfo", tag], header_row.get(key))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
