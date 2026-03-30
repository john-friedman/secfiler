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

def construct_ta2(rows: list) -> bytes:
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
    root.set('xmlns', 'http://www.sec.gov/edgar/ta/tatwofiler')
    _add_path_text(root, ['formVersion'], _first_across_rows(normalized_rows, ['formVersion']))
    _add_path_text(root, ['periodOfReport'], _first_across_rows(normalized_rows, ['periodOfReport']))
    _add_path_text(root, ['regulatoryAgency'], _first_across_rows(normalized_rows, ['regulatoryAgency']))
    _add_path_text(root, ['schemaVersion'], _first_across_rows(normalized_rows, ['schemaVersion']))
    _add_path_text(root, ['submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['testOrLive'], _first_across_rows(normalized_rows, ['testOrLive']))
    _add_path_text(root, ['engagedAsServiceCompany', 'function'], _first_across_rows(normalized_rows, ['function']))
    _add_path_text(root, ['engagedServiceCompany', 'function'], _first_across_rows(normalized_rows, ['engagedServiceCompanyFunction']))
    _add_path_text(root, ['filer', 'cik'], _first_across_rows(normalized_rows, ['cik']))
    _add_path_text(root, ['filer', 'fileNumber'], _first_across_rows(normalized_rows, ['fileNumber']))
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['headerDataSubmissionType']))
    _add_path_text(root, ['inaccurateIncompleteMisleading', 'additionalInformation'], _first_across_rows(normalized_rows, ['additionalInformation']))
    _add_path_text(root, ['inaccurateIncompleteMisleading', 'amendmentFiled'], _first_across_rows(normalized_rows, ['amendmentFiled']))
    _add_path_text(root, ['registrant', 'entityName'], _first_across_rows(normalized_rows, ['entityName']))
    _add_path_text(root, ['serviceCompanyData', 'numberDirectRegistSystemAccounts'], _first_across_rows(normalized_rows, ['numberDirectRegistSystemAccounts']))
    _add_path_text(root, ['serviceCompanyData', 'numberDivReinvDirPurPlanAccounts'], _first_across_rows(normalized_rows, ['numberDivReinvDirPurPlanAccounts']))
    _add_path_text(root, ['serviceCompanyData', 'numberIndividualAccounts'], _first_across_rows(normalized_rows, ['numberIndividualAccounts']))
    _add_path_text(root, ['serviceCompanyData', 'numberItemsReceivedForTransfer'], _first_across_rows(normalized_rows, ['numberItemsReceivedForTransfer']))
    _add_path_text(root, ['serviceCompanyData', 'numberLostAccountsRemittedToStates'], _first_across_rows(normalized_rows, ['numberLostAccountsRemittedToStates']))
    _add_path_text(root, ['serviceCompanyData', 'numberMasterSecurityHolderFilings'], _first_across_rows(normalized_rows, ['numberMasterSecurityHolderFilings']))
    _add_path_text(root, ['signatureData', 'signatureDate'], _first_across_rows(normalized_rows, ['signatureDate']))
    _add_path_text(root, ['signatureData', 'signatureName'], _first_across_rows(normalized_rows, ['signatureName']))
    _add_path_text(root, ['signatureData', 'signaturePhoneNumber'], _first_across_rows(normalized_rows, ['signaturePhoneNumber']))
    _add_path_text(root, ['signatureData', 'signatureTitle'], _first_across_rows(normalized_rows, ['signatureTitle']))
    _add_path_text(root, ['engagedAsServiceCompany', 'asServiceCompanyTransferAgent', 'entityName'], _first_across_rows(normalized_rows, ['asServiceCompanyTransferAgentEntityName']))
    _add_path_text(root, ['engagedAsServiceCompany', 'asServiceCompanyTransferAgent', 'fileNumber'], _first_across_rows(normalized_rows, ['asServiceCompanyTransferAgentFileNumber']))
    _add_path_text(root, ['engagedServiceCompany', 'serviceCompanyTransferAgent', 'entityName'], _first_across_rows(normalized_rows, ['serviceCompanyTransferAgentEntityName']))
    _add_path_text(root, ['engagedServiceCompany', 'serviceCompanyTransferAgent', 'fileNumber'], _first_across_rows(normalized_rows, ['serviceCompanyTransferAgentFileNumber']))
    _add_path_text(root, ['formData', 'engagedServiceCompany', 'registrantEngagedService'], _first_across_rows(normalized_rows, ['registrantEngagedService']))
    _add_path_text(root, ['formData', 'engagedServiceCompany', 'serviceCompany'], _first_across_rows(normalized_rows, ['serviceCompany']))
    _add_path_text(root, ['formData', 'registrantRegulatoryAgency', 'additionalInformation'], _first_across_rows(normalized_rows, ['registrantRegulatoryAgencyAdditionalInformation']))
    _add_path_text(root, ['formData', 'registrantRegulatoryAgency', 'amendmentFiled'], _first_across_rows(normalized_rows, ['registrantRegulatoryAgencyAmendmentFiled']))
    _add_path_text(root, ['formData', 'registrantRegulatoryAgency', 'regulatoryAgency'], _first_across_rows(normalized_rows, ['registrantRegulatoryAgencyRegulatoryAgency']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'numberDirectRegistSystemAccounts'], _first_across_rows(normalized_rows, ['serviceCompanyDataNumberDirectRegistSystemAccounts']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'numberDivReinvDirPurPlanAccounts'], _first_across_rows(normalized_rows, ['serviceCompanyDataNumberDivReinvDirPurPlanAccounts']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'numberIndividualAccounts'], _first_across_rows(normalized_rows, ['serviceCompanyDataNumberIndividualAccounts']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'numberItemsReceivedForTransfer'], _first_across_rows(normalized_rows, ['serviceCompanyDataNumberItemsReceivedForTransfer']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'numberLostAccountsRemittedToStates'], _first_across_rows(normalized_rows, ['serviceCompanyDataNumberLostAccountsRemittedToStates']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'numberMasterSecurityHolderFilings'], _first_across_rows(normalized_rows, ['serviceCompanyDataNumberMasterSecurityHolderFilings']))
    _add_path_text(root, ['formData', 'signatureData', 'signatureDate'], _first_across_rows(normalized_rows, ['signatureDataSignatureDate']))
    _add_path_text(root, ['formData', 'signatureData', 'signatureName'], _first_across_rows(normalized_rows, ['signatureDataSignatureName']))
    _add_path_text(root, ['formData', 'signatureData', 'signaturePhoneNumber'], _first_across_rows(normalized_rows, ['signatureDataSignaturePhoneNumber']))
    _add_path_text(root, ['formData', 'signatureData', 'signatureTitle'], _first_across_rows(normalized_rows, ['signatureDataSignatureTitle']))
    _add_path_text(root, ['headerData', 'filerInfo', 'entityName'], _first_across_rows(normalized_rows, ['filerInfoEntityName']))
    _add_path_text(root, ['headerData', 'filerInfo', 'periodOfReport'], _first_across_rows(normalized_rows, ['filerInfoPeriodOfReport']))
    _add_path_text(root, ['headerData', 'filerInfo', 'testOrLive'], _first_across_rows(normalized_rows, ['filerInfoTestOrLive']))
    _add_path_text(root, ['serviceCompanyData', 'databaseSearch', 'databaseSearchDate'], _first_across_rows(normalized_rows, ['databaseSearchDate']))
    _add_path_text(root, ['serviceCompanyData', 'databaseSearch', 'numberAddressesFromSearch'], _first_across_rows(normalized_rows, ['numberAddressesFromSearch']))
    _add_path_text(root, ['serviceCompanyData', 'databaseSearch', 'numberLostAccountsSearched'], _first_across_rows(normalized_rows, ['numberLostAccountsSearched']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderAccounts', 'debtSecurity'], _first_across_rows(normalized_rows, ['debtSecurity']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderAccounts', 'equitySecurity'], _first_across_rows(normalized_rows, ['equitySecurity']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderAccounts', 'limitedPartnership'], _first_across_rows(normalized_rows, ['limitedPartnership']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderAccounts', 'municipalDebt'], _first_across_rows(normalized_rows, ['municipalDebt']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderAccounts', 'openEndInvestmentCompany'], _first_across_rows(normalized_rows, ['openEndInvestmentCompany']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderAccounts', 'other'], _first_across_rows(normalized_rows, ['other']))
    _add_path_text(root, ['formData', 'engagedServiceCompany', 'asServiceCompanyTransferAgent', 'entityName'], _first_across_rows(normalized_rows, ['engagedServiceCompanyAsServiceCompanyTransferAgentEntityName']))
    _add_path_text(root, ['formData', 'engagedServiceCompany', 'asServiceCompanyTransferAgent', 'fileNumber'], _first_across_rows(normalized_rows, ['engagedServiceCompanyAsServiceCompanyTransferAgentFileNumber']))
    _add_path_text(root, ['formData', 'engagedServiceCompany', 'serviceCompanyTransferAgent', 'entityName'], _first_across_rows(normalized_rows, ['engagedServiceCompanyServiceCompanyTransferAgentEntityName']))
    _add_path_text(root, ['formData', 'engagedServiceCompany', 'serviceCompanyTransferAgent', 'fileNumber'], _first_across_rows(normalized_rows, ['engagedServiceCompanyServiceCompanyTransferAgentFileNumber']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'databaseSearches', 'databaseSearchDate'], _first_across_rows(normalized_rows, ['databaseSearchesDatabaseSearchDate']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'databaseSearches', 'numberAddressesFromSearch'], _first_across_rows(normalized_rows, ['databaseSearchesNumberAddressesFromSearch']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'databaseSearches', 'numberLostAccountsSearched'], _first_across_rows(normalized_rows, ['databaseSearchesNumberLostAccountsSearched']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderAccounts', 'debtSecurity'], _first_across_rows(normalized_rows, ['securityHolderAccountsDebtSecurity']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderAccounts', 'equitySecurity'], _first_across_rows(normalized_rows, ['securityHolderAccountsEquitySecurity']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderAccounts', 'limitedPartnership'], _first_across_rows(normalized_rows, ['securityHolderAccountsLimitedPartnership']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderAccounts', 'municipalDebt'], _first_across_rows(normalized_rows, ['securityHolderAccountsMunicipalDebt']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderAccounts', 'openEndInvestmentCompany'], _first_across_rows(normalized_rows, ['securityHolderAccountsOpenEndInvestmentCompany']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderAccounts', 'other'], _first_across_rows(normalized_rows, ['securityHolderAccountsOther']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'alwaysCompliant'], _first_across_rows(normalized_rows, ['alwaysCompliant']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'directRegistrationSystem'], _first_across_rows(normalized_rows, ['directRegistrationSystem']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'dividendReinvDirectPurchasePlan'], _first_across_rows(normalized_rows, ['dividendReinvDirectPurchasePlan']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'numberFiled'], _first_across_rows(normalized_rows, ['numberFiled']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'total'], _first_across_rows(normalized_rows, ['total']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'totalOtherThanReceiptOrderDate'], _first_across_rows(normalized_rows, ['totalOtherThanReceiptOrderDate']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'fileNumber'], _first_across_rows(normalized_rows, ['filerFileNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'isFilingAmendment'], _first_across_rows(normalized_rows, ['isFilingAmendment']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopy'], _first_across_rows(normalized_rows, ['returnCopy']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'currentAgent', 'amountIssues'], _first_across_rows(normalized_rows, ['amountIssues']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'currentAgent', 'numberIssues'], _first_across_rows(normalized_rows, ['numberIssues']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'directRegistrationSystem', 'numberIssues'], _first_across_rows(normalized_rows, ['directRegistrationSystemNumberIssues']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'dividendAndInterest', 'amountIssues'], _first_across_rows(normalized_rows, ['dividendAndInterestAmountIssues']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'dividendAndInterest', 'numberIssues'], _first_across_rows(normalized_rows, ['dividendAndInterestNumberIssues']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'dividendReinvDirectPurchasePlan', 'numberIssues'], _first_across_rows(normalized_rows, ['dividendReinvDirectPurchasePlanNumberIssues']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'debtSecurity'], _first_across_rows(normalized_rows, ['notTransMaintMasterSecHolderDebtSecurity']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'equitySecurity'], _first_across_rows(normalized_rows, ['notTransMaintMasterSecHolderEquitySecurity']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'limitedPartnership'], _first_across_rows(normalized_rows, ['notTransMaintMasterSecHolderLimitedPartnership']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'municipalDebt'], _first_across_rows(normalized_rows, ['notTransMaintMasterSecHolderMunicipalDebt']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'openEndInvestmentCompany'], _first_across_rows(normalized_rows, ['notTransMaintMasterSecHolderOpenEndInvestmentCompany']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'other'], _first_across_rows(normalized_rows, ['notTransMaintMasterSecHolderOther']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'priorAgent', 'amountIssues'], _first_across_rows(normalized_rows, ['priorAgentAmountIssues']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'priorAgent', 'numberIssues'], _first_across_rows(normalized_rows, ['priorAgentNumberIssues']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'purchaseRedemptionPricingShares', 'total'], _first_across_rows(normalized_rows, ['purchaseRedemptionPricingSharesTotal']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'purchaseRedemptionPricingShares', 'totalOtherThanReceiptOrderDate'], _first_across_rows(normalized_rows, ['purchaseRedemptionPricingSharesTotalOtherThanReceiptOrderDate']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'quarterlyReportsRegardingBuyIns', 'numberFiled'], _first_across_rows(normalized_rows, ['quarterlyReportsRegardingBuyInsNumberFiled']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'debtSecurity'], _first_across_rows(normalized_rows, ['transMaintainMasterSecHolderDebtSecurity']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'equitySecurity'], _first_across_rows(normalized_rows, ['transMaintainMasterSecHolderEquitySecurity']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'limitedPartnership'], _first_across_rows(normalized_rows, ['transMaintainMasterSecHolderLimitedPartnership']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'municipalDebt'], _first_across_rows(normalized_rows, ['transMaintainMasterSecHolderMunicipalDebt']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'openEndInvestmentCompany'], _first_across_rows(normalized_rows, ['transMaintainMasterSecHolderOpenEndInvestmentCompany']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'other'], _first_across_rows(normalized_rows, ['transMaintainMasterSecHolderOther']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'debtSecurity'], _first_across_rows(normalized_rows, ['transNotMaintMasterSecHolderDebtSecurity']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'equitySecurity'], _first_across_rows(normalized_rows, ['transNotMaintMasterSecHolderEquitySecurity']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'limitedPartnership'], _first_across_rows(normalized_rows, ['transNotMaintMasterSecHolderLimitedPartnership']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'municipalDebt'], _first_across_rows(normalized_rows, ['transNotMaintMasterSecHolderMunicipalDebt']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'openEndInvestmentCompany'], _first_across_rows(normalized_rows, ['transNotMaintMasterSecHolderOpenEndInvestmentCompany']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'other'], _first_across_rows(normalized_rows, ['transNotMaintMasterSecHolderOther']))
    _add_path_text(root, ['serviceCompanyData', 'securityHolderData', 'turnaroundCompliant', 'alwaysCompliant'], _first_across_rows(normalized_rows, ['turnaroundCompliantAlwaysCompliant']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'currentAgent', 'amountIssues'], _first_across_rows(normalized_rows, ['currentAgentAmountIssues']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'currentAgent', 'numberIssues'], _first_across_rows(normalized_rows, ['currentAgentNumberIssues']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'dividendAndInterest', 'amountIssues'], _first_across_rows(normalized_rows, ['securityHolderDataDividendAndInterestAmountIssues']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'dividendAndInterest', 'numberIssues'], _first_across_rows(normalized_rows, ['securityHolderDataDividendAndInterestNumberIssues']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'debtSecurity'], _first_across_rows(normalized_rows, ['securityHolderDataNotTransMaintMasterSecHolderDebtSecurity']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'equitySecurity'], _first_across_rows(normalized_rows, ['securityHolderDataNotTransMaintMasterSecHolderEquitySecurity']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'limitedPartnership'], _first_across_rows(normalized_rows, ['securityHolderDataNotTransMaintMasterSecHolderLimitedPartnership']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'municipalDebt'], _first_across_rows(normalized_rows, ['securityHolderDataNotTransMaintMasterSecHolderMunicipalDebt']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'openEndInvestmentCompany'], _first_across_rows(normalized_rows, ['securityHolderDataNotTransMaintMasterSecHolderOpenEndInvestmentCompany']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'notTransMaintMasterSecHolder', 'other'], _first_across_rows(normalized_rows, ['securityHolderDataNotTransMaintMasterSecHolderOther']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'priorAgent', 'amountIssues'], _first_across_rows(normalized_rows, ['securityHolderDataPriorAgentAmountIssues']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'priorAgent', 'numberIssues'], _first_across_rows(normalized_rows, ['securityHolderDataPriorAgentNumberIssues']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'debtSecurity'], _first_across_rows(normalized_rows, ['securityHolderDataTransMaintainMasterSecHolderDebtSecurity']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'equitySecurity'], _first_across_rows(normalized_rows, ['securityHolderDataTransMaintainMasterSecHolderEquitySecurity']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'limitedPartnership'], _first_across_rows(normalized_rows, ['securityHolderDataTransMaintainMasterSecHolderLimitedPartnership']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'municipalDebt'], _first_across_rows(normalized_rows, ['securityHolderDataTransMaintainMasterSecHolderMunicipalDebt']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'openEndInvestmentCompany'], _first_across_rows(normalized_rows, ['securityHolderDataTransMaintainMasterSecHolderOpenEndInvestmentCompany']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transMaintainMasterSecHolder', 'other'], _first_across_rows(normalized_rows, ['securityHolderDataTransMaintainMasterSecHolderOther']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'debtSecurity'], _first_across_rows(normalized_rows, ['securityHolderDataTransNotMaintMasterSecHolderDebtSecurity']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'equitySecurity'], _first_across_rows(normalized_rows, ['securityHolderDataTransNotMaintMasterSecHolderEquitySecurity']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'limitedPartnership'], _first_across_rows(normalized_rows, ['securityHolderDataTransNotMaintMasterSecHolderLimitedPartnership']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'municipalDebt'], _first_across_rows(normalized_rows, ['securityHolderDataTransNotMaintMasterSecHolderMunicipalDebt']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'openEndInvestmentCompany'], _first_across_rows(normalized_rows, ['securityHolderDataTransNotMaintMasterSecHolderOpenEndInvestmentCompany']))
    _add_path_text(root, ['formData', 'serviceCompanyData', 'securityHolderData', 'transNotMaintMasterSecHolder', 'other'], _first_across_rows(normalized_rows, ['securityHolderDataTransNotMaintMasterSecHolderOther']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'ccc'], _first_across_rows(normalized_rows, ['ccc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'cik'], _first_across_rows(normalized_rows, ['filerCredentialsCik']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')


