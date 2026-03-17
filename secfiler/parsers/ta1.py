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
        out = []
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


def _first_across_rows(rows: list[dict], keys: list[str]):
    for row in rows:
        for key in keys:
            value = row.get(key)
            if _is_present(value):
                return value
    return None


def _ensure_path(parent: ET.Element, tags: list[str], create_leaf: bool = False) -> ET.Element:
    current = parent
    total = len(tags)
    for idx, tag in enumerate(tags):
        found = None
        if not (create_leaf and idx == total - 1):
            for child in current:
                if child.tag == tag:
                    found = child
                    break
        if found is None:
            found = ET.SubElement(current, tag)
        current = found
    return current


def _add_path_text(root: ET.Element, tags: list[str], value) -> None:
    if not _is_present(value):
        return
    target = _ensure_path(root, tags)
    if not _is_present(target.text):
        target.text = _to_text(value)


def _add_path_attr(root: ET.Element, tags: list[str], attr_name: str, value) -> None:
    if not _is_present(value):
        return
    target = _ensure_path(root, tags)
    if attr_name not in target.attrib:
        target.set(attr_name, _to_text(value))


def _collect_records(rows: list[dict], key_names: list[str]) -> list[dict]:
    records = []
    for row in rows:
        value_lists = {k: _normalize_values(row.get(k)) for k in key_names}
        max_items = max((len(v) for v in value_lists.values()), default=0)
        if max_items == 0:
            continue
        for i in range(max_items):
            record = {}
            for key, values in value_lists.items():
                if not values:
                    record[key] = None
                elif len(values) == 1:
                    record[key] = values[0]
                elif i < len(values):
                    record[key] = values[i]
                else:
                    record[key] = None
            if any(_is_present(v) for v in record.values()):
                records.append(record)
    return records

