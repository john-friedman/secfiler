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

def construct_ex102(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element('assetData')
    root.set('xmlns', 'http://www.sec.gov/edgar/document/absee/autoloan/assetdata')
    root.set('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance')
    _add_path_text(root, ['assets', 'GroupID'], _first_across_rows(normalized_rows, ['groupId']))
    _add_path_text(root, ['assets', 'NumberProperties'], _first_across_rows(normalized_rows, ['numberProperties']))
    _add_path_text(root, ['assets', 'NumberPropertiesSecuritization'], _first_across_rows(normalized_rows, ['numberPropertiesSecuritization']))
    _add_path_text(root, ['assets', 'paymentTypeCode'], _first_across_rows(normalized_rows, ['paymentTypeCode']))
    _add_path_text(root, ['assets', 'deferredInterestCollectedAmount'], _first_across_rows(normalized_rows, ['deferredInterestCollectedAmount']))
    _add_path_text(root, ['assets', 'unscheduledPrincipalCollectedAmount'], _first_across_rows(normalized_rows, ['unscheduledPrincipalCollectedAmount']))
    _add_path_text(root, ['assets', 'armIndexRatePercentage'], _first_across_rows(normalized_rows, ['armIndexRatePercentage']))
    _add_path_text(root, ['assets', 'armMarginNumber'], _first_across_rows(normalized_rows, ['armMarginNumber']))
    _add_path_text(root, ['assets', 'assetAddedIndicator'], _first_across_rows(normalized_rows, ['assetAddedIndicator']))
    _add_path_text(root, ['assets', 'modifiedIndicator'], _first_across_rows(normalized_rows, ['modifiedIndicator']))
    _add_path_text(root, ['assets', 'assetNumber'], _first_across_rows(normalized_rows, ['assetNumber']))
    _add_path_text(root, ['assets', 'assetSubjectDemandIndicator'], _first_across_rows(normalized_rows, ['assetSubjectDemandIndicator']))
    _add_path_text(root, ['assets', 'assetTypeNumber'], _first_across_rows(normalized_rows, ['assetTypeNumber']))
    _add_path_text(root, ['assets', 'balloonIndicator'], _first_across_rows(normalized_rows, ['balloonIndicator']))
    _add_path_text(root, ['assets', 'originatorName'], _first_across_rows(normalized_rows, ['originatorName']))
    _add_path_text(root, ['assets', 'prepaymentPremiumsEndDate'], _first_across_rows(normalized_rows, ['prepaymentPremiumsEndDate']))
    _add_path_text(root, ['assets', 'deferredInterestCumulativeAmount'], _first_across_rows(normalized_rows, ['deferredInterestCumulativeAmount']))
    _add_path_text(root, ['assets', 'paidThroughDate'], _first_across_rows(normalized_rows, ['paidThroughDate']))
    _add_path_text(root, ['assets', 'originalTermLoanNumber'], _first_across_rows(normalized_rows, ['originalTermLoanNumber']))
    _add_path_text(root, ['assets', 'reportPeriodEndActualBalanceAmount'], _first_across_rows(normalized_rows, ['reportPeriodEndActualBalanceAmount']))
    _add_path_text(root, ['assets', 'reportPeriodEndScheduledLoanBalanceAmount'], _first_across_rows(normalized_rows, ['reportPeriodEndScheduledLoanBalanceAmount']))
    _add_path_text(root, ['assets', 'firstLoanPaymentDueDate'], _first_across_rows(normalized_rows, ['firstLoanPaymentDueDate']))
    _add_path_text(root, ['assets', 'graceDaysAllowedNumber'], _first_across_rows(normalized_rows, ['graceDaysAllowedNumber']))
    _add_path_text(root, ['assets', 'hyperAmortizingDate'], _first_across_rows(normalized_rows, ['hyperAmortizingDate']))
    _add_path_text(root, ['assets', 'indexLookbackDaysNumber'], _first_across_rows(normalized_rows, ['indexLookbackDaysNumber']))
    _add_path_text(root, ['assets', 'interestAccrualMethodCode'], _first_across_rows(normalized_rows, ['interestAccrualMethodCode']))
    _add_path_text(root, ['assets', 'interestOnlyIndicator'], _first_across_rows(normalized_rows, ['interestOnlyIndicator']))
    _add_path_text(root, ['assets', 'interestRateSecuritizationPercentage'], _first_across_rows(normalized_rows, ['interestRateSecuritizationPercentage']))
    _add_path_text(root, ['assets', 'originalInterestRateTypeCode'], _first_across_rows(normalized_rows, ['originalInterestRateTypeCode']))
    _add_path_text(root, ['assets', 'primaryServicerName'], _first_across_rows(normalized_rows, ['primaryServicerName']))
    _add_path_text(root, ['assets', 'lastModificationDate'], _first_across_rows(normalized_rows, ['lastModificationDate']))
    _add_path_text(root, ['assets', 'lienPositionSecuritizationCode'], _first_across_rows(normalized_rows, ['lienPositionSecuritizationCode']))
    _add_path_text(root, ['assets', 'lifetimeRateCapPercentage'], _first_across_rows(normalized_rows, ['lifetimeRateCapPercentage']))
    _add_path_text(root, ['assets', 'lifetimeRateFloorPercentage'], _first_across_rows(normalized_rows, ['lifetimeRateFloorPercentage']))
    _add_path_text(root, ['assets', 'liquidationPrepaymentCode'], _first_across_rows(normalized_rows, ['liquidationPrepaymentCode']))
    _add_path_text(root, ['assets', 'liquidationPrepaymentDate'], _first_across_rows(normalized_rows, ['liquidationPrepaymentDate']))
    _add_path_text(root, ['assets', 'loanStructureCode'], _first_across_rows(normalized_rows, ['loanStructureCode']))
    _add_path_text(root, ['assets', 'maturityDate'], _first_across_rows(normalized_rows, ['maturityDate']))
    _add_path_text(root, ['assets', 'maximumNegativeAmortizationAllowedAmount'], _first_across_rows(normalized_rows, ['maxNegAmortAmount']))
    _add_path_text(root, ['assets', 'maximumNegativeAmortizationAllowedPercentage'], _first_across_rows(normalized_rows, ['maxNegAmortPercentage']))
    _add_path_text(root, ['assets', 'modificationCode'], _first_across_rows(normalized_rows, ['modificationCode']))
    _add_path_text(root, ['assets', 'mostRecentMasterServicerReturnDate'], _first_across_rows(normalized_rows, ['mostRecentMasterServicerReturnDate']))
    _add_path_text(root, ['assets', 'mostRecentSpecialServicerTransferDate'], _first_across_rows(normalized_rows, ['mostRecentSpecialServicerTransferDate']))
    _add_path_text(root, ['assets', 'negativeAmortizationDeferredInterestCapAmount'], _first_across_rows(normalized_rows, ['negAmortDeferredInterestCapAmount']))
    _add_path_text(root, ['assets', 'negativeAmortizationIndicator'], _first_across_rows(normalized_rows, ['negativeAmortizationIndicator']))
    _add_path_text(root, ['assets', 'nextInterestRateChangeAdjustmentDate'], _first_across_rows(normalized_rows, ['nextInterestRateChangeAdjustmentDate']))
    _add_path_text(root, ['assets', 'nextInterestRatePercentage'], _first_across_rows(normalized_rows, ['nextInterestRatePercentage']))
    _add_path_text(root, ['assets', 'nonRecoverabilityIndicator'], _first_across_rows(normalized_rows, ['nonRecoverabilityIndicator']))
    _add_path_text(root, ['assets', 'originalAmortizationTermNumber'], _first_across_rows(normalized_rows, ['originalAmortizationTermNumber']))
    _add_path_text(root, ['assets', 'originalInterestOnlyTermNumber'], _first_across_rows(normalized_rows, ['originalInterestOnlyTermNumber']))
    _add_path_text(root, ['assets', 'originalInterestRatePercentage'], _first_across_rows(normalized_rows, ['originalInterestRatePercentage']))
    _add_path_text(root, ['assets', 'originationDate'], _first_across_rows(normalized_rows, ['originationDate']))
    _add_path_text(root, ['assets', 'originalLoanAmount'], _first_across_rows(normalized_rows, ['originalLoanAmount']))
    _add_path_text(root, ['assets', 'otherExpensesAdvancedOutstandingAmount'], _first_across_rows(normalized_rows, ['otherExpensesAdvancedOutstandingAmount']))
    _add_path_text(root, ['assets', 'otherInterestAdjustmentAmount'], _first_across_rows(normalized_rows, ['otherInterestAdjustmentAmount']))
    _add_path_text(root, ['assets', 'otherPrincipalAdjustmentAmount'], _first_across_rows(normalized_rows, ['otherPrincipalAdjustmentAmount']))
    _add_path_text(root, ['assets', 'paymentFrequencyCode'], _first_across_rows(normalized_rows, ['paymentFrequencyCode']))
    _add_path_text(root, ['assets', 'paymentStatusLoanCode'], _first_across_rows(normalized_rows, ['paymentStatusLoanCode']))
    _add_path_text(root, ['assets', 'periodicPaymentAdjustmentMaximumAmount'], _first_across_rows(normalized_rows, ['periodicPaymentAdjustmentMaximumAmount']))
    _add_path_text(root, ['assets', 'periodicPaymentAdjustmentMaximumPercent'], _first_across_rows(normalized_rows, ['periodicPaymentAdjustmentMaximumPercent']))
    _add_path_text(root, ['assets', 'periodicPrincipalAndInterestPaymentSecuritizationAmount'], _first_across_rows(normalized_rows, ['periodicPIPaymentSecuritizationAmount']))
    _add_path_text(root, ['assets', 'periodicRateDecreaseLimitPercentage'], _first_across_rows(normalized_rows, ['periodicRateDecreaseLimitPercentage']))
    _add_path_text(root, ['assets', 'periodicRateIncreaseLimitPercentage'], _first_across_rows(normalized_rows, ['periodicRateIncreaseLimitPercentage']))
    _add_path_text(root, ['assets', 'postModificationAmortizationPeriodAmount'], _first_across_rows(normalized_rows, ['postModificationAmortizationPeriodAmount']))
    _add_path_text(root, ['assets', 'postModificationInterestPercentage'], _first_across_rows(normalized_rows, ['postModificationInterestPercentage']))
    _add_path_text(root, ['assets', 'postModificationMaturityDate'], _first_across_rows(normalized_rows, ['postModificationMaturityDate']))
    _add_path_text(root, ['assets', 'postModificationPaymentAmount'], _first_across_rows(normalized_rows, ['postModificationPaymentAmount']))
    _add_path_text(root, ['assets', 'prepaymentLockOutEndDate'], _first_across_rows(normalized_rows, ['prepaymentLockOutEndDate']))
    _add_path_text(root, ['assets', 'prepaymentPremiumIndicator'], _first_across_rows(normalized_rows, ['prepaymentPremiumIndicator']))
    _add_path_text(root, ['assets', 'prepaymentPremiumYieldMaintenanceReceivedAmount'], _first_across_rows(normalized_rows, ['prepaymentPremiumYieldMaintenanceReceivedAmount']))
    _add_path_text(root, ['assets', 'realizedLossToTrustAmount'], _first_across_rows(normalized_rows, ['realizedLossToTrustAmount']))
    _add_path_text(root, ['assets', 'reportPeriodBeginningScheduleLoanBalanceAmount'], _first_across_rows(normalized_rows, ['reportPeriodBeginningScheduleLoanBalanceAmount']))
    _add_path_text(root, ['assets', 'reportingPeriodBeginningDate'], _first_across_rows(normalized_rows, ['reportingPeriodBeginningDate']))
    _add_path_text(root, ['assets', 'reportingPeriodEndDate'], _first_across_rows(normalized_rows, ['reportingPeriodEndDate']))
    _add_path_text(root, ['assets', 'reportPeriodInterestRatePercentage'], _first_across_rows(normalized_rows, ['reportPeriodInterestRatePercentage']))
    _add_path_text(root, ['assets', 'reportPeriodModificationIndicator'], _first_across_rows(normalized_rows, ['reportPeriodModificationIndicator']))
    _add_path_text(root, ['assets', 'repurchaseAmount'], _first_across_rows(normalized_rows, ['repurchaseAmount']))
    _add_path_text(root, ['assets', 'scheduledInterestAmount'], _first_across_rows(normalized_rows, ['scheduledInterestAmount']))
    _add_path_text(root, ['assets', 'scheduledPrincipalAmount'], _first_across_rows(normalized_rows, ['scheduledPrincipalAmount']))
    _add_path_text(root, ['assets', 'scheduledPrincipalBalanceSecuritizationAmount'], _first_across_rows(normalized_rows, ['scheduledPrincipalBalanceSecuritizationAmount']))
    _add_path_text(root, ['assets', 'servicerTrusteeFeeRatePercentage'], _first_across_rows(normalized_rows, ['servicerTrusteeFeeRatePercentage']))
    _add_path_text(root, ['assets', 'servicingAdvanceMethodCode'], _first_across_rows(normalized_rows, ['servicingAdvanceMethodCode']))
    _add_path_text(root, ['assets', 'totalScheduledPrincipalInterestDueAmount'], _first_across_rows(normalized_rows, ['totalScheduledPIAmount']))
    _add_path_text(root, ['assets', 'totalPrincipalInterestAdvancedOutstandingAmount'], _first_across_rows(normalized_rows, ['totalPIAdvancedOutstandingAmount']))
    _add_path_text(root, ['assets', 'totalTaxesInsuranceAdvancesOutstandingAmount'], _first_across_rows(normalized_rows, ['totalTaxesInsuranceAdvancesOutstandingAmount']))
    _add_path_text(root, ['assets', 'underwritingIndicator'], _first_across_rows(normalized_rows, ['underwritingIndicator']))
    _add_path_text(root, ['assets', 'workoutStrategyCode'], _first_across_rows(normalized_rows, ['workoutStrategyCode']))
    _add_path_text(root, ['assets', 'yieldMaintenanceEndDate'], _first_across_rows(normalized_rows, ['yieldMaintenanceEndDate']))
    _add_path_text(root, ['assets', 'property', 'DefeasedStatusCode'], _first_across_rows(normalized_rows, ['defeasedStatusCode']))
    _add_path_text(root, ['assets', 'property', 'debtServiceCoverageNetCashFlowSecuritizationPercentage'], _first_across_rows(normalized_rows, ['dscNetCashFlowSecuritizationPercentage']))
    _add_path_text(root, ['assets', 'property', 'debtServiceCoverageNetOperatingIncomeSecuritizationPercentage'], _first_across_rows(normalized_rows, ['dscNetOperatingIncomeSecuritizationPercentage']))
    _add_path_text(root, ['assets', 'property', 'debtServiceCoverageSecuritizationCode'], _first_across_rows(normalized_rows, ['debtServiceCoverageSecuritizationCode']))
    _add_path_text(root, ['assets', 'property', 'defeasanceOptionStartDate'], _first_across_rows(normalized_rows, ['defeasanceOptionStartDate']))
    _add_path_text(root, ['assets', 'property', 'financialsSecuritizationDate'], _first_across_rows(normalized_rows, ['financialsSecuritizationDate']))
    _add_path_text(root, ['assets', 'property', 'largestTenant'], _first_across_rows(normalized_rows, ['largestTenant']))
    _add_path_text(root, ['assets', 'property', 'leaseExpirationLargestTenantDate'], _first_across_rows(normalized_rows, ['leaseExpirationLargestTenantDate']))
    _add_path_text(root, ['assets', 'property', 'leaseExpirationSecondLargestTenantDate'], _first_across_rows(normalized_rows, ['leaseExpirationSecondLargestTenantDate']))
    _add_path_text(root, ['assets', 'property', 'leaseExpirationThirdLargestTenantDate'], _first_across_rows(normalized_rows, ['leaseExpirationThirdLargestTenantDate']))
    _add_path_text(root, ['assets', 'property', 'mostRecentAnnualLeaseRolloverReviewDate'], _first_across_rows(normalized_rows, ['mostRecentAnnualLeaseRolloverReviewDate']))
    _add_path_text(root, ['assets', 'property', 'mostRecentDebtServiceAmount'], _first_across_rows(normalized_rows, ['mostRecentDebtServiceAmount']))
    _add_path_text(root, ['assets', 'property', 'mostRecentDebtServiceCoverageCode'], _first_across_rows(normalized_rows, ['mostRecentDebtServiceCoverageCode']))
    _add_path_text(root, ['assets', 'property', 'mostRecentDebtServiceCoverageNetCashFlowpercentage'], _first_across_rows(normalized_rows, ['mostRecentDscNetCashFlowPercentage']))
    _add_path_text(root, ['assets', 'property', 'mostRecentDebtServiceCoverageNetOperatingIncomePercentage'], _first_across_rows(normalized_rows, ['mostRecentDscNetOperatingIncomePercentage']))
    _add_path_text(root, ['assets', 'property', 'mostRecentFinancialsEndDate'], _first_across_rows(normalized_rows, ['mostRecentFinancialsEndDate']))
    _add_path_text(root, ['assets', 'property', 'mostRecentFinancialsStartDate'], _first_across_rows(normalized_rows, ['mostRecentFinancialsStartDate']))
    _add_path_text(root, ['assets', 'property', 'mostRecentNetCashFlowAmount'], _first_across_rows(normalized_rows, ['mostRecentNetCashFlowAmount']))
    _add_path_text(root, ['assets', 'property', 'mostRecentNetOperatingIncomeAmount'], _first_across_rows(normalized_rows, ['mostRecentNetOperatingIncomeAmount']))
    _add_path_text(root, ['assets', 'property', 'mostRecentPhysicalOccupancyPercentage'], _first_across_rows(normalized_rows, ['mostRecentPhysicalOccupancyPercentage']))
    _add_path_text(root, ['assets', 'property', 'mostRecentRevenueAmount'], _first_across_rows(normalized_rows, ['mostRecentRevenueAmount']))
    _add_path_text(root, ['assets', 'property', 'mostRecentValuationAmount'], _first_across_rows(normalized_rows, ['mostRecentValuationAmount']))
    _add_path_text(root, ['assets', 'property', 'mostRecentValuationDate'], _first_across_rows(normalized_rows, ['mostRecentValuationDate']))
    _add_path_text(root, ['assets', 'property', 'mostRecentValuationSourceCode'], _first_across_rows(normalized_rows, ['mostRecentValuationSourceCode']))
    _add_path_text(root, ['assets', 'property', 'netCashFlowFlowSecuritizationAmount'], _first_across_rows(normalized_rows, ['netCashFlowSecuritizationAmount']))
    _add_path_text(root, ['assets', 'property', 'netOperatingIncomeNetCashFlowCode'], _first_across_rows(normalized_rows, ['netOperatingIncomeNetCashFlowCode']))
    _add_path_text(root, ['assets', 'property', 'netOperatingIncomeNetCashFlowSecuritizationCode'], _first_across_rows(normalized_rows, ['netOperatingIncomeNetCashFlowSecuritizationCode']))
    _add_path_text(root, ['assets', 'property', 'netOperatingIncomeSecuritizationAmount'], _first_across_rows(normalized_rows, ['netOperatingIncomeSecuritizationAmount']))
    _add_path_text(root, ['assets', 'property', 'netRentableSquareFeetNumber'], _first_across_rows(normalized_rows, ['netRentableSquareFeetNumber']))
    _add_path_text(root, ['assets', 'property', 'netRentableSquareFeetSecuritizationNumber'], _first_across_rows(normalized_rows, ['netRentableSquareFeetSecuritizationNumber']))
    _add_path_text(root, ['assets', 'property', 'operatingExpensesAmount'], _first_across_rows(normalized_rows, ['operatingExpensesAmount']))
    _add_path_text(root, ['assets', 'property', 'operatingExpensesSecuritizationAmount'], _first_across_rows(normalized_rows, ['operatingExpensesSecuritizationAmount']))
    _add_path_text(root, ['assets', 'property', 'physicalOccupancySecuritizationPercentage'], _first_across_rows(normalized_rows, ['physicalOccupancySecuritizationPercentage']))
    _add_path_text(root, ['assets', 'property', 'propertyAddress'], _first_across_rows(normalized_rows, ['propertyAddress']))
    _add_path_text(root, ['assets', 'property', 'propertyCity'], _first_across_rows(normalized_rows, ['propertyCity']))
    _add_path_text(root, ['assets', 'property', 'propertyCounty'], _first_across_rows(normalized_rows, ['propertyCounty']))
    _add_path_text(root, ['assets', 'property', 'propertyName'], _first_across_rows(normalized_rows, ['propertyName']))
    _add_path_text(root, ['assets', 'property', 'propertyState'], _first_across_rows(normalized_rows, ['propertyState']))
    _add_path_text(root, ['assets', 'property', 'propertyStatusCode'], _first_across_rows(normalized_rows, ['propertyStatusCode']))
    _add_path_text(root, ['assets', 'property', 'propertyTypeCode'], _first_across_rows(normalized_rows, ['propertyTypeCode']))
    _add_path_text(root, ['assets', 'property', 'propertyZip'], _first_across_rows(normalized_rows, ['propertyZip']))
    _add_path_text(root, ['assets', 'property', 'revenueSecuritizationAmount'], _first_across_rows(normalized_rows, ['revenueSecuritizationAmount']))
    _add_path_text(root, ['assets', 'property', 'secondLargestTenant'], _first_across_rows(normalized_rows, ['secondLargestTenant']))
    _add_path_text(root, ['assets', 'property', 'squareFeetLargestTenantNumber'], _first_across_rows(normalized_rows, ['squareFeetLargestTenantNumber']))
    _add_path_text(root, ['assets', 'property', 'squareFeetSecondLargestTenantNumber'], _first_across_rows(normalized_rows, ['squareFeetSecondLargestTenantNumber']))
    _add_path_text(root, ['assets', 'property', 'squareFeetThirdLargestTenantNumber'], _first_across_rows(normalized_rows, ['squareFeetThirdLargestTenantNumber']))
    _add_path_text(root, ['assets', 'property', 'thirdLargestTenant'], _first_across_rows(normalized_rows, ['thirdLargestTenant']))
    _add_path_text(root, ['assets', 'property', 'unitsBedsRoomsNumber'], _first_across_rows(normalized_rows, ['unitsBedsRoomsNumber']))
    _add_path_text(root, ['assets', 'property', 'unitsBedsRoomsSecuritizationNumber'], _first_across_rows(normalized_rows, ['unitsBedsRoomsSecuritizationNumber']))
    _add_path_text(root, ['assets', 'property', 'valuationSecuritizationAmount'], _first_across_rows(normalized_rows, ['valuationSecuritizationAmount']))
    _add_path_text(root, ['assets', 'property', 'valuationSecuritizationDate'], _first_across_rows(normalized_rows, ['valuationSecuritizationDate']))
    _add_path_text(root, ['assets', 'property', 'valuationSourceSecuritizationCode'], _first_across_rows(normalized_rows, ['valuationSourceSecuritizationCode']))
    _add_path_text(root, ['assets', 'property', 'yearBuiltNumber'], _first_across_rows(normalized_rows, ['yearBuiltNumber']))
    _add_path_text(root, ['assets', 'property', 'yearLastRenovated'], _first_across_rows(normalized_rows, ['yearLastRenovated']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')
