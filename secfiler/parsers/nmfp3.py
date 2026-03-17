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

def construct_nmfp3(rows: list) -> bytes:
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
    root.set('xmlns', 'http://www.sec.gov/edgar/nmfp3')
    root.set('xmlns:ns3', 'http://www.sec.gov/edgar/nmfp3common')
    root.set('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance')
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'classFullName'], _first_across_rows(normalized_rows, ['classFullName']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'classesId'], _first_across_rows(normalized_rows, ['classesId']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'minInitialInvestment'], _first_across_rows(normalized_rows, ['minInitialInvestment']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'nameOfPersonDescExpensePay'], _first_across_rows(normalized_rows, ['nameOfPersonDescExpensePay']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'netAssetsOfClass'], _first_across_rows(normalized_rows, ['netAssetsOfClass']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'numberOfSharesOutstanding'], _first_across_rows(normalized_rows, ['numberOfSharesOutstanding']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'otherInvestorTypeDescription'], _first_across_rows(normalized_rows, ['otherInvestorTypeDescription']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompBrokerDealer'], _first_across_rows(normalized_rows, ['percentShareHolderCompBrokerDealer']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompDepositoryInst'], _first_across_rows(normalized_rows, ['percentShareHolderCompDepositoryInst']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompInsurance'], _first_across_rows(normalized_rows, ['percentShareHolderCompInsurance']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompMunicipal'], _first_across_rows(normalized_rows, ['percentShareHolderCompMunicipal']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompNonFinancialCorp'], _first_across_rows(normalized_rows, ['percentShareHolderCompNonFinancialCorp']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompNonProfit'], _first_across_rows(normalized_rows, ['percentShareHolderCompNonProfit']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompOther'], _first_across_rows(normalized_rows, ['percentShareHolderCompOther']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompPensionPlan'], _first_across_rows(normalized_rows, ['percentShareHolderCompPensionPlan']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompPrivateFunds'], _first_across_rows(normalized_rows, ['percentShareHolderCompPrivateFunds']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompRegInvestment'], _first_across_rows(normalized_rows, ['percentShareHolderCompRegInvestment']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'percentShareHolderCompSovereignFund'], _first_across_rows(normalized_rows, ['percentShareHolderCompSovereignFund']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'personPayForFundFlag'], _first_across_rows(normalized_rows, ['personPayForFundFlag']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'shareCancellationReportingPeriod'], _first_across_rows(normalized_rows, ['shareCancellationReportingPeriod']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'assetBackedCommercialPaperAmt'], _first_across_rows(normalized_rows, ['assetBackedCommercialPaperAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'certificateDepositAmt'], _first_across_rows(normalized_rows, ['certificateDepositAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'depositionUSTreasuryDebtAmt'], _first_across_rows(normalized_rows, ['depositionUSTreasuryDebtAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'financialCompanyCommercialAmt'], _first_across_rows(normalized_rows, ['financialCompanyCommercialAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'govtAgencyCouponPayingDebtAmt'], _first_across_rows(normalized_rows, ['govtAgencyCouponPayingDebtAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'govtAgencyNonCouponPayingDebtAmt'], _first_across_rows(normalized_rows, ['govtAgencyNonCouponPayingDebtAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'insuranceCompanyFundAgreementAmt'], _first_across_rows(normalized_rows, ['insuranceCompanyFundAgreementAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'investmentCompanyAmt'], _first_across_rows(normalized_rows, ['investmentCompanyAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'nonFinancialCompanyCommercialAmt'], _first_across_rows(normalized_rows, ['nonFinancialCompanyCommercialAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'nonNegotiableTimeDepositAmt'], _first_across_rows(normalized_rows, ['nonNegotiableTimeDepositAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'nonUSSovereignSupraNationalDebtAmt'], _first_across_rows(normalized_rows, ['nonUSSovereignSupraNationalDebtAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'otherAssetBackedSecuritiesAmt'], _first_across_rows(normalized_rows, ['otherAssetBackedSecuritiesAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'otherInstrumentAmt'], _first_across_rows(normalized_rows, ['otherInstrumentAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'otherInstrumentBriefDescription'], _first_across_rows(normalized_rows, ['otherInstrumentBriefDescription']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'otherMunicipalSecurityAmt'], _first_across_rows(normalized_rows, ['otherMunicipalSecurityAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'otherRepurchaseAgreementAmt'], _first_across_rows(normalized_rows, ['otherRepurchaseAgreementAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'tenderOptionBondAmt'], _first_across_rows(normalized_rows, ['tenderOptionBondAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'usGovtAgencyRepurchaseAgreementAmt'], _first_across_rows(normalized_rows, ['usGovtAgencyRepurchaseAgreementAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'usTreasuryRepurchaseAgreementAmt'], _first_across_rows(normalized_rows, ['usTreasuryRepurchaseAgreementAmt']))
    _add_path_text(root, ['formData', 'dispositionOfPortfolioSecurities', 'variableRateDemandNoteAmt'], _first_across_rows(normalized_rows, ['variableRateDemandNoteAmt']))
    _add_path_text(root, ['formData', 'generalInfo', 'cik'], _first_across_rows(normalized_rows, ['cik']))
    _add_path_text(root, ['formData', 'generalInfo', 'finalFilingFlag'], _first_across_rows(normalized_rows, ['finalFilingFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'fundAcqrdOrMrgdWthAnthrFlag'], _first_across_rows(normalized_rows, ['fundAcqrdOrMrgdWthAnthrFlag']))
    _add_path_text(root, ['formData', 'generalInfo', 'leiOfSeries'], _first_across_rows(normalized_rows, ['leiOfSeries']))
    _add_path_text(root, ['formData', 'generalInfo', 'nameOfSeries'], _first_across_rows(normalized_rows, ['nameOfSeries']))
    _add_path_text(root, ['formData', 'generalInfo', 'registrantFullName'], _first_across_rows(normalized_rows, ['registrantFullName']))
    _add_path_text(root, ['formData', 'generalInfo', 'registrantLEIId'], _first_across_rows(normalized_rows, ['registrantLEIId']))
    _add_path_text(root, ['formData', 'generalInfo', 'reportDate'], _first_across_rows(normalized_rows, ['reportDate']))
    _add_path_text(root, ['formData', 'generalInfo', 'seriesId'], _first_across_rows(normalized_rows, ['seriesId']))
    _add_path_text(root, ['formData', 'generalInfo', 'totalShareClassesInSeries'], _first_across_rows(normalized_rows, ['totalShareClassesInSeries']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'CUSIPMember'], _first_across_rows(normalized_rows, ['cUSIPMember']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'ISINId'], _first_across_rows(normalized_rows, ['iSINId']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'LEIID'], _first_across_rows(normalized_rows, ['lEIID']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'briefDescription'], _first_across_rows(normalized_rows, ['briefDescription']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'cik'], _first_across_rows(normalized_rows, ['scheduleOfPortfolioSecuritiesInfoCik']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'coupon'], _first_across_rows(normalized_rows, ['coupon']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'dailyLiquidAssetSecurityFlag'], _first_across_rows(normalized_rows, ['dailyLiquidAssetSecurityFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'excludingValueOfAnySponsorSupport'], _first_across_rows(normalized_rows, ['excludingValueOfAnySponsorSupport']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'explanatoryNotes'], _first_across_rows(normalized_rows, ['explanatoryNotes']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'finalLegalInvestmentMaturityDate'], _first_across_rows(normalized_rows, ['finalLegalInvestmentMaturityDate']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'fundAcqstnUndrlyngSecurityFlag'], _first_across_rows(normalized_rows, ['fundAcqstnUndrlyngSecurityFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'illiquidSecurityFlag'], _first_across_rows(normalized_rows, ['illiquidSecurityFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'includingValueOfAnySponsorSupport'], _first_across_rows(normalized_rows, ['includingValueOfAnySponsorSupport']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'investmentCategory'], _first_across_rows(normalized_rows, ['investmentCategory']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'investmentMaturityDateWAL'], _first_across_rows(normalized_rows, ['investmentMaturityDateWAL']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'investmentMaturityDateWAM'], _first_across_rows(normalized_rows, ['investmentMaturityDateWAM']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'nameOfIssuer'], _first_across_rows(normalized_rows, ['nameOfIssuer']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'otherUniqueId'], _first_across_rows(normalized_rows, ['otherUniqueId']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'percentageOfMoneyMarketFundNetAssets'], _first_across_rows(normalized_rows, ['percentageOfMoneyMarketFundNetAssets']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'securityCategorizedAtLevel3Flag'], _first_across_rows(normalized_rows, ['securityCategorizedAtLevel3Flag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'securityDemandFeatureFlag'], _first_across_rows(normalized_rows, ['securityDemandFeatureFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'securityEligibilityFlag'], _first_across_rows(normalized_rows, ['securityEligibilityFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'securityEnhancementsFlag'], _first_across_rows(normalized_rows, ['securityEnhancementsFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'securityGuaranteeFlag'], _first_across_rows(normalized_rows, ['securityGuaranteeFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'titleOfIssuer'], _first_across_rows(normalized_rows, ['titleOfIssuer']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'weeklyLiquidAssetSecurityFlag'], _first_across_rows(normalized_rows, ['weeklyLiquidAssetSecurityFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'yieldOfTheSecurityAsOfReportingDate'], _first_across_rows(normalized_rows, ['yieldOfTheSecurityAsOfReportingDate']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'amortizedCostPortfolioSecurities'], _first_across_rows(normalized_rows, ['amortizedCostPortfolioSecurities']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'averageLifeMaturity'], _first_across_rows(normalized_rows, ['averageLifeMaturity']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'averagePortfolioMaturity'], _first_across_rows(normalized_rows, ['averagePortfolioMaturity']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'cash'], _first_across_rows(normalized_rows, ['cash']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'cashMgmtVehicleAffliatedFundFlag'], _first_across_rows(normalized_rows, ['cashMgmtVehicleAffliatedFundFlag']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'feederFundFlag'], _first_across_rows(normalized_rows, ['feederFundFlag']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'fundRetailMoneyMarketFlag'], _first_across_rows(normalized_rows, ['fundRetailMoneyMarketFlag']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'govMoneyMrktFundFlag'], _first_across_rows(normalized_rows, ['govMoneyMrktFundFlag']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'liquidityFeeFundApplyFlag'], _first_across_rows(normalized_rows, ['liquidityFeeFundApplyFlag']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'masterFundFlag'], _first_across_rows(normalized_rows, ['masterFundFlag']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'moneyMarketFundCategory'], _first_across_rows(normalized_rows, ['moneyMarketFundCategory']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'netAssetOfSeries'], _first_across_rows(normalized_rows, ['netAssetOfSeries']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'numberOfSharesOutstanding'], _first_across_rows(normalized_rows, ['seriesLevelInfoNumberOfSharesOutstanding']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'securitiesActFileNumber'], _first_across_rows(normalized_rows, ['securitiesActFileNumber']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'seekStablePricePerShare'], _first_across_rows(normalized_rows, ['seekStablePricePerShare']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'seriesFundInsuCmpnySepAccntFlag'], _first_across_rows(normalized_rows, ['seriesFundInsuCmpnySepAccntFlag']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'stablePricePerShare'], _first_across_rows(normalized_rows, ['stablePricePerShare']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'totalValueLiabilities'], _first_across_rows(normalized_rows, ['totalValueLiabilities']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'totalValueOtherAssets'], _first_across_rows(normalized_rows, ['totalValueOtherAssets']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'totalValuePortfolioSecurities'], _first_across_rows(normalized_rows, ['totalValuePortfolioSecurities']))
    _add_path_text(root, ['formData', 'signature', 'nameOfSigningOfficer'], _first_across_rows(normalized_rows, ['nameOfSigningOfficer']))
    _add_path_text(root, ['formData', 'signature', 'registrant'], _first_across_rows(normalized_rows, ['registrant']))
    _add_path_text(root, ['formData', 'signature', 'signature'], _first_across_rows(normalized_rows, ['signature']))
    _add_path_text(root, ['formData', 'signature', 'signatureDate'], _first_across_rows(normalized_rows, ['signatureDate']))
    _add_path_text(root, ['formData', 'signature', 'titleOfSigningOfficer'], _first_across_rows(normalized_rows, ['titleOfSigningOfficer']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'beneficialRecordOwnerCategory', 'beneficialRecordOwnerCategoryType'], _first_across_rows(normalized_rows, ['beneficialRecordOwnerCategoryType']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'beneficialRecordOwnerCategory', 'otherInvestorCategory'], _first_across_rows(normalized_rows, ['otherInvestorCategory']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'beneficialRecordOwnerCategory', 'percentOutstandingSharesBeneficial'], _first_across_rows(normalized_rows, ['percentOutstandingSharesBeneficial']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'beneficialRecordOwnerCategory', 'percentOutstandingSharesRecord'], _first_across_rows(normalized_rows, ['percentOutstandingSharesRecord']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'dialyShareholderFlowReported', 'dailyShareHolderFlowDate'], _first_across_rows(normalized_rows, ['dailyShareHolderFlowDate']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'dailyNetAssetValuePerShareClass', 'dailyNetAssetValuePerShareClass'], _first_across_rows(normalized_rows, ['dailyNetAssetValuePerShareClass']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'dailyNetAssetValuePerShareClass', 'dailyNetAssetValuePerShareDateClass'], _first_across_rows(normalized_rows, ['dailyNetAssetValuePerShareDateClass']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'dialyShareholderFlowReported', 'dailyGrossRedemptions'], _first_across_rows(normalized_rows, ['dailyGrossRedemptions']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'dialyShareholderFlowReported', 'dailyGrossSubscriptions'], _first_across_rows(normalized_rows, ['dailyGrossSubscriptions']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'monthlyShareholderFlowReported', 'totalGrossRedemptions'], _first_across_rows(normalized_rows, ['totalGrossRedemptions']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'monthlyShareholderFlowReported', 'totalGrossSubscriptions'], _first_across_rows(normalized_rows, ['totalGrossSubscriptions']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'sevenDayNetYield', 'sevenDayNetYieldDate'], _first_across_rows(normalized_rows, ['sevenDayNetYieldDate']))
    _add_path_text(root, ['formData', 'classLevelInfo', 'sevenDayNetYield', 'sevenDayNetYieldValue'], _first_across_rows(normalized_rows, ['sevenDayNetYieldValue']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'feederFund', 'cik'], _first_across_rows(normalized_rows, ['feederFundCik']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'feederFund', 'fileNumber'], _first_across_rows(normalized_rows, ['fileNumber']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'feederFund', 'seriesId'], _first_across_rows(normalized_rows, ['feederFundSeriesId']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'assigningNRSRORating', 'nameOfNRSRO'], _first_across_rows(normalized_rows, ['nameOfNRSRO']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'assigningNRSRORating', 'rating'], _first_across_rows(normalized_rows, ['rating']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'demandFeature', 'amountProvidedByDemandFeatureIssuer'], _first_across_rows(normalized_rows, ['amountProvidedByDemandFeatureIssuer']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'demandFeature', 'demandFeatureConditionalFlag'], _first_across_rows(normalized_rows, ['demandFeatureConditionalFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'demandFeature', 'identityOfDemandFeatureIssuer'], _first_across_rows(normalized_rows, ['identityOfDemandFeatureIssuer']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'demandFeature', 'remainingPeriodDemandFeature'], _first_across_rows(normalized_rows, ['remainingPeriodDemandFeature']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'enhancementProvider', 'amountProvidedByEnhancement'], _first_across_rows(normalized_rows, ['amountProvidedByEnhancement']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'enhancementProvider', 'identityOfTheEnhancementProvider'], _first_across_rows(normalized_rows, ['identityOfTheEnhancementProvider']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'enhancementProvider', 'typeOfEnhancement'], _first_across_rows(normalized_rows, ['typeOfEnhancement']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'guarantor', 'amountProvidedByGuarantor'], _first_across_rows(normalized_rows, ['amountProvidedByGuarantor']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'guarantor', 'identityOfTheGuarantor'], _first_across_rows(normalized_rows, ['identityOfTheGuarantor']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'nameOfCCP'], _first_across_rows(normalized_rows, ['nameOfCCP']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'repurchaseAgreementClearedFlag'], _first_across_rows(normalized_rows, ['repurchaseAgreementClearedFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'repurchaseAgreementOpenFlag'], _first_across_rows(normalized_rows, ['repurchaseAgreementOpenFlag']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'repurchaseAgreementTripartyFlag'], _first_across_rows(normalized_rows, ['repurchaseAgreementTripartyFlag']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'administrator', 'administratorName'], _first_across_rows(normalized_rows, ['administratorName']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'adviser', 'adviserFileNumber'], _first_across_rows(normalized_rows, ['adviserFileNumber']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'adviser', 'adviserName'], _first_across_rows(normalized_rows, ['adviserName']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'dailyNetAssetValuePerShareSeries', 'dailyNetAssetValuePerShareDateSeries'], _first_across_rows(normalized_rows, ['dailyNetAssetValuePerShareDateSeries']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'dailyNetAssetValuePerShareSeries', 'dailyNetAssetValuePerShareSeries'], _first_across_rows(normalized_rows, ['dailyNetAssetValuePerShareSeries']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'feederFund', 'name'], _first_across_rows(normalized_rows, ['name']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'indpPubAccountant', 'city'], _first_across_rows(normalized_rows, ['city']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'indpPubAccountant', 'name'], _first_across_rows(normalized_rows, ['indpPubAccountantName']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'indpPubAccountant', 'stateCountry'], _first_across_rows(normalized_rows, ['stateCountry']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'liquidAssetsDetails', 'percentageDailyLiquidAssets'], _first_across_rows(normalized_rows, ['percentageDailyLiquidAssets']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'liquidAssetsDetails', 'percentageWeeklyLiquidAssets'], _first_across_rows(normalized_rows, ['percentageWeeklyLiquidAssets']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'liquidAssetsDetails', 'totalLiquidAssetsNearPercentDate'], _first_across_rows(normalized_rows, ['totalLiquidAssetsNearPercentDate']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'liquidAssetsDetails', 'totalValueDailyLiquidAssets'], _first_across_rows(normalized_rows, ['totalValueDailyLiquidAssets']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'liquidAssetsDetails', 'totalValueWeeklyLiquidAssets'], _first_across_rows(normalized_rows, ['totalValueWeeklyLiquidAssets']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'masterFeederFund', 'cik'], _first_across_rows(normalized_rows, ['masterFeederFundCik']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'masterFeederFund', 'name'], _first_across_rows(normalized_rows, ['masterFeederFundName']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'masterFeederFund', 'seriesId'], _first_across_rows(normalized_rows, ['masterFeederFundSeriesId']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'sevenDayGrossYield', 'sevenDayGrossYieldDate'], _first_across_rows(normalized_rows, ['sevenDayGrossYieldDate']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'sevenDayGrossYield', 'sevenDayGrossYieldValue'], _first_across_rows(normalized_rows, ['sevenDayGrossYieldValue']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'subAdviser', 'adviserFileNumber'], _first_across_rows(normalized_rows, ['subAdviserAdviserFileNumber']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'subAdviser', 'adviserName'], _first_across_rows(normalized_rows, ['subAdviserAdviserName']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'transferAgent', 'cik'], _first_across_rows(normalized_rows, ['transferAgentCik']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'transferAgent', 'fileNumber'], _first_across_rows(normalized_rows, ['transferAgentFileNumber']))
    _add_path_text(root, ['formData', 'seriesLevelInfo', 'transferAgent', 'name'], _first_across_rows(normalized_rows, ['transferAgentName']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'demandFeature', 'demandFeatureRatingOrNRSRO', 'nameOfNRSRO'], _first_across_rows(normalized_rows, ['demandFeatureRatingOrNRSRONameOfNRSRO']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'demandFeature', 'demandFeatureRatingOrNRSRO', 'rating'], _first_across_rows(normalized_rows, ['demandFeatureRatingOrNRSRORating']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'enhancementProvider', 'enhancementRatingOrNRSRO', 'nameOfNRSRO'], _first_across_rows(normalized_rows, ['enhancementRatingOrNRSRONameOfNRSRO']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'enhancementProvider', 'enhancementRatingOrNRSRO', 'rating'], _first_across_rows(normalized_rows, ['enhancementRatingOrNRSRORating']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'guarantor', 'guarantorRatingOrNRSRO', 'nameOfNRSRO'], _first_across_rows(normalized_rows, ['guarantorRatingOrNRSRONameOfNRSRO']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'guarantor', 'guarantorRatingOrNRSRO', 'rating'], _first_across_rows(normalized_rows, ['guarantorRatingOrNRSRORating']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'CUSIPMember'], _first_across_rows(normalized_rows, ['collateralIssuersCUSIPMember']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'LEIID'], _first_across_rows(normalized_rows, ['collateralIssuersLEIID']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'coupon'], _first_across_rows(normalized_rows, ['collateralIssuersCoupon']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'ctgryInvestmentsRprsntsCollateral'], _first_across_rows(normalized_rows, ['ctgryInvestmentsRprsntsCollateral']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'nameOfCollateralIssuer'], _first_across_rows(normalized_rows, ['nameOfCollateralIssuer']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'principalAmountToTheNearestCent'], _first_across_rows(normalized_rows, ['principalAmountToTheNearestCent']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'valueOfCollateralToTheNearestCent'], _first_across_rows(normalized_rows, ['valueOfCollateralToTheNearestCent']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'yield'], _first_across_rows(normalized_rows, ['yield']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'ccc'], _first_across_rows(normalized_rows, ['ccc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'cik'], _first_across_rows(normalized_rows, ['filerCredentialsCik']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'maturityDate', 'date'], _first_across_rows(normalized_rows, ['date']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'maturityDate', 'dateRange', 'from'], _first_across_rows(normalized_rows, ['from']))
    _add_path_text(root, ['formData', 'scheduleOfPortfolioSecuritiesInfo', 'repurchaseAgreement', 'collateralIssuers', 'maturityDate', 'dateRange', 'to'], _first_across_rows(normalized_rows, ['to']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')