def construct_ta1(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element('edgarSubmission')
    root.set('xmlns', 'http://www.sec.gov/edgar/ta/taonefiler')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')
    _add_path_text(root, ['formVersion'], _first_across_rows(normalized_rows, ['formVersion']))
    _add_path_text(root, ['regulatoryAgency'], _first_across_rows(normalized_rows, ['regulatoryAgency']))
    _add_path_text(root, ['schemaVersion'], _first_across_rows(normalized_rows, ['schemaVersion']))
    _add_path_text(root, ['submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['testOrLive'], _first_across_rows(normalized_rows, ['testOrLive']))
    _add_path_text(root, ['authorizationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['involved']))
    _add_path_text(root, ['enjoinedInvestmentRelatedActivity', 'involved'], _first_across_rows(normalized_rows, ['enjoinedInvestmentRelatedActivityInvolved']))
    _add_path_text(root, ['falseStatementOrOmission', 'involved'], _first_across_rows(normalized_rows, ['falseStatementOrOmissionInvolved']))
    _add_path_text(root, ['felonyOrMisdemeanor', 'involved'], _first_across_rows(normalized_rows, ['felonyOrMisdemeanorInvolved']))
    _add_path_text(root, ['filer', 'cik'], _first_across_rows(normalized_rows, ['cik']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'fileNumber'], _first_across_rows(normalized_rows, ['finsNumber']))
    _add_path_text(root, ['foreignAgency', 'involved'], _first_across_rows(normalized_rows, ['foreignAgencyInvolved']))
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['headerDataSubmissionType']))
    _add_path_text(root, ['otherControlFinance', 'otherEntity'], _first_across_rows(normalized_rows, ['otherEntity']))
    _add_path_text(root, ['otherControlManagement', 'otherEntity'], _first_across_rows(normalized_rows, ['otherControlManagementOtherEntity']))
    _add_path_text(root, ['otherFelony', 'involved'], _first_across_rows(normalized_rows, ['otherFelonyInvolved']))
    _add_path_text(root, ['registrant', 'conductBusinessInOtherLocations'], _first_across_rows(normalized_rows, ['conductBusinessInOtherLocations']))
    _add_path_text(root, ['registrant', 'differentMailingAddress'], _first_across_rows(normalized_rows, ['differentMailingAddress']))
    _add_path_text(root, ['registrant', 'engagedAsServiceCompany'], _first_across_rows(normalized_rows, ['engagedAsServiceCompany']))
    _add_path_text(root, ['registrant', 'engagedServiceCompany'], _first_across_rows(normalized_rows, ['engagedServiceCompany']))
    _add_path_text(root, ['registrant', 'entityName'], _first_across_rows(normalized_rows, ['entityName']))
    _add_path_text(root, ['registrant', 'registrantType'], _first_across_rows(normalized_rows, ['registrantType']))
    _add_path_text(root, ['registrant', 'selfTransferAgent'], _first_across_rows(normalized_rows, ['selfTransferAgent']))
    _add_path_text(root, ['registrant', 'telephoneNumber'], _first_across_rows(normalized_rows, ['telephoneNumber']))
    _add_path_text(root, ['registrationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['registrationDeniedOrSuspendedInvolved']))
    _add_path_text(root, ['revokedBond', 'involved'], _first_across_rows(normalized_rows, ['revokedBondInvolved']))
    _add_path_text(root, ['signatureData', 'signatureDate'], _first_across_rows(normalized_rows, ['signatureDate']))
    _add_path_text(root, ['signatureData', 'signatureName'], _first_across_rows(normalized_rows, ['signatureName']))
    _add_path_text(root, ['signatureData', 'signaturePhoneNumber'], _first_across_rows(normalized_rows, ['signaturePhoneNumber']))
    _add_path_text(root, ['signatureData', 'signatureTitle'], _first_across_rows(normalized_rows, ['signatureTitle']))
    _add_path_text(root, ['subjectOfProceedings', 'involved'], _first_across_rows(normalized_rows, ['subjectOfProceedingsInvolved']))
    _add_path_text(root, ['unsatisfiedJudgementsOrLiens', 'involved'], _first_across_rows(normalized_rows, ['unsatisfiedJudgementsOrLiensInvolved']))
    _add_path_text(root, ['violationOfInvestmentRelatedRegulation', 'involved'], _first_across_rows(normalized_rows, ['violationOfInvestmentRelatedRegulationInvolved']))
    _add_path_text(root, ['violationOfRegulations', 'involved'], _first_across_rows(normalized_rows, ['violationOfRegulationsInvolved']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'corporationPartnershipData', 'relationshipStartDate'], _first_across_rows(normalized_rows, ['corporationPartnershipDataRelationshipStartDate']))
    _add_path_text(root, ['violationOfRegulations', 'violationOfRegulationsDetails', 'actionDescription'], _first_across_rows(normalized_rows, ['authorityDescription']))
    _add_path_text(root, ['otherControlManagement', 'otherControlManagementDetails', 'agreementDescription'], _first_across_rows(normalized_rows, ['registrantTypeDescription']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'corporationPartnershipData', 'entityName'], _first_across_rows(normalized_rows, ['independentRegistrantCorporationPartnershipDataEntityName']))
    _add_path_text(root, ['registrant', 'corporationPartnershipData', 'relationshipStartDate'], _first_across_rows(normalized_rows, ['relationshipStartDate']))
    _add_path_text(root, ['formData', 'registrant', 'conductBusinessInOtherLocations'], _first_across_rows(normalized_rows, ['registrantConductBusinessInOtherLocations']))
    _add_path_text(root, ['registrant', 'corporationPartnershipData', 'entityName'], _first_across_rows(normalized_rows, ['corporationPartnershipDataEntityName']))
    _add_path_text(root, ['federalOrStateRegulatoryAgency', 'fsrAuthorizationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['fsrAuthorizationDeniedOrSuspendedInvolved']))
    _add_path_text(root, ['federalOrStateRegulatoryAgency', 'fsrFalseStatementOrOmission', 'involved'], _first_across_rows(normalized_rows, ['fsrFalseStatementOrOmissionInvolved']))
    _add_path_text(root, ['federalOrStateRegulatoryAgency', 'fsrFoundOrderAgainstApplicant', 'involved'], _first_across_rows(normalized_rows, ['fsrFoundOrderAgainstApplicantInvolved']))
    _add_path_text(root, ['federalOrStateRegulatoryAgency', 'fsrRegistrationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['fsrRegistrationDeniedOrSuspendedInvolved']))
    _add_path_text(root, ['federalOrStateRegulatoryAgency', 'fsrRevokedSuspendedLicense', 'involved'], _first_across_rows(normalized_rows, ['fsrRevokedSuspendedLicenseInvolved']))
    _add_path_text(root, ['federalOrStateRegulatoryAgency', 'fsrViolationOfInvestmentRelatedRegulation', 'involved'], _first_across_rows(normalized_rows, ['fsrViolationOfInvestmentRelatedRegulationInvolved']))
    _add_path_text(root, ['formData', 'registrant', 'entityName'], _first_across_rows(normalized_rows, ['registrantEntityName']))
    _add_path_text(root, ['formData', 'signature', 'signatureTitle'], _first_across_rows(normalized_rows, ['signatureSignatureTitle']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'registrantType'], _first_across_rows(normalized_rows, ['independentRegistrantRegistrantType']))
    _add_path_text(root, ['formData', 'registrant', 'differentMailingAddress'], _first_across_rows(normalized_rows, ['registrantDifferentMailingAddress']))
    _add_path_text(root, ['formData', 'registrant', 'engagedAsServiceCompany'], _first_across_rows(normalized_rows, ['registrantEngagedAsServiceCompany']))
    _add_path_text(root, ['formData', 'registrant', 'engagedServiceCompany'], _first_across_rows(normalized_rows, ['registrantEngagedServiceCompany']))
    _add_path_text(root, ['formData', 'registrant', 'finsNumber'], _first_across_rows(normalized_rows, ['registrantFinsNumber']))
    _add_path_text(root, ['formData', 'registrant', 'regulatoryAgency'], _first_across_rows(normalized_rows, ['registrantRegulatoryAgency']))
    _add_path_text(root, ['formData', 'registrant', 'selfTransferAgent'], _first_across_rows(normalized_rows, ['registrantSelfTransferAgent']))
    _add_path_text(root, ['formData', 'registrant', 'telephoneNumber'], _first_across_rows(normalized_rows, ['registrantTelephoneNumber']))
    _add_path_text(root, ['formData', 'signature', 'signatureDate'], _first_across_rows(normalized_rows, ['signatureSignatureDate']))
    _add_path_text(root, ['formData', 'signature', 'signatureName'], _first_across_rows(normalized_rows, ['signatureSignatureName']))
    _add_path_text(root, ['formData', 'signature', 'signaturePhoneNumber'], _first_across_rows(normalized_rows, ['signatureSignaturePhoneNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], _first_across_rows(normalized_rows, ['liveTestFlag']))
    _add_path_text(root, ['registrant', 'corporationPartnershipData', 'controlPerson'], _first_across_rows(normalized_rows, ['controlPerson']))
    _add_path_text(root, ['registrant', 'corporationPartnershipData', 'ownershipCode'], _first_across_rows(normalized_rows, ['ownershipCode']))
    _add_path_text(root, ['registrant', 'corporationPartnershipData', 'titleOrStatus'], _first_across_rows(normalized_rows, ['titleOrStatus']))
    _add_path_text(root, ['registrant', 'principalOfficeAddress', 'city'], _first_across_rows(normalized_rows, ['city']))
    _add_path_text(root, ['registrant', 'principalOfficeAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['stateOrCountry']))
    _add_path_text(root, ['registrant', 'principalOfficeAddress', 'stateOrCountryCode'], _first_across_rows(normalized_rows, ['stateOrCountryCode']))
    _add_path_text(root, ['registrant', 'principalOfficeAddress', 'street1'], _first_across_rows(normalized_rows, ['street1']))
    _add_path_text(root, ['registrant', 'principalOfficeAddress', 'street2'], _first_across_rows(normalized_rows, ['street2']))
    _add_path_text(root, ['registrant', 'principalOfficeAddress', 'zipCode'], _first_across_rows(normalized_rows, ['zipCode']))
    _add_path_text(root, ['selfRegulatoryAgency', 'sraAuthorizationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['sraAuthorizationDeniedOrSuspendedInvolved']))
    _add_path_text(root, ['selfRegulatoryAgency', 'sraFalseStatementOrOmission', 'involved'], _first_across_rows(normalized_rows, ['sraFalseStatementOrOmissionInvolved']))
    _add_path_text(root, ['selfRegulatoryAgency', 'sraRevokedSuspendedLicense', 'involved'], _first_across_rows(normalized_rows, ['sraRevokedSuspendedLicenseInvolved']))
    _add_path_text(root, ['selfRegulatoryAgency', 'sraViolationOfRules', 'involved'], _first_across_rows(normalized_rows, ['sraViolationOfRulesInvolved']))
    _add_path_text(root, ['federalOrStateRegulatoryAgency', 'fsrFoundOrderAgainstApplicant', 'fsrFoundOrderAgainstApplicantDetails', 'entityName'], _first_across_rows(normalized_rows, ['soleProprietorshipOtherDataEntityName']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'authorizationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['authorizationDeniedOrSuspendedInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'enjoinedInvestmentRelatedActivity', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryEnjoinedInvestmentRelatedActivityInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'falseStatementOrOmission', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryFalseStatementOrOmissionInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'felonyOrMisdemeanor', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryFelonyOrMisdemeanorInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'foreignAgency', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryForeignAgencyInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'otherFelony', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryOtherFelonyInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'registrationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryRegistrationDeniedOrSuspendedInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'revokedBond', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryRevokedBondInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'subjectOfProceedings', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistorySubjectOfProceedingsInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'unsatisfiedJudgementsOrLiens', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryUnsatisfiedJudgementsOrLiensInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'violationOfInvestmentRelatedRegulation', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryViolationOfInvestmentRelatedRegulationInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'violationOfRegulations', 'involved'], _first_across_rows(normalized_rows, ['disciplinaryHistoryViolationOfRegulationsInvolved']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'corporationPartnershipData', 'controlPerson'], _first_across_rows(normalized_rows, ['corporationPartnershipDataControlPerson']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'corporationPartnershipData', 'ownershipCode'], _first_across_rows(normalized_rows, ['corporationPartnershipDataOwnershipCode']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'corporationPartnershipData', 'titleOrStatus'], _first_across_rows(normalized_rows, ['corporationPartnershipDataTitleOrStatus']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'otherControlFinance', 'otherEntity'], _first_across_rows(normalized_rows, ['otherControlFinanceOtherEntity']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'otherControlManagement', 'otherEntity'], _first_across_rows(normalized_rows, ['independentRegistrantOtherControlManagementOtherEntity']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'soleProprietorshipOtherData', 'relationshipStartDate'], _first_across_rows(normalized_rows, ['soleProprietorshipOtherDataRelationshipStartDate']))
    _add_path_text(root, ['formData', 'independentRegistrant', 'soleProprietorshipOtherData', 'titleOrStatus'], _first_across_rows(normalized_rows, ['soleProprietorshipOtherDataTitleOrStatus']))
    _add_path_text(root, ['formData', 'registrant', 'principalOfficeAddress', 'city'], _first_across_rows(normalized_rows, ['principalOfficeAddressCity']))
    _add_path_text(root, ['formData', 'registrant', 'principalOfficeAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['principalOfficeAddressStateOrCountry']))
    _add_path_text(root, ['formData', 'registrant', 'principalOfficeAddress', 'street1'], _first_across_rows(normalized_rows, ['principalOfficeAddressStreet1']))
    _add_path_text(root, ['formData', 'registrant', 'principalOfficeAddress', 'street2'], _first_across_rows(normalized_rows, ['principalOfficeAddressStreet2']))
    _add_path_text(root, ['formData', 'registrant', 'principalOfficeAddress', 'zipCode'], _first_across_rows(normalized_rows, ['principalOfficeAddressZipCode']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], _first_across_rows(normalized_rows, ['returnCopyFlag']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'federalOrStateRegulatoryAgency', 'fsrAuthorizationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['federalOrStateRegulatoryAgencyFsrAuthorizationDeniedOrSuspendedInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'federalOrStateRegulatoryAgency', 'fsrFalseStatementOrOmission', 'involved'], _first_across_rows(normalized_rows, ['federalOrStateRegulatoryAgencyFsrFalseStatementOrOmissionInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'federalOrStateRegulatoryAgency', 'fsrFoundOrderAgainstApplicant', 'involved'], _first_across_rows(normalized_rows, ['federalOrStateRegulatoryAgencyFsrFoundOrderAgainstApplicantInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'federalOrStateRegulatoryAgency', 'fsrRegistrationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['federalOrStateRegulatoryAgencyFsrRegistrationDeniedOrSuspendedInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'federalOrStateRegulatoryAgency', 'fsrRevokedSuspendedLicense', 'involved'], _first_across_rows(normalized_rows, ['federalOrStateRegulatoryAgencyFsrRevokedSuspendedLicenseInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'federalOrStateRegulatoryAgency', 'fsrViolationOfInvestmentRelatedRegulation', 'involved'], _first_across_rows(normalized_rows, ['federalOrStateRegulatoryAgencyFsrViolationOfInvestmentRelatedRegulationInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'selfRegulatoryAgency', 'sraAuthorizationDeniedOrSuspended', 'involved'], _first_across_rows(normalized_rows, ['selfRegulatoryAgencySraAuthorizationDeniedOrSuspendedInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'selfRegulatoryAgency', 'sraFalseStatementOrOmission', 'involved'], _first_across_rows(normalized_rows, ['selfRegulatoryAgencySraFalseStatementOrOmissionInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'selfRegulatoryAgency', 'sraRevokedSuspendedLicense', 'involved'], _first_across_rows(normalized_rows, ['selfRegulatoryAgencySraRevokedSuspendedLicenseInvolved']))
    _add_path_text(root, ['formData', 'disciplinaryHistory', 'selfRegulatoryAgency', 'sraViolationOfRules', 'involved'], _first_across_rows(normalized_rows, ['selfRegulatoryAgencySraViolationOfRulesInvolved']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'ccc'], _first_across_rows(normalized_rows, ['ccc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'cik'], _first_across_rows(normalized_rows, ['filerCredentialsCik']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')
