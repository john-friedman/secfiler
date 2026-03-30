import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text


def construct_25nse(rows: list) -> bytes:
    header_row = next((r for r in rows if r.get("_table") == "25nse"), rows[0] if rows else {})

    root = ET.Element("notificationOfRemoval")

    _add_path_text(root, ["schemaVersion"], header_row.get("schemaVersion", "X0203"))
    _add_path_text(root, ["exchange", "cik"], header_row.get("exchangeCik"))
    _add_path_text(root, ["exchange", "entityName"], header_row.get("exchangeEntityName"))
    _add_path_text(root, ["issuer", "cik"], header_row.get("issuerCik"))
    _add_path_text(root, ["issuer", "entityName"], header_row.get("issuerEntityName"))
    _add_path_text(root, ["issuer", "fileNumber"], header_row.get("issuerFileNumber"))
    _add_path_text(root, ["issuer", "address", "street1"], header_row.get("street1"))
    _add_path_text(root, ["issuer", "address", "street2"], header_row.get("street2"))
    _add_path_text(root, ["issuer", "address", "city"], header_row.get("city"))
    _add_path_text(root, ["issuer", "address", "stateOrCountryCode"], header_row.get("stateOrCountryCode"))
    _add_path_text(root, ["issuer", "address", "stateOrCountry"], header_row.get("stateOrCountry"))
    _add_path_text(root, ["issuer", "address", "zipCode"], header_row.get("zipCode"))
    _add_path_text(root, ["issuer", "telephoneNumber"], header_row.get("issuerTelephoneNumber"))
    _add_path_text(root, ["descriptionClassSecurity"], header_row.get("descriptionClassSecurity"))
    _add_path_text(root, ["ruleProvision"], header_row.get("ruleProvision"))
    _add_path_text(root, ["signatureData", "signatureName"], header_row.get("signatureName"))
    _add_path_text(root, ["signatureData", "signatureTitle"], header_row.get("signatureTitle"))
    _add_path_text(root, ["signatureData", "signatureDate"], header_row.get("signatureDate"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
