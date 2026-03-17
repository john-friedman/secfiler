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


def _to_text(value) -> str:
    if isinstance(value, bool):
        return "true" if value else "false"
    return str(value)


def _first_across_rows(rows: list[dict], keys: list[str]):
    for row in rows:
        for key in keys:
            value = row.get(key)
            if _is_present(value):
                return value
    return None


def _value_or_default(value, default):
    return default if value is None else value


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _is_present(value):
        ET.SubElement(parent, tag).text = _to_text(value)


def _add_if_defined(parent: ET.Element, tag: str, row: dict, key: str) -> None:
    if key in row and row.get(key) is not None:
        ET.SubElement(parent, tag).text = _to_text(row.get(key))


def construct_x17a5(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    first_row = normalized_rows[0]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/seventeenafiler")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")

    header_data = ET.SubElement(root, "headerData")
    _add_if_present(header_data, "submissionType", _first_across_rows(normalized_rows, ["submissionType"]))

    filer_info = ET.SubElement(header_data, "filerInfo")
    filer = ET.SubElement(filer_info, "filer")
    filer_credentials = ET.SubElement(filer, "filerCredentials")
    _add_if_present(filer_credentials, "filerCik", _first_across_rows(normalized_rows, ["filerCik"]))
    _add_if_present(filer_credentials, "filerCcc", _first_across_rows(normalized_rows, ["filerCcc"]))

    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    flags = ET.SubElement(filer_info, "flags")
    ET.SubElement(
        flags,
        "returnCopyFlag",
    ).text = _to_text(_value_or_default(_first_across_rows(normalized_rows, ["returnCopyFlag"]), "false"))
    ET.SubElement(
        flags,
        "confirmingCopyFlag",
    ).text = _to_text(_value_or_default(_first_across_rows(normalized_rows, ["confirmingCopyFlag"]), "false"))
    ET.SubElement(
        flags,
        "overrideInternetFlag",
    ).text = _to_text(_value_or_default(_first_across_rows(normalized_rows, ["overrideInternetFlag"]), "false"))

    form_data = ET.SubElement(root, "formData")

    submission_information = ET.SubElement(form_data, "submissionInformation")
    _add_if_present(submission_information, "periodBegin", _first_across_rows(normalized_rows, ["periodBegin"]))
    _add_if_present(submission_information, "periodEnd", _first_across_rows(normalized_rows, ["periodEnd"]))

    type_of_bd = _first_across_rows(normalized_rows, ["typeOfBDRegistrant"])
    type_of_sd = _first_across_rows(normalized_rows, ["typeOfSDRegistrant"])
    sub_type_of_registrant = _first_across_rows(normalized_rows, ["subTypeOfRegistrant"])
    if _is_present(type_of_bd) or _is_present(type_of_sd) or _is_present(sub_type_of_registrant):
        type_of_registrant = ET.SubElement(submission_information, "typeOfRegistrant")
        if _is_present(sub_type_of_registrant) and not (_is_present(type_of_bd) or _is_present(type_of_sd)):
            type_of_registrant.text = _to_text(sub_type_of_registrant)
        _add_if_present(type_of_registrant, "typeOfBDRegistrant", type_of_bd)
        _add_if_present(type_of_registrant, "typeOfSDRegistrant", type_of_sd)

    _add_if_present(
        submission_information,
        "subTypeOfBDRegistrant",
        _first_across_rows(normalized_rows, ["subTypeOfBDRegistrant"]),
    )
    _add_if_present(
        submission_information,
        "subTypeOfSDRegistrant",
        _first_across_rows(normalized_rows, ["subTypeOfSDRegistrant"]),
    )
    _add_if_present(
        submission_information,
        "materialWeakness",
        _first_across_rows(normalized_rows, ["materialWeakness"]),
    )
    _add_if_present(
        submission_information,
        "amendmentDescription",
        _first_across_rows(normalized_rows, ["amendmentDescription"]),
    )

    registrant_identification = ET.SubElement(form_data, "registrantIdentification")
    _add_if_present(
        registrant_identification,
        "brokerDealerName",
        _first_across_rows(normalized_rows, ["brokerDealerName"]),
    )

    business_address_keys = ("street1", "street2", "city", "stateOrCountry", "zipCode")
    has_business_address = any(key in first_row for key in business_address_keys) or any(
        _is_present(_first_across_rows(normalized_rows, [key])) for key in business_address_keys
    )
    if has_business_address:
        business_address = ET.SubElement(registrant_identification, "businessAddress")
        _add_if_present(business_address, "com:street1", _first_across_rows(normalized_rows, ["street1"]))
        _add_if_defined(business_address, "com:street2", first_row, "street2")
        _add_if_present(business_address, "com:city", _first_across_rows(normalized_rows, ["city"]))
        _add_if_present(
            business_address,
            "com:stateOrCountry",
            _first_across_rows(normalized_rows, ["stateOrCountry"]),
        )
        _add_if_present(business_address, "com:zipCode", _first_across_rows(normalized_rows, ["zipCode"]))

    _add_if_present(
        registrant_identification,
        "contactPersonName",
        _first_across_rows(normalized_rows, ["contactPersonName"]),
    )
    _add_if_present(
        registrant_identification,
        "contactPersonPhoneNumber",
        _first_across_rows(normalized_rows, ["contactPersonPhoneNumber"]),
    )

    accountant_identification = ET.SubElement(form_data, "accountantIdentification")
    _add_if_present(
        accountant_identification,
        "accountantName",
        _first_across_rows(normalized_rows, ["accountantName"]),
    )

    accountant_address_keys = (
        "accountantStreet1",
        "accountantStreet2",
        "accountantCity",
        "accountantStateOrCountry",
        "accountantZipCode",
    )
    has_accountant_address = any(key in first_row for key in accountant_address_keys) or any(
        _is_present(_first_across_rows(normalized_rows, [key])) for key in accountant_address_keys
    )
    if has_accountant_address:
        accountant_address = ET.SubElement(accountant_identification, "accountantAddress")
        _add_if_present(
            accountant_address,
            "com:street1",
            _first_across_rows(normalized_rows, ["accountantStreet1"]),
        )
        _add_if_defined(accountant_address, "com:street2", first_row, "accountantStreet2")
        _add_if_present(
            accountant_address,
            "com:city",
            _first_across_rows(normalized_rows, ["accountantCity"]),
        )
        _add_if_present(
            accountant_address,
            "com:stateOrCountry",
            _first_across_rows(normalized_rows, ["accountantStateOrCountry"]),
        )
        _add_if_present(
            accountant_address,
            "com:zipCode",
            _first_across_rows(normalized_rows, ["accountantZipCode"]),
        )

    _add_if_present(
        accountant_identification,
        "accountantType",
        _first_across_rows(normalized_rows, ["accountantType"]),
    )

    oath_signature = ET.SubElement(form_data, "oathSignature")
    _add_if_present(oath_signature, "signPersonName", _first_across_rows(normalized_rows, ["signPersonName"]))
    _add_if_present(oath_signature, "entityName", _first_across_rows(normalized_rows, ["oathEntityName"]))
    _add_if_present(oath_signature, "signDate", _first_across_rows(normalized_rows, ["signDate"]))
    _add_if_present(oath_signature, "explanation", _first_across_rows(normalized_rows, ["explanation"]))
    _add_if_present(oath_signature, "signature", _first_across_rows(normalized_rows, ["signature"]))
    _add_if_present(oath_signature, "oathTitle", _first_across_rows(normalized_rows, ["oathTitle"]))
    _add_if_present(
        oath_signature,
        "confirmNotarizedFlag",
        _first_across_rows(normalized_rows, ["confirmNotarizedFlag"]),
    )
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
