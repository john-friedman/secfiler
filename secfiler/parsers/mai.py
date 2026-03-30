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

def construct_mai(rows: list) -> bytes:
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
    root.set('xmlns', 'http://www.sec.gov/edgar/maifiler')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common_ma')
    root.set('xmlns:com1', 'http://www.sec.gov/edgar/common')
    _add_path_text(root, ['formData', 'applicantCrdNum'], _first_across_rows(normalized_rows, ['applicantCrdNum']))
    _add_path_text(root, ['formData', 'hasMoreThanOneAdvisoryFirms'], _first_across_rows(normalized_rows, ['hasMoreThanOneAdvisoryFirms']))
    _add_path_text(root, ['formData', 'isAmendment'], _first_across_rows(normalized_rows, ['isAmendment']))
    _add_path_text(root, ['formData', 'isEngagedInOtherBusiness'], _first_across_rows(normalized_rows, ['isEngagedInOtherBusiness']))
    _add_path_text(root, ['formData', 'isIndividual'], _first_across_rows(normalized_rows, ['isIndividual']))
    _add_path_text(root, ['formData', 'noOfAdvisoryFirms'], _first_across_rows(normalized_rows, ['noOfAdvisoryFirms']))
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['formData', 'applicantName', 'firstName'], _first_across_rows(normalized_rows, ['firstName']))
    _add_path_text(root, ['formData', 'applicantName', 'lastName'], _first_across_rows(normalized_rows, ['lastName']))
    _add_path_text(root, ['formData', 'applicantName', 'middleName'], _first_across_rows(normalized_rows, ['middleName']))
    _add_path_text(root, ['formData', 'applicantName', 'suffix'], _first_across_rows(normalized_rows, ['suffix']))
    _add_path_text(root, ['formData', 'selfCertification', 'crdNumber'], _first_across_rows(normalized_rows, ['crdNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contactEmail'], _first_across_rows(normalized_rows, ['contactEmail']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'civilDisclosure', 'isDismissed'], _first_across_rows(normalized_rows, ['isDismissed']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'civilDisclosure', 'isEnjoined'], _first_across_rows(normalized_rows, ['isEnjoined']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'civilDisclosure', 'isFoundInViolationOfRegulation'], _first_across_rows(normalized_rows, ['isFoundInViolationOfRegulation']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'civilDisclosure', 'isNamedInCivilProceeding'], _first_across_rows(normalized_rows, ['isNamedInCivilProceeding']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'complaintDisclosure', 'isComplaintPending'], _first_across_rows(normalized_rows, ['isComplaintPending']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'complaintDisclosure', 'isComplaintSettled'], _first_across_rows(normalized_rows, ['isComplaintSettled']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'complaintDisclosure', 'isFraudCasePending'], _first_across_rows(normalized_rows, ['isFraudCasePending']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'complaintDisclosure', 'isFraudCaseResultedAward'], _first_across_rows(normalized_rows, ['isFraudCaseResultedAward']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'complaintDisclosure', 'isFraudCaseSettled'], _first_across_rows(normalized_rows, ['isFraudCaseSettled']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'criminalDisclosure', 'isChargedWithMisdemeanor'], _first_across_rows(normalized_rows, ['isChargedWithMisdemeanor']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'criminalDisclosure', 'isConvictedOfMisdemeanor'], _first_across_rows(normalized_rows, ['isConvictedOfMisdemeanor']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'criminalDisclosure', 'isOrgChargedWithMisdemeanor'], _first_across_rows(normalized_rows, ['isOrgChargedWithMisdemeanor']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'criminalDisclosure', 'isOrgConvictedOfMisdemeanor'], _first_across_rows(normalized_rows, ['isOrgConvictedOfMisdemeanor']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'financialDisclosure', 'isBankruptcyPetition'], _first_across_rows(normalized_rows, ['isBankruptcyPetition']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'financialDisclosure', 'isBondRevoked'], _first_across_rows(normalized_rows, ['isBondRevoked']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'financialDisclosure', 'isCompromised'], _first_across_rows(normalized_rows, ['isCompromised']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'financialDisclosure', 'isTrusteeApointed'], _first_across_rows(normalized_rows, ['isTrusteeApointed']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'investigationDisclosure', 'isInvestigated'], _first_across_rows(normalized_rows, ['isInvestigated']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'judgmentLienDisclosure', 'isLienAgainst'], _first_across_rows(normalized_rows, ['isLienAgainst']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'isAssociationBared'], _first_across_rows(normalized_rows, ['isAssociationBared']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'isFailedResonably'], _first_across_rows(normalized_rows, ['isFailedResonably']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'isFailedToSupervise'], _first_across_rows(normalized_rows, ['isFailedToSupervise']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'isFinalOrder'], _first_across_rows(normalized_rows, ['isFinalOrder']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'isFoundWillFullyAided'], _first_across_rows(normalized_rows, ['isFoundWillFullyAided']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'isViolatedSecurityAct'], _first_across_rows(normalized_rows, ['isViolatedSecurityAct']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'isWillFullyAided'], _first_across_rows(normalized_rows, ['isWillFullyAided']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'isWillFullyViolatedSecurityAct'], _first_across_rows(normalized_rows, ['isWillFullyViolatedSecurityAct']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'terminationDisclosure', 'isFailedToSupervise'], _first_across_rows(normalized_rows, ['terminationDisclosureIsFailedToSupervise']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'terminationDisclosure', 'isInvolvedInFraud'], _first_across_rows(normalized_rows, ['isInvolvedInFraud']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'terminationDisclosure', 'isViloatedIndustryStandard'], _first_across_rows(normalized_rows, ['isViloatedIndustryStandard']))
    _add_path_text(root, ['formData', 'employmentHistory', 'currentEmployer', 'isRelatedToInvestment'], _first_across_rows(normalized_rows, ['isRelatedToInvestment']))
    _add_path_text(root, ['formData', 'employmentHistory', 'currentEmployer', 'isRelatedToMunicipalAdvisor'], _first_across_rows(normalized_rows, ['isRelatedToMunicipalAdvisor']))
    _add_path_text(root, ['formData', 'employmentHistory', 'currentEmployer', 'name'], _first_across_rows(normalized_rows, ['name']))
    _add_path_text(root, ['formData', 'employmentHistory', 'currentEmployer', 'positionDescription'], _first_across_rows(normalized_rows, ['positionDescription']))
    _add_path_text(root, ['formData', 'employmentHistory', 'currentEmployer', 'startDate'], _first_across_rows(normalized_rows, ['startDate']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'approximateHoursOrMonths'], _first_across_rows(normalized_rows, ['approximateHoursOrMonths']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'dutiesDescription'], _first_across_rows(normalized_rows, ['dutiesDescription']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'isRelatedToInvestment'], _first_across_rows(normalized_rows, ['otherBusinessIsRelatedToInvestment']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'isRelatedToMunicipalAdvisor'], _first_across_rows(normalized_rows, ['otherBusinessIsRelatedToMunicipalAdvisor']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'name'], _first_across_rows(normalized_rows, ['otherBusinessName']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'natureOfBusiness'], _first_across_rows(normalized_rows, ['natureOfBusiness']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'positionDescription'], _first_across_rows(normalized_rows, ['otherBusinessPositionDescription']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'startDate'], _first_across_rows(normalized_rows, ['otherBusinessStartDate']))
    _add_path_text(root, ['formData', 'otherNames', 'otherName', 'firstName'], _first_across_rows(normalized_rows, ['otherNameFirstName']))
    _add_path_text(root, ['formData', 'otherNames', 'otherName', 'lastName'], _first_across_rows(normalized_rows, ['otherNameLastName']))
    _add_path_text(root, ['formData', 'otherNames', 'otherName', 'middleName'], _first_across_rows(normalized_rows, ['otherNameMiddleName']))
    _add_path_text(root, ['formData', 'otherNames', 'otherName', 'suffix'], _first_across_rows(normalized_rows, ['otherNameSuffix']))
    _add_path_text(root, ['formData', 'selfCertification', 'signature', 'dateSigned'], _first_across_rows(normalized_rows, ['dateSigned']))
    _add_path_text(root, ['formData', 'selfCertification', 'signature', 'signature'], _first_across_rows(normalized_rows, ['signature']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signature', 'dateSigned'], _first_across_rows(normalized_rows, ['signatureDateSigned']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signature', 'signature'], _first_across_rows(normalized_rows, ['signatureSignature']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signature', 'title'], _first_across_rows(normalized_rows, ['title']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'name'], _first_across_rows(normalized_rows, ['contactName']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'phoneNumber'], _first_across_rows(normalized_rows, ['phoneNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCcc'], _first_across_rows(normalized_rows, ['filerCcc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerId'], _first_across_rows(normalized_rows, ['filerId']))
    _add_path_text(root, ['headerData', 'filerInfo', 'notifications', 'internetNotificationAddress'], _first_across_rows(normalized_rows, ['internetNotificationAddress']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'criminalDisclosure', 'criminalDisclosureCommonQuestion', 'isChargedWithFelony'], _first_across_rows(normalized_rows, ['isChargedWithFelony']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'criminalDisclosure', 'criminalDisclosureCommonQuestion', 'isConvictedOfFelony'], _first_across_rows(normalized_rows, ['isConvictedOfFelony']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'criminalDisclosure', 'criminalDisclosureCommonQuestion', 'isOrgChargedWithFelony'], _first_across_rows(normalized_rows, ['isOrgChargedWithFelony']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'criminalDisclosure', 'criminalDisclosureCommonQuestion', 'isOrgConvictedOfFelony'], _first_across_rows(normalized_rows, ['isOrgConvictedOfFelony']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isAuthorizedToActAttorney'], _first_across_rows(normalized_rows, ['isAuthorizedToActAttorney']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isCauseOfDenial'], _first_across_rows(normalized_rows, ['isCauseOfDenial']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isDeniedLicense'], _first_across_rows(normalized_rows, ['isDeniedLicense']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isDiscipliend'], _first_across_rows(normalized_rows, ['isDiscipliend']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isFoundInCauseOfDenial'], _first_across_rows(normalized_rows, ['isFoundInCauseOfDenial']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isFoundInCauseOfSuspension'], _first_across_rows(normalized_rows, ['isFoundInCauseOfSuspension']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isFoundInViolationOfRegulation'], _first_across_rows(normalized_rows, ['regulatoryDisclosureCommonQuestionIsFoundInViolationOfRegulation']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isFoundInViolationOfRules'], _first_across_rows(normalized_rows, ['isFoundInViolationOfRules']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isFoundMadeFalseStatement'], _first_across_rows(normalized_rows, ['isFoundMadeFalseStatement']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isImposedPenalty'], _first_across_rows(normalized_rows, ['isImposedPenalty']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isMadeFalseStatement'], _first_across_rows(normalized_rows, ['isMadeFalseStatement']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isOrderAgainst'], _first_across_rows(normalized_rows, ['isOrderAgainst']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isOrderAgainstActivity'], _first_across_rows(normalized_rows, ['isOrderAgainstActivity']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isRegulatoryComplaint'], _first_across_rows(normalized_rows, ['isRegulatoryComplaint']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isUnEthical'], _first_across_rows(normalized_rows, ['isUnEthical']))
    _add_path_text(root, ['formData', 'disclosureQuestions', 'regulatoryDisclosure', 'regulatoryDisclosureCommonQuestion', 'isViolatedRegulation'], _first_across_rows(normalized_rows, ['isViolatedRegulation']))
    _add_path_text(root, ['formData', 'drpInfo', 'criminalDisclosure', 'criminalDrp', 'criminalQuestions'], _first_across_rows(normalized_rows, ['criminalQuestions']))
    _add_path_text(root, ['formData', 'drpInfo', 'customerComplaintDisclosure', 'customerComplaintDrp', 'customerComplaintQuestions'], _first_across_rows(normalized_rows, ['customerComplaintQuestions']))
    _add_path_text(root, ['formData', 'drpInfo', 'regulatoryDisclosure', 'regulatoryDrp', 'regulatoryQuestions'], _first_across_rows(normalized_rows, ['regulatoryQuestions']))
    _add_path_text(root, ['formData', 'employmentHistory', 'currentEmployer', 'addressInfo', 'city'], _first_across_rows(normalized_rows, ['city']))
    _add_path_text(root, ['formData', 'employmentHistory', 'currentEmployer', 'addressInfo', 'zipCode'], _first_across_rows(normalized_rows, ['zipCode']))
    _add_path_text(root, ['formData', 'employmentHistory', 'priorEmployers', 'priorEmployer', 'endDate'], _first_across_rows(normalized_rows, ['endDate']))
    _add_path_text(root, ['formData', 'employmentHistory', 'priorEmployers', 'priorEmployer', 'isRelatedToInvestment'], _first_across_rows(normalized_rows, ['priorEmployerIsRelatedToInvestment']))
    _add_path_text(root, ['formData', 'employmentHistory', 'priorEmployers', 'priorEmployer', 'isRelatedToMunicipalAdvisor'], _first_across_rows(normalized_rows, ['priorEmployerIsRelatedToMunicipalAdvisor']))
    _add_path_text(root, ['formData', 'employmentHistory', 'priorEmployers', 'priorEmployer', 'name'], _first_across_rows(normalized_rows, ['priorEmployerName']))
    _add_path_text(root, ['formData', 'employmentHistory', 'priorEmployers', 'priorEmployer', 'positionDescription'], _first_across_rows(normalized_rows, ['priorEmployerPositionDescription']))
    _add_path_text(root, ['formData', 'employmentHistory', 'priorEmployers', 'priorEmployer', 'startDate'], _first_across_rows(normalized_rows, ['priorEmployerStartDate']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'municipalFirm', 'isIndependentRelatioship'], _first_across_rows(normalized_rows, ['isIndependentRelatioship']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'municipalFirm', 'municipalDbaName'], _first_across_rows(normalized_rows, ['municipalDbaName']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'municipalFirm', 'municipalFirmName'], _first_across_rows(normalized_rows, ['municipalFirmName']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'municipalFirm', 'recentEmploymentCommencedDate'], _first_across_rows(normalized_rows, ['recentEmploymentCommencedDate']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'addressInfo', 'city'], _first_across_rows(normalized_rows, ['addressInfoCity']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'addressInfo', 'stateOrCountry'], _first_across_rows(normalized_rows, ['stateOrCountry']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'addressInfo', 'street1'], _first_across_rows(normalized_rows, ['street1']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'addressInfo', 'street2'], _first_across_rows(normalized_rows, ['street2']))
    _add_path_text(root, ['formData', 'otherBusinesses', 'otherBusiness', 'addressInfo', 'zipCode'], _first_across_rows(normalized_rows, ['addressInfoZipCode']))
    _add_path_text(root, ['formData', 'selfCertification', 'signature', 'nameOfApplicant', 'firstName'], _first_across_rows(normalized_rows, ['nameOfApplicantFirstName']))
    _add_path_text(root, ['formData', 'selfCertification', 'signature', 'nameOfApplicant', 'lastName'], _first_across_rows(normalized_rows, ['nameOfApplicantLastName']))
    _add_path_text(root, ['formData', 'selfCertification', 'signature', 'nameOfApplicant', 'middleName'], _first_across_rows(normalized_rows, ['nameOfApplicantMiddleName']))
    _add_path_text(root, ['formData', 'employmentHistory', 'currentEmployer', 'addressInfo', 'stateOrCountry', 'stateOrCountry'], _first_across_rows(normalized_rows, ['stateOrCountryStateOrCountry']))
    _add_path_text(root, ['formData', 'employmentHistory', 'priorEmployers', 'priorEmployer', 'addressInfo', 'city'], _first_across_rows(normalized_rows, ['priorEmployerAddressInfoCity']))
    _add_path_text(root, ['formData', 'employmentHistory', 'priorEmployers', 'priorEmployer', 'addressInfo', 'zipCode'], _first_across_rows(normalized_rows, ['priorEmployerAddressInfoZipCode']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'advisorOffices', 'advisorOffice', 'locationInfo'], _first_across_rows(normalized_rows, ['locationInfo']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'advisorOffices', 'advisorOffice', 'startDate'], _first_across_rows(normalized_rows, ['advisorOfficeStartDate']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'maRegistration', 'notSecRegistered', 'explanation'], _first_across_rows(normalized_rows, ['explanation']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'maRegistration', 'secRegistration', 'fileNumber'], _first_across_rows(normalized_rows, ['fileNumber']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'municipalFirm', 'municipalFiler', 'filerId'], _first_across_rows(normalized_rows, ['municipalFilerFilerId']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'maRegistration', 'notSecRegistered', 'hasFiled', 'filingDate'], _first_across_rows(normalized_rows, ['filingDate']))
    _add_path_text(root, ['formData', 'employmentHistory', 'priorEmployers', 'priorEmployer', 'addressInfo', 'stateOrCountry', 'stateOrCountry'], _first_across_rows(normalized_rows, ['addressInfoStateOrCountryStateOrCountry']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'maRegistration', 'notSecRegistered', 'hasFiled', 'cik'], _first_across_rows(normalized_rows, ['cik']))
    _add_path_text(root, ['formData', 'drpInfo', 'regulatoryDisclosure', 'regulatoryDrp', 'baseHeader', 'filingInfo', 'formADVBDFiling', 'crdNumber'], _first_across_rows(normalized_rows, ['formADVBDFilingCrdNumber']))
    _add_path_text(root, ['formData', 'drpInfo', 'regulatoryDisclosure', 'regulatoryDrp', 'baseHeader', 'filingInfo', 'formADVBDFiling', 'disclosureNumber'], _first_across_rows(normalized_rows, ['disclosureNumber']))
    _add_path_text(root, ['formData', 'drpInfo', 'regulatoryDisclosure', 'regulatoryDrp', 'baseHeader', 'filingInfo', 'formADVBDFiling', 'filingName'], _first_across_rows(normalized_rows, ['filingName']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'advisorOffices', 'advisorOffice', 'addressInfo', 'address', 'city'], _first_across_rows(normalized_rows, ['addressCity']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'advisorOffices', 'advisorOffice', 'addressInfo', 'address', 'stateOrCountry'], _first_across_rows(normalized_rows, ['addressStateOrCountry']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'advisorOffices', 'advisorOffice', 'addressInfo', 'address', 'street1'], _first_across_rows(normalized_rows, ['addressStreet1']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'advisorOffices', 'advisorOffice', 'addressInfo', 'address', 'street2'], _first_across_rows(normalized_rows, ['addressStreet2']))
    _add_path_text(root, ['formData', 'municipalAdvisorOffices', 'municipalAdvisorOffice', 'advisorOffices', 'advisorOffice', 'addressInfo', 'address', 'zipCode'], _first_across_rows(normalized_rows, ['addressZipCode']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')


