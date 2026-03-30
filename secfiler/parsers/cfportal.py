import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text, _ensure_path



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

def construct_cfportal(rows: list) -> bytes:
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
    root.set('xmlns', 'http://www.sec.gov/edgar/crowdfunding')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['formData', 'escrowArrangements', 'compensationDesc'], _first_across_rows(normalized_rows, ['escrowCompensationDesc']))
    _add_path_text(root, ['formData', 'execution', 'executionDate'], _first_across_rows(normalized_rows, ['executionDate']))
    _add_path_text(root, ['formData', 'execution', 'fullLegalNameFundingPortal'], _first_across_rows(normalized_rows, ['executionFullLegalName']))
    _add_path_text(root, ['formData', 'execution', 'personSignature'], _first_across_rows(normalized_rows, ['executionSignature']))
    _add_path_text(root, ['formData', 'execution', 'personTitle'], _first_across_rows(normalized_rows, ['executionTitle']))
    _add_path_text(root, ['formData', 'formOfOrganization', 'dateIncorporation'], _first_across_rows(normalized_rows, ['dateIncorporation']))
    _add_path_text(root, ['formData', 'formOfOrganization', 'jurisdictionOrganization'], _first_across_rows(normalized_rows, ['jurisdictionOrganization']))
    _add_path_text(root, ['formData', 'formOfOrganization', 'legalStatusForm'], _first_across_rows(normalized_rows, ['legalStatusForm']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'amendmentExplanation'], _first_across_rows(normalized_rows, ['amendmentExplanation']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'anyForeignRegistrations'], _first_across_rows(normalized_rows, ['anyForeignRegistrations']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'anyPreviousRegistrations'], _first_across_rows(normalized_rows, ['anyPreviousRegistrations']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'contactEmployeeTitle'], _first_across_rows(normalized_rows, ['contactTitle']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'fiscalYearEnd'], _first_across_rows(normalized_rows, ['fiscalYearEnd']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'irsEmployerIdNumber'], _first_across_rows(normalized_rows, ['irsEmployerIdNumber']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'legalNameChange'], _first_across_rows(normalized_rows, ['legalNameChange']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'mailingAddressDifferent'], _first_across_rows(normalized_rows, ['mailingAddressDifferent']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'nameOfPortal'], _first_across_rows(normalized_rows, ['nameOfPortal']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'secFileNumbers'], _first_across_rows(normalized_rows, ['secFileNumbers']))
    _add_path_text(root, ['formData', 'nonSecuritiesRelatedBusiness', 'isEngagedInNonSecurities'], _first_across_rows(normalized_rows, ['isEngagedInNonSecurities']))
    _add_path_text(root, ['formData', 'nonSecuritiesRelatedBusiness', 'nonSecuritiesBusinessDesc'], _first_across_rows(normalized_rows, ['nonSecuritiesBusinessDesc']))
    _add_path_text(root, ['formData', 'scheduleC', 'agentName'], _first_across_rows(normalized_rows, ['agentName']))
    _add_path_text(root, ['formData', 'scheduleC', 'personSignature'], _first_across_rows(normalized_rows, ['scheduleCSignature']))
    _add_path_text(root, ['formData', 'scheduleC', 'personTitle'], _first_across_rows(normalized_rows, ['scheduleCTitle']))
    _add_path_text(root, ['formData', 'scheduleC', 'printedName'], _first_across_rows(normalized_rows, ['scheduleCPrintedName']))
    _add_path_text(root, ['formData', 'scheduleC', 'signatureDate'], _first_across_rows(normalized_rows, ['scheduleCSignatureDate']))
    _add_path_text(root, ['formData', 'scheduleD', 'dateBusinessCeasedWithdrawn'], _first_across_rows(normalized_rows, ['dateBusinessCeasedWithdrawn']))
    _add_path_text(root, ['formData', 'scheduleD', 'investorInitiatedComplaint'], _first_across_rows(normalized_rows, ['investorInitiatedComplaint']))
    _add_path_text(root, ['formData', 'scheduleD', 'isInvestigated'], _first_across_rows(normalized_rows, ['isInvestigated']))
    _add_path_text(root, ['formData', 'scheduleD', 'privateCivilLitigation'], _first_across_rows(normalized_rows, ['privateCivilLitigation']))
    _add_path_text(root, ['formData', 'successions', 'isSucceedingBusiness'], _first_across_rows(normalized_rows, ['isSucceedingBusiness']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'drpFiledFor'], _first_across_rows(normalized_rows, ['drpFiledFor']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'initialOrAmended'], _first_across_rows(normalized_rows, ['initialOrAmended']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'drpFiledFor'], _first_across_rows(normalized_rows, ['civilJudicialDrpDrpFiledFor']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'initialOrAmended'], _first_across_rows(normalized_rows, ['civilJudicialDrpInitialOrAmended']))
    _add_path_text(root, ['formData', 'controlRelationships', 'fullLegalNames', 'fullLegalName'], _first_across_rows(normalized_rows, ['controlRelationshipFullLegalName']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'civilJudicialActionDisclosure', 'isDismissed'], _first_across_rows(normalized_rows, ['isDismissed']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'civilJudicialActionDisclosure', 'isEnjoined'], _first_across_rows(normalized_rows, ['isEnjoined']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'civilJudicialActionDisclosure', 'isFoundInViolationOfRegulation'], _first_across_rows(normalized_rows, ['civilIsFoundInViolationOfRegulation']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'civilJudicialActionDisclosure', 'isNamedInCivilProceeding'], _first_across_rows(normalized_rows, ['isNamedInCivilProceeding']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'criminalDisclosure', 'isChargedMisdemeanor'], _first_across_rows(normalized_rows, ['isChargedMisdemeanor']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'criminalDisclosure', 'isChargedWithFelony'], _first_across_rows(normalized_rows, ['isChargedWithFelony']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'criminalDisclosure', 'isConvictedMisdemeanor'], _first_across_rows(normalized_rows, ['isConvictedMisdemeanor']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'criminalDisclosure', 'isConvictedOfFelony'], _first_across_rows(normalized_rows, ['isConvictedOfFelony']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'financialDisclosure', 'doesAppHaveLiens'], _first_across_rows(normalized_rows, ['doesAppHaveLiens']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'financialDisclosure', 'hasBondDenied'], _first_across_rows(normalized_rows, ['hasBondDenied']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'financialDisclosure', 'hasSubjectOfBankruptcy'], _first_across_rows(normalized_rows, ['hasSubjectOfBankruptcy']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'financialDisclosure', 'hasTrusteeAppointed'], _first_across_rows(normalized_rows, ['hasTrusteeAppointed']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isAuthorizedToActAttorney'], _first_across_rows(normalized_rows, ['isAuthorizedToActAttorney']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isCauseOfDenial'], _first_across_rows(normalized_rows, ['isCauseOfDenial']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isDeniedLicense'], _first_across_rows(normalized_rows, ['isDeniedLicense']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isDisciplined'], _first_across_rows(normalized_rows, ['isDisciplined']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isFoundInCauseOfDenial'], _first_across_rows(normalized_rows, ['isFoundInCauseOfDenial']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isFoundInCauseOfSuspension'], _first_across_rows(normalized_rows, ['isFoundInCauseOfSuspension']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isFoundInViolationOfRegulation'], _first_across_rows(normalized_rows, ['isFoundInViolationOfRegulation']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isFoundInViolationOfRules'], _first_across_rows(normalized_rows, ['isFoundInViolationOfRules']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isFoundMadeFalseStatement'], _first_across_rows(normalized_rows, ['isFoundMadeFalseStatement']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isImposedPenalty'], _first_across_rows(normalized_rows, ['isImposedPenalty']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isMadeFalseStatement'], _first_across_rows(normalized_rows, ['isMadeFalseStatement']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isOrderAgainst'], _first_across_rows(normalized_rows, ['isOrderAgainst']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isOrderAgainstActivity'], _first_across_rows(normalized_rows, ['isOrderAgainstActivity']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isRegulatoryComplaint'], _first_across_rows(normalized_rows, ['isRegulatoryComplaint']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isUnEthical'], _first_across_rows(normalized_rows, ['isUnEthical']))
    _add_path_text(root, ['formData', 'disclosureAnswers', 'regulatoryActionDisclosure', 'isViolatedRegulation'], _first_across_rows(normalized_rows, ['isViolatedRegulation']))
    _add_path_text(root, ['formData', 'escrowArrangements', 'investorFundsContacts', 'investorFundsContactName'], _first_across_rows(normalized_rows, ['investorFundsContactName']))
    _add_path_text(root, ['formData', 'escrowArrangements', 'investorFundsContacts', 'investorFundsContactPhone'], _first_across_rows(normalized_rows, ['investorFundsContactPhone']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'contactEmployeeName', 'firstName'], _first_across_rows(normalized_rows, ['contactFirstName']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'contactEmployeeName', 'lastName'], _first_across_rows(normalized_rows, ['contactLastName']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'contactEmployeeName', 'middleName'], _first_across_rows(normalized_rows, ['contactMiddleName']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'contactEmployeeName', 'prefix'], _first_across_rows(normalized_rows, ['contactPrefix']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'contactEmployeeName', 'suffix'], _first_across_rows(normalized_rows, ['suffix']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'otherNamesAndWebsiteUrls', 'otherNamesUsedPortal'], _first_across_rows(normalized_rows, ['otherNamesUsed']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'otherNamesAndWebsiteUrls', 'webSiteOfPortal'], _first_across_rows(normalized_rows, ['webSiteOfPortal']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'otherOfficeLocationAddress', 'city'], _first_across_rows(normalized_rows, ['otherOfficeLocationAddressPortalCity']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'otherOfficeLocationAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['otherOfficeLocationAddressPortalStateOrCountry']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'otherOfficeLocationAddress', 'street1'], _first_across_rows(normalized_rows, ['otherOfficeLocationAddressPortalStreet1']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'otherOfficeLocationAddress', 'street2'], _first_across_rows(normalized_rows, ['otherOfficeLocationAddressPortalStreet2']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'otherOfficeLocationAddress', 'zipCode'], _first_across_rows(normalized_rows, ['otherOfficeLocationAddressPortalZipCode']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalAddress', 'city'], _first_across_rows(normalized_rows, ['portalAddressPortalCity']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['portalAddressPortalStateOrCountry']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalAddress', 'street1'], _first_across_rows(normalized_rows, ['portalAddressPortalStreet1']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalAddress', 'street2'], _first_across_rows(normalized_rows, ['portalAddressPortalStreet2']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalAddress', 'zipCode'], _first_across_rows(normalized_rows, ['portalAddressPortalZipCode']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalContact', 'portalContactEmail'], _first_across_rows(normalized_rows, ['portalContactEmail']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalContact', 'portalContactFax'], _first_across_rows(normalized_rows, ['portalContactFax']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalContact', 'portalContactPhone'], _first_across_rows(normalized_rows, ['portalContactPhone']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalMailingAddress', 'city'], _first_across_rows(normalized_rows, ['mailingCity']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalMailingAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['mailingStateOrCountry']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalMailingAddress', 'street1'], _first_across_rows(normalized_rows, ['mailingStreet1']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalMailingAddress', 'street2'], _first_across_rows(normalized_rows, ['mailingStreet2']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'portalMailingAddress', 'zipCode'], _first_across_rows(normalized_rows, ['mailingZipCode']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'prevNamesAndWebsiteUrls', 'prevNamesOfPortal'], _first_across_rows(normalized_rows, ['prevNamesOfPortal']))
    _add_path_text(root, ['formData', 'identifyingInformation', 'prevNamesAndWebsiteUrls', 'prevWebSiteUrls'], _first_across_rows(normalized_rows, ['prevWebSiteUrls']))
    _add_path_text(root, ['formData', 'scheduleA', 'entityOrNaturalPerson', 'controlPerson'], _first_across_rows(normalized_rows, ['scheduleAControlPerson']))
    _add_path_text(root, ['formData', 'scheduleA', 'entityOrNaturalPerson', 'crdNumber'], _first_across_rows(normalized_rows, ['scheduleACrdNumber']))
    _add_path_text(root, ['formData', 'scheduleA', 'entityOrNaturalPerson', 'dateOfTitleStatusAcquired'], _first_across_rows(normalized_rows, ['scheduleADateOfTitleStatusAcquired']))
    _add_path_text(root, ['formData', 'scheduleA', 'entityOrNaturalPerson', 'entityType'], _first_across_rows(normalized_rows, ['scheduleAEntityType']))
    _add_path_text(root, ['formData', 'scheduleA', 'entityOrNaturalPerson', 'fullLegalName'], _first_across_rows(normalized_rows, ['scheduleAFullLegalName']))
    _add_path_text(root, ['formData', 'scheduleA', 'entityOrNaturalPerson', 'ownershipCode'], _first_across_rows(normalized_rows, ['scheduleAOwnershipCode']))
    _add_path_text(root, ['formData', 'scheduleA', 'entityOrNaturalPerson', 'titleStatus'], _first_across_rows(normalized_rows, ['scheduleATitleStatus']))
    _add_path_text(root, ['formData', 'scheduleB', 'amendEntityOrNaturalPerson', 'controlPerson'], _first_across_rows(normalized_rows, ['scheduleBControlPerson']))
    _add_path_text(root, ['formData', 'scheduleB', 'amendEntityOrNaturalPerson', 'crdNumber'], _first_across_rows(normalized_rows, ['scheduleBCrdNumber']))
    _add_path_text(root, ['formData', 'scheduleB', 'amendEntityOrNaturalPerson', 'dateOfTitleStatusAcquired'], _first_across_rows(normalized_rows, ['scheduleBDateOfTitleStatusAcquired']))
    _add_path_text(root, ['formData', 'scheduleB', 'amendEntityOrNaturalPerson', 'entityType'], _first_across_rows(normalized_rows, ['scheduleBEntityType']))
    _add_path_text(root, ['formData', 'scheduleB', 'amendEntityOrNaturalPerson', 'fullLegalName'], _first_across_rows(normalized_rows, ['scheduleBFullLegalName']))
    _add_path_text(root, ['formData', 'scheduleB', 'amendEntityOrNaturalPerson', 'ownershipCode'], _first_across_rows(normalized_rows, ['scheduleBOwnershipCode']))
    _add_path_text(root, ['formData', 'scheduleB', 'amendEntityOrNaturalPerson', 'titleStatus'], _first_across_rows(normalized_rows, ['scheduleBTitleStatus']))
    _add_path_text(root, ['formData', 'scheduleB', 'amendEntityOrNaturalPerson', 'typeOfAmendment'], _first_across_rows(normalized_rows, ['scheduleBTypeOfAmendment']))
    _add_path_text(root, ['formData', 'scheduleC', 'agentAddress', 'city'], _first_across_rows(normalized_rows, ['portalCity']))
    _add_path_text(root, ['formData', 'scheduleC', 'agentAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['portalStateOrCountry']))
    _add_path_text(root, ['formData', 'scheduleC', 'agentAddress', 'street1'], _first_across_rows(normalized_rows, ['portalStreet1']))
    _add_path_text(root, ['formData', 'scheduleC', 'agentAddress', 'street2'], _first_across_rows(normalized_rows, ['portalStreet2']))
    _add_path_text(root, ['formData', 'scheduleC', 'agentAddress', 'zipCode'], _first_across_rows(normalized_rows, ['portalZipCode']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingEntityFax'], _first_across_rows(normalized_rows, ['bookKeepingEntityFax']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingEntityName'], _first_across_rows(normalized_rows, ['bookKeepingEntityName']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingEntityPhone'], _first_across_rows(normalized_rows, ['bookKeepingEntityPhone']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingEntityType'], _first_across_rows(normalized_rows, ['bookKeepingEntityType']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingLocationDesc'], _first_across_rows(normalized_rows, ['bookKeepingLocationDesc']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'isAddressPrivateResidence'], _first_across_rows(normalized_rows, ['isAddressPrivateResidence']))
    _add_path_text(root, ['formData', 'successions', 'acquiredHistoryDetails', 'acquiredDesc'], _first_across_rows(normalized_rows, ['acquiredDesc']))
    _add_path_text(root, ['formData', 'successions', 'acquiredHistoryDetails', 'acquiredFundingPortal'], _first_across_rows(normalized_rows, ['acquiredFundingPortal']))
    _add_path_text(root, ['formData', 'successions', 'acquiredHistoryDetails', 'acquiredPortalFileNumber'], _first_across_rows(normalized_rows, ['acquiredPortalFileNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'fileNumber'], _first_across_rows(normalized_rows, ['filerCcc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], _first_across_rows(normalized_rows, ['confirmingCopyFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], _first_across_rows(normalized_rows, ['overrideInternetFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], _first_across_rows(normalized_rows, ['returnCopyFlag']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'respondingTo', 'responseQuestion'], _first_across_rows(normalized_rows, ['responseQuestion']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'respondingTo', 'responseQuestion'], _first_across_rows(normalized_rows, ['respondingToResponseQuestion']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'summaryOfDetails'], _first_across_rows(normalized_rows, ['summaryOfCircumstances']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'summaryOfCircumstances'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsSummaryOfCircumstances']))
    _add_path_text(root, ['formData', 'escrowArrangements', 'investorFundsContacts', 'investorFundsAddress', 'city'], _first_across_rows(normalized_rows, ['investorFundsCity']))
    _add_path_text(root, ['formData', 'escrowArrangements', 'investorFundsContacts', 'investorFundsAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['investorFundsStateOrCountry']))
    _add_path_text(root, ['formData', 'escrowArrangements', 'investorFundsContacts', 'investorFundsAddress', 'street1'], _first_across_rows(normalized_rows, ['investorFundsStreet1']))
    _add_path_text(root, ['formData', 'escrowArrangements', 'investorFundsContacts', 'investorFundsAddress', 'street2'], _first_across_rows(normalized_rows, ['investorFundsStreet2']))
    _add_path_text(root, ['formData', 'escrowArrangements', 'investorFundsContacts', 'investorFundsAddress', 'zipCode'], _first_across_rows(normalized_rows, ['investorFundsZipCode']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingEntityAddress', 'city'], _first_across_rows(normalized_rows, ['bookKeepingEntityAddressPortalCity']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingEntityAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['bookKeepingEntityAddressPortalStateOrCountry']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingEntityAddress', 'street1'], _first_across_rows(normalized_rows, ['bookKeepingEntityAddressPortalStreet1']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingEntityAddress', 'street2'], _first_across_rows(normalized_rows, ['bookKeepingEntityAddressPortalStreet2']))
    _add_path_text(root, ['formData', 'scheduleD', 'bookKeepingDetails', 'bookKeepingEntityAddress', 'zipCode'], _first_across_rows(normalized_rows, ['bookKeepingEntityAddressPortalZipCode']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'filerCik'], _first_across_rows(normalized_rows, ['filerCik']))
    _add_path_text(root, ['formData', 'bankruptcySipcDrpInfo', 'bankruptcyDrp', 'affiliatePerson', 'affBankruptcySipcDrpDetails', 'apCrdNumber'], _first_across_rows(normalized_rows, ['apCrdNumber']))
    _add_path_text(root, ['formData', 'bankruptcySipcDrpInfo', 'bankruptcyDrp', 'affiliatePerson', 'affBankruptcySipcDrpDetails', 'controlAffiliateType'], _first_across_rows(normalized_rows, ['controlAffiliateType']))
    _add_path_text(root, ['formData', 'bankruptcySipcDrpInfo', 'bankruptcyDrp', 'affiliatePerson', 'affBankruptcySipcDrpDetails', 'isConAffRegisteredCrd'], _first_across_rows(normalized_rows, ['isConAffRegisteredCrd']))
    _add_path_text(root, ['formData', 'bankruptcySipcDrpInfo', 'bankruptcyDrp', 'affiliatePerson', 'affBankruptcySipcDrpDetails', 'isRegistered'], _first_across_rows(normalized_rows, ['isRegistered']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'applicant', 'civilJudicialDrpDetails', 'cityOrCounty'], _first_across_rows(normalized_rows, ['cityOrCounty']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'applicant', 'civilJudicialDrpDetails', 'civilActionCourtName'], _first_across_rows(normalized_rows, ['civilActionCourtName']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'applicant', 'civilJudicialDrpDetails', 'civilActionCourtType'], _first_across_rows(normalized_rows, ['civilActionCourtType']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'regulatoryActionInitiatedBy'], _first_across_rows(normalized_rows, ['courtActionInitiatorName']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'descAllegations'], _first_across_rows(normalized_rows, ['describeCivilActionAllegations']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'docketOrCaseNumber'], _first_across_rows(normalized_rows, ['docketOrCaseNumber']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'currentStatus'], _first_across_rows(normalized_rows, ['eventCurrentStatus']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'regulatorName'], _first_across_rows(normalized_rows, ['grantOrFineAmount']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'matterResolvedType'], _first_across_rows(normalized_rows, ['matterResolveType']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'otherProductDesc'], _first_across_rows(normalized_rows, ['otherPrincipalProductType']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'applicant', 'civilJudicialDrpDetails', 'principalReliefSought'], _first_across_rows(normalized_rows, ['principalReliefSought']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'principalProductTypeOtherDesc'], _first_across_rows(normalized_rows, ['principalProductType']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'applicant', 'civilJudicialDrpDetails', 'sanctionDetail'], _first_across_rows(normalized_rows, ['sanctionDetail']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'applicant', 'civilJudicialDrpDetails', 'stateOrCountry'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsPortalStateOrCountry']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'associatedPersonDetails', 'crdNumber'], _first_across_rows(normalized_rows, ['associatedPersonDetailsScheduleACrdNumber']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'associatedPersonDetails', 'fullName'], _first_across_rows(normalized_rows, ['fullName']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'associatedPersonDetails', 'personRegistered'], _first_across_rows(normalized_rows, ['personRegistered']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'associatedPersonDetails', 'personType'], _first_across_rows(normalized_rows, ['personType']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'cityOrCounty'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsCityOrCounty']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'civilActionCourtName'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsCivilActionCourtName']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'civilActionCourtType'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsCivilActionCourtType']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'courtActionInitiatorName'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsCourtActionInitiatorName']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'describeCivilActionAllegations'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsDescribeCivilActionAllegations']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'docketOrCaseNumber'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsDocketOrCaseNumber']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'eventCurrentStatus'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsEventCurrentStatus']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'grantOrFineAmount'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsGrantOrFineAmount']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'matterResolveType'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsMatterResolveType']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'otherPrincipalProductType'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsOtherPrincipalProductType']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'principalReliefSought'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsPrincipalReliefSought']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'principalProductType'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsPrincipalProductType']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'sanctionDetail'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsSanctionDetail']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'stateOrCountry'], _first_across_rows(normalized_rows, ['associatedPersonCivilJudicialDrpDetailsPortalStateOrCountry']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'applicant', 'civilJudicialDrpDetails', 'filingDateOfCourtActionExactOrExplain', 'date'], _first_across_rows(normalized_rows, ['filingDateOfCourtActionExactOrExplainDate']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'applicant', 'civilJudicialDrpDetails', 'filingDateOfCourtActionExactOrExplain', 'exactOrExplanation'], _first_across_rows(normalized_rows, ['filingDateOfCourtActionExactOrExplainExactOrExplanation']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'resolutionDateExactExplain', 'date'], _first_across_rows(normalized_rows, ['date']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'resolutionDateExactExplain', 'exactOrExplanation'], _first_across_rows(normalized_rows, ['exactOrExplanation']))
    _add_path_text(root, ['formData', 'regulatoryDrpInfo', 'regulatoryDrp', 'applicant', 'regulatoryDrpDetails', 'sanctionsOrderedDetails', 'sanctionsOrdered', 'sanctionOrdered'], _first_across_rows(normalized_rows, ['sanctionOrdered']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'filingDateOfCourtActionExactOrExplain', 'date'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsFilingDateOfCourtActionExactOrExplainDate']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'filingDateOfCourtActionExactOrExplain', 'exactOrExplanation'], _first_across_rows(normalized_rows, ['civilJudicialDrpDetailsFilingDateOfCourtActionExactOrExplainExactOrExplanation']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'resolutionDateExactOrExplain', 'date'], _first_across_rows(normalized_rows, ['resolutionDateExactOrExplainDate']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'resolutionDateExactOrExplain', 'exactOrExplanation'], _first_across_rows(normalized_rows, ['resolutionDateExactOrExplainExactOrExplanation']))
    _add_path_text(root, ['formData', 'civilJudicialDrpInfo', 'civilJudicialDrp', 'associatedPerson', 'civilJudicialDrpDetails', 'sanctionReliefType', 'sanctionOrdered'], _first_across_rows(normalized_rows, ['sanctionReliefTypeSanctionOrdered']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')


