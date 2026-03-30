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

def construct_nmfp(rows: list) -> bytes:
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
    root.set('xmlns', 'http://www.sec.gov/edgar/nmfp')
    root.set('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')
    root.set('xmlns:dei', 'http://www.sec.gov/edgar/dei')
    root.set('xmlns:invest', 'http://www.sec.gov/edgar/invest')
    root.set('xmlns:part1', 'http://www.sec.gov/edgar/nmfpfund')
    root.set('xmlns:part2', 'http://www.sec.gov/edgar/nmfpsecurities')
    root.set('xmlns:ratings', 'http://www.sec.gov/edgar/ratings')
    root.set('xmlns:rr', 'http://www.sec.gov/edgar/rr')
    root.set('xmlns:sccom', 'http://www.sec.gov/edgar/sccommon')
    root.set('xmlns:state', 'http://www.sec.gov/edgar/statecodes')
    root.set('xmlns:us-gaap', 'http://www.sec.gov/edgar/us-gaap')
    _add_path_text(root, ['seriesLevelInformation', 'AvailableForSaleSecuritiesAmortizedCost'], _first_across_rows(normalized_rows, ['availableForSaleSecuritiesAmortizedCost']))
    _add_path_text(root, ['DocumentPeriodEndDate'], _first_across_rows(normalized_rows, ['documentPeriodEndDate']))
    _add_path_text(root, ['EntityCentralIndexKey'], _first_across_rows(normalized_rows, ['entityCentralIndexKey']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'InvestmentMaturityDate'], _first_across_rows(normalized_rows, ['investmentMaturityDate']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'InvestmentOwnedAtFairValue'], _first_across_rows(normalized_rows, ['investmentOwnedAtFairValue']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'InvestmentOwnedBalancePrincipalAmount'], _first_across_rows(normalized_rows, ['investmentOwnedBalancePrincipalAmount']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'InvestmentOwnedPercentOfNetAssets'], _first_across_rows(normalized_rows, ['investmentOwnedPercentOfNetAssets']))
    _add_path_text(root, ['totalClassesInSeries'], _first_across_rows(normalized_rows, ['totalClassesInSeries']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'doesSecurityHaveDemandFeature'], _first_across_rows(normalized_rows, ['doesSecurityHaveDemandFeature']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'doesSecurityHaveEnhancementsOnWhichFundRelying'], _first_across_rows(normalized_rows, ['doesSecurityHaveEnhancementsOnWhichFundRelying']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'finalLegalInvestmentMaturityDate'], _first_across_rows(normalized_rows, ['finalLegalInvestmentMaturityDate']))
    _add_path_text(root, ['hasFundAcquiredOrMergedWithAnotherFundSinceLastFiling'], _first_across_rows(normalized_rows, ['hasFundAcquiredOrMergedWithAnotherFundSinceLastFiling']))
    _add_path_text(root, ['isFundLiquidating'], _first_across_rows(normalized_rows, ['isFundLiquidating']))
    _add_path_text(root, ['isFundMergingWithOrBeingAcquiredByAnotherFund'], _first_across_rows(normalized_rows, ['isFundMergingWithOrBeingAcquiredByAnotherFund']))
    _add_path_text(root, ['isThisElectronicCopyOfPaperFormat'], _first_across_rows(normalized_rows, ['isThisElectronicCopyOfPaperFormat']))
    _add_path_text(root, ['isThisFinalFiling'], _first_across_rows(normalized_rows, ['isThisFinalFiling']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'isThisIlliquidSecurity'], _first_across_rows(normalized_rows, ['isThisIlliquidSecurity']))
    _add_path_text(root, ['liveTestFlag'], _first_across_rows(normalized_rows, ['liveTestFlag']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'rating'], _first_across_rows(normalized_rows, ['rating']))
    _add_path_text(root, ['seriesId'], _first_across_rows(normalized_rows, ['seriesId']))
    _add_path_text(root, ['submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'valueOfSecurityExcludingValueOfCapitalSupportAgreement'], _first_across_rows(normalized_rows, ['valueOfSecurityExcludingValueOfCapitalSupportAgreement']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'repurchaseAgreementList', 'RepurchaseAgreement', 'AssetsSoldUnderAgreementsToRepurchaseCarryingAmounts'], _first_across_rows(normalized_rows, ['assetsSoldUnderAgreementsToRepurchaseCarryingAmounts']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'repurchaseAgreementList', 'RepurchaseAgreement', 'CR'], _first_across_rows(normalized_rows, ['cR']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'repurchaseAgreementList', 'RepurchaseAgreement', 'CashCollateralForBorrowedSecurities'], _first_across_rows(normalized_rows, ['cashCollateralForBorrowedSecurities']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'repurchaseAgreementList', 'RepurchaseAgreement', 'InvestmentIssuer'], _first_across_rows(normalized_rows, ['repurchaseAgreementInvestmentIssuer']))
    _add_path_text(root, ['seriesLevelInformation', 'InvestmentTypeDomain'], _first_across_rows(normalized_rows, ['investmentTypeDomain']))
    _add_path_text(root, ['seriesLevelInformation', 'AssetsNet'], _first_across_rows(normalized_rows, ['assetsNet']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'CUSIPMember'], _first_across_rows(normalized_rows, ['cUSIPMember']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'InvestmentIssuer'], _first_across_rows(normalized_rows, ['investmentIssuer']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'InvestmentTitle'], _first_across_rows(normalized_rows, ['investmentTitle']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'doesSecurityHaveGuarantee'], _first_across_rows(normalized_rows, ['doesSecurityHaveGuarantee']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'isFundTreatingAsAcquisitionUnderlyingSecurities'], _first_across_rows(normalized_rows, ['isFundTreatingAsAcquisitionUnderlyingSecurities']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'AvailableForSaleSecuritiesAmortizedCost'], _first_across_rows(normalized_rows, ['scheduleOfPortfolioSecuritiesAvailableForSaleSecuritiesAmortizedCost']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'InvestmentTypeDomain'], _first_across_rows(normalized_rows, ['scheduleOfPortfolioSecuritiesInvestmentTypeDomain']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'guarantorList', 'guarantor', 'O'], _first_across_rows(normalized_rows, ['o']))
    _add_path_text(root, ['seriesLevelInformation', 'OtherAssets'], _first_across_rows(normalized_rows, ['otherAssets']))
    _add_path_text(root, ['seriesLevelInformation', 'ContainedFileInformationFileNumber'], _first_across_rows(normalized_rows, ['containedFileInformationFileNumber']))
    _add_path_text(root, ['seriesLevelInformation', 'Liabilities'], _first_across_rows(normalized_rows, ['liabilities']))
    _add_path_text(root, ['seriesLevelInformation', 'MoneyMarketSevenDayYield'], _first_across_rows(normalized_rows, ['moneyMarketSevenDayYield']))
    _add_path_text(root, ['seriesLevelInformation', 'dollarWeightedAverageLifeMaturity'], _first_across_rows(normalized_rows, ['dollarWeightedAverageLifeMaturity']))
    _add_path_text(root, ['seriesLevelInformation', 'dollarWeightedAveragePortfolioMaturity'], _first_across_rows(normalized_rows, ['dollarWeightedAveragePortfolioMaturity']))
    _add_path_text(root, ['seriesLevelInformation', 'isThisFeederFund'], _first_across_rows(normalized_rows, ['isThisFeederFund']))
    _add_path_text(root, ['seriesLevelInformation', 'isThisMasterFund'], _first_across_rows(normalized_rows, ['isThisMasterFund']))
    _add_path_text(root, ['seriesLevelInformation', 'isThisSeriesPrimarilyUsedToFundInsuranceCompanySeperateAccounts'], _first_across_rows(normalized_rows, ['isThisSeriesPrimarilyUsedToFundInsuranceCompanySeperateAccounts']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'repurchaseAgreementList', 'RepurchaseAgreement', 'InvestmentMaturityDate', 'date'], _first_across_rows(normalized_rows, ['date']))
    _add_path_text(root, ['seriesLevelInformation', 'feederFundList', 'feederFund', 'ContainedFileInformationFileNumber'], _first_across_rows(normalized_rows, ['feederFundContainedFileInformationFileNumber']))
    _add_path_text(root, ['seriesLevelInformation', 'feederFundList', 'feederFund', 'EntityCentralIndexKey'], _first_across_rows(normalized_rows, ['feederFundEntityCentralIndexKey']))
    _add_path_text(root, ['seriesLevelInformation', 'feederFundList', 'feederFund', 'seriesIdentifier'], _first_across_rows(normalized_rows, ['feederFundSeriesIdentifier']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'classId'], _first_across_rows(normalized_rows, ['classId']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'grossRedemptionsForMonthEnded'], _first_across_rows(normalized_rows, ['grossRedemptionsForMonthEnded']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'grossSubscriptionsForMonthEnded'], _first_across_rows(normalized_rows, ['grossSubscriptionsForMonthEnded']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'minInitialInvestment'], _first_across_rows(normalized_rows, ['minInitialInvestment']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'netAssetValuePerShare'], _first_across_rows(normalized_rows, ['netAssetValuePerShare']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'netAssetsOfClass'], _first_across_rows(normalized_rows, ['netAssetsOfClass']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'netShareholderFlowActivityForMonthEnded'], _first_across_rows(normalized_rows, ['netShareholderFlowActivityForMonthEnded']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'sevenDayNetYield'], _first_across_rows(normalized_rows, ['sevenDayNetYield']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'designatedNRSROList', 'designatedNRSRO', 'RAN'], _first_across_rows(normalized_rows, ['rAN']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'repurchaseAgreementList', 'RepurchaseAgreement', 'InvestmentTypeDomain'], _first_across_rows(normalized_rows, ['repurchaseAgreementInvestmentTypeDomain']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'categoryOfInvestmentDesc'], _first_across_rows(normalized_rows, ['categoryOfInvestmentDesc']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'EntityCentralIndexKey'], _first_across_rows(normalized_rows, ['scheduleOfPortfolioSecuritiesEntityCentralIndexKey']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'InvestmentIdentifier'], _first_across_rows(normalized_rows, ['investmentIdentifier']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'InvestmentOwnedInvestmentAdditionalInformation'], _first_across_rows(normalized_rows, ['investmentOwnedInvestmentAdditionalInformation']))
    _add_path_text(root, ['seriesLevelInformation', 'administratorList', 'administrator'], _first_across_rows(normalized_rows, ['administrator']))
    _add_path_text(root, ['seriesLevelInformation', 'independentPublicAccountant', 'city'], _first_across_rows(normalized_rows, ['city']))
    _add_path_text(root, ['seriesLevelInformation', 'independentPublicAccountant', 'name'], _first_across_rows(normalized_rows, ['name']))
    _add_path_text(root, ['seriesLevelInformation', 'independentPublicAccountant', 'state'], _first_across_rows(normalized_rows, ['state']))
    _add_path_text(root, ['seriesLevelInformation', 'seriesShadowPrice', 'dateCalculatedFornetValuePerShareExcludingCapitalSupportAgreement'], _first_across_rows(normalized_rows, ['dateCalculatedFornetValuePerShareExcludingCapitalSupportAgreement']))
    _add_path_text(root, ['seriesLevelInformation', 'seriesShadowPrice', 'dateCalculatedFornetValuePerShareIncludingCapitalSupportAgreement'], _first_across_rows(normalized_rows, ['dateCalculatedFornetValuePerShareIncludingCapitalSupportAgreement']))
    _add_path_text(root, ['seriesLevelInformation', 'seriesShadowPrice', 'netValuePerShareExcludingCapitalSupportAgreement'], _first_across_rows(normalized_rows, ['netValuePerShareExcludingCapitalSupportAgreement']))
    _add_path_text(root, ['seriesLevelInformation', 'seriesShadowPrice', 'netValuePerShareIncludingCapitalSupportAgreement'], _first_across_rows(normalized_rows, ['netValuePerShareIncludingCapitalSupportAgreement']))
    _add_path_text(root, ['seriesLevelInformation', 'masterFund', 'EntityCentralIndexKey'], _first_across_rows(normalized_rows, ['masterFundEntityCentralIndexKey']))
    _add_path_text(root, ['seriesLevelInformation', 'masterFund', 'EntityRegistrantName'], _first_across_rows(normalized_rows, ['entityRegistrantName']))
    _add_path_text(root, ['seriesLevelInformation', 'masterFund', 'seriesIdentifier'], _first_across_rows(normalized_rows, ['seriesIdentifier']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'classShadowPrice', 'netAssetValuePerShareExcludingCapitalSupportAgreement', 'dateAsOfWhichValueWasCalculated'], _first_across_rows(normalized_rows, ['dateAsOfWhichValueWasCalculated']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'classShadowPrice', 'netAssetValuePerShareExcludingCapitalSupportAgreement', 'value'], _first_across_rows(normalized_rows, ['value']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'demandFeatureIssuerList', 'demandFeatureIssuer', 'InvestmentIssuer'], _first_across_rows(normalized_rows, ['demandFeatureIssuerInvestmentIssuer']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'enhancementsList', 'enhancement', 'typeOfEnhancement'], _first_across_rows(normalized_rows, ['typeOfEnhancement']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'repurchaseAgreementList', 'RepurchaseAgreement', 'categoryOfInvestmentDesc'], _first_across_rows(normalized_rows, ['repurchaseAgreementCategoryOfInvestmentDesc']))
    _add_path_text(root, ['seriesLevelInformation', 'investmentAdviserList', 'adviser', 'adviserFileNumber'], _first_across_rows(normalized_rows, ['adviserFileNumber']))
    _add_path_text(root, ['seriesLevelInformation', 'investmentAdviserList', 'adviser', 'adviserName'], _first_across_rows(normalized_rows, ['adviserName']))
    _add_path_text(root, ['seriesLevelInformation', 'transferAgentList', 'transferAgent', 'EntityCentralIndexKey'], _first_across_rows(normalized_rows, ['transferAgentEntityCentralIndexKey']))
    _add_path_text(root, ['seriesLevelInformation', 'transferAgentList', 'transferAgent', 'fileNumber'], _first_across_rows(normalized_rows, ['fileNumber']))
    _add_path_text(root, ['seriesLevelInformation', 'transferAgentList', 'transferAgent', 'name'], _first_across_rows(normalized_rows, ['transferAgentName']))
    _add_path_text(root, ['seriesLevelInformation', 'feederFundList', 'feederFund', 'EntityRegistrantName'], _first_across_rows(normalized_rows, ['feederFundEntityRegistrantName']))
    _add_path_text(root, ['seriesLevelInformation', 'subAdviserList', 'subAdviser', 'adviserFileNumber'], _first_across_rows(normalized_rows, ['subAdviserAdviserFileNumber']))
    _add_path_text(root, ['seriesLevelInformation', 'subAdviserList', 'subAdviser', 'adviserName'], _first_across_rows(normalized_rows, ['subAdviserAdviserName']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'classShadowPrice', 'netAssetValuePerShareIncludingCapitalSupportAgreement', 'dateAsOfWhichValueWasCalculated'], _first_across_rows(normalized_rows, ['netAssetValuePerShareIncludingCapitalSupportAgreementDateAsOfWhichValueWasCalculated']))
    _add_path_text(root, ['classLevelInformationList', 'classLevelInformation', 'classShadowPrice', 'netAssetValuePerShareIncludingCapitalSupportAgreement', 'value'], _first_across_rows(normalized_rows, ['netAssetValuePerShareIncludingCapitalSupportAgreementValue']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'designatedNRSROList', 'designatedNRSRO', 'R'], _first_across_rows(normalized_rows, ['r']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'demandFeatureIssuerList', 'demandFeatureIssuer', 'NRSRORatingList', 'NRSROSRating', 'RAN'], _first_across_rows(normalized_rows, ['nRSROSRatingRAN']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'guarantorList', 'guarantor', 'NRSRORatingList', 'NRSRORating', 'RAN'], _first_across_rows(normalized_rows, ['nRSRORatingRAN']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'enhancementsList', 'enhancement', 'enhancementProviderList', 'Provider', 'enhancementProvider'], _first_across_rows(normalized_rows, ['enhancementProvider']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'demandFeatureIssuerList', 'demandFeatureIssuer', 'NRSRORatingList', 'NRSROSRating', 'R'], _first_across_rows(normalized_rows, ['nRSROSRatingR']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'guarantorList', 'guarantor', 'NRSRORatingList', 'NRSRORating', 'R'], _first_across_rows(normalized_rows, ['nRSRORatingR']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'repurchaseAgreementList', 'RepurchaseAgreement', 'InvestmentMaturityDate', 'dateRange', 'from'], _first_across_rows(normalized_rows, ['from']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'repurchaseAgreementList', 'RepurchaseAgreement', 'InvestmentMaturityDate', 'dateRange', 'to'], _first_across_rows(normalized_rows, ['to']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'enhancementsList', 'enhancement', 'enhancementProviderList', 'Provider', 'NRSRORatingList', 'NRSRORating', 'RAN'], _first_across_rows(normalized_rows, ['nRSRORatingListNRSRORatingRAN']))
    _add_path_text(root, ['scheduleOfPortfolioSecuritiesList', 'scheduleOfPortfolioSecurities', 'enhancementsList', 'enhancement', 'enhancementProviderList', 'Provider', 'NRSRORatingList', 'NRSRORating', 'R'], _first_across_rows(normalized_rows, ['nRSRORatingListNRSRORatingR']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')


