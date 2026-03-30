import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment



def _has_value(value) -> bool:
    if value is None:
        return False
    if isinstance(value, str):
        return bool(value.strip())
    return True


def _add_if_defined(parent: ET.Element, tag: str, row: dict, key: str) -> None:
    if key in row and row.get(key) is not None:
        ET.SubElement(parent, tag).text = str(row.get(key))


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _has_value(value):
        ET.SubElement(parent, tag).text = str(value)


def construct_25nse(rows: list) -> bytes:
    row = rows[0] if rows else {}

    root = ET.Element("notificationOfRemoval")

    schema_version = row.get("schemaVersion", "X0203")
    _add_if_present(root, "schemaVersion", schema_version)

    exchange = ET.SubElement(root, "exchange")
    _add_if_present(exchange, "cik", row.get("exchangeCik"))
    _add_if_present(exchange, "entityName", row.get("exchangeEntityName"))

    issuer = ET.SubElement(root, "issuer")
    _add_if_present(issuer, "cik", row.get("issuerCik"))
    _add_if_present(issuer, "entityName", row.get("issuerEntityName"))
    _add_if_present(issuer, "fileNumber", row.get("issuerFileNumber"))

    address_keys = (
        "street1",
        "street2",
        "city",
        "stateOrCountryCode",
        "stateOrCountry",
        "zipCode",
    )
    if any(key in row for key in address_keys):
        address = ET.SubElement(issuer, "address")
        _add_if_defined(address, "street1", row, "street1")
        _add_if_defined(address, "street2", row, "street2")
        _add_if_defined(address, "city", row, "city")
        _add_if_defined(address, "stateOrCountryCode", row, "stateOrCountryCode")
        _add_if_defined(address, "stateOrCountry", row, "stateOrCountry")
        _add_if_defined(address, "zipCode", row, "zipCode")

    _add_if_defined(issuer, "telephoneNumber", row, "issuerTelephoneNumber")

    _add_if_present(root, "descriptionClassSecurity", row.get("descriptionClassSecurity"))
    _add_if_present(root, "ruleProvision", row.get("ruleProvision"))

    signature_data = ET.SubElement(root, "signatureData")
    _add_if_present(signature_data, "signatureName", row.get("signatureName"))
    _add_if_present(signature_data, "signatureTitle", row.get("signatureTitle"))
    _add_if_present(signature_data, "signatureDate", row.get("signatureDate"))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
