import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text


def construct_x17a5(rows: list) -> bytes:
    header_row = next((r for r in rows if r.get("_table") == "x17a5"), rows[0] if rows else {})

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/seventeenafiler")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    _add_path_text(root, ["headerData", "submissionType"], header_row.get("submissionType"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "filerCredentials", "filerCik"], header_row.get("filerCik"))
    _add_path_text(root, ["headerData", "filerInfo", "filer", "filerCredentials", "filerCcc"], header_row.get("filerCcc"))
    _add_path_text(root, ["headerData", "filerInfo", "liveTestFlag"], header_row.get("liveTestFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "returnCopyFlag"], header_row.get("returnCopyFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "confirmingCopyFlag"], header_row.get("confirmingCopyFlag"))
    _add_path_text(root, ["headerData", "filerInfo", "flags", "overrideInternetFlag"], header_row.get("overrideInternetFlag"))

    _add_path_text(root, ["formData", "submissionInformation", "periodBegin"], header_row.get("periodBegin"))
    _add_path_text(root, ["formData", "submissionInformation", "periodEnd"], header_row.get("periodEnd"))
    _add_path_text(root, ["formData", "submissionInformation", "typeOfRegistrant"], header_row.get("subTypeOfRegistrant"))
    _add_path_text(root, ["formData", "submissionInformation", "typeOfRegistrant", "typeOfBDRegistrant"], header_row.get("typeOfBDRegistrant"))
    _add_path_text(root, ["formData", "submissionInformation", "typeOfRegistrant", "typeOfSDRegistrant"], header_row.get("typeOfSDRegistrant"))
    _add_path_text(root, ["formData", "submissionInformation", "subTypeOfBDRegistrant"], header_row.get("subTypeOfBDRegistrant"))
    _add_path_text(root, ["formData", "submissionInformation", "subTypeOfSDRegistrant"], header_row.get("subTypeOfSDRegistrant"))
    _add_path_text(root, ["formData", "submissionInformation", "materialWeakness"], header_row.get("materialWeakness"))
    _add_path_text(root, ["formData", "submissionInformation", "amendmentDescription"], header_row.get("amendmentDescription"))

    _add_path_text(root, ["formData", "registrantIdentification", "brokerDealerName"], header_row.get("brokerDealerName"))
    _add_path_text(root, ["formData", "registrantIdentification", "businessAddress", "com:street1"], header_row.get("street1"))
    _add_path_text(root, ["formData", "registrantIdentification", "businessAddress", "com:street2"], header_row.get("street2"))
    _add_path_text(root, ["formData", "registrantIdentification", "businessAddress", "com:city"], header_row.get("city"))
    _add_path_text(root, ["formData", "registrantIdentification", "businessAddress", "com:stateOrCountry"], header_row.get("stateOrCountry"))
    _add_path_text(root, ["formData", "registrantIdentification", "businessAddress", "com:zipCode"], header_row.get("zipCode"))
    _add_path_text(root, ["formData", "registrantIdentification", "contactPersonName"], header_row.get("contactPersonName"))
    _add_path_text(root, ["formData", "registrantIdentification", "contactPersonPhoneNumber"], header_row.get("contactPersonPhoneNumber"))

    _add_path_text(root, ["formData", "accountantIdentification", "accountantName"], header_row.get("accountantName"))
    _add_path_text(root, ["formData", "accountantIdentification", "accountantAddress", "com:street1"], header_row.get("accountantStreet1"))
    _add_path_text(root, ["formData", "accountantIdentification", "accountantAddress", "com:street2"], header_row.get("accountantStreet2"))
    _add_path_text(root, ["formData", "accountantIdentification", "accountantAddress", "com:city"], header_row.get("accountantCity"))
    _add_path_text(root, ["formData", "accountantIdentification", "accountantAddress", "com:stateOrCountry"], header_row.get("accountantStateOrCountry"))
    _add_path_text(root, ["formData", "accountantIdentification", "accountantAddress", "com:zipCode"], header_row.get("accountantZipCode"))
    _add_path_text(root, ["formData", "accountantIdentification", "accountantType"], header_row.get("accountantType"))

    _add_path_text(root, ["formData", "oathSignature", "signPersonName"], header_row.get("signPersonName"))
    _add_path_text(root, ["formData", "oathSignature", "entityName"], header_row.get("oathEntityName"))
    _add_path_text(root, ["formData", "oathSignature", "signDate"], header_row.get("signDate"))
    _add_path_text(root, ["formData", "oathSignature", "explanation"], header_row.get("explanation"))
    _add_path_text(root, ["formData", "oathSignature", "signature"], header_row.get("signature"))
    _add_path_text(root, ["formData", "oathSignature", "oathTitle"], header_row.get("oathTitle"))
    _add_path_text(root, ["formData", "oathSignature", "confirmNotarizedFlag"], header_row.get("confirmNotarizedFlag"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
