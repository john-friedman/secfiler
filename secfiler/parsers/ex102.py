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


def construct_ex103(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element('comments')
    _add_created_with_comment(root)

    for row in normalized_rows:
        comment_data = ET.SubElement(root, 'commentData')
        for json_key, xml_tag in [
            ('itemNumber', 'itemNumber'),
            ('columnName', 'columnName'),
            ('comment', 'Comment'),
            ('fieldName', 'fieldName'),
            ('commentColumn', 'commentColumn'),
            ('commentDescription', 'commentDescription'),
            ('commentNumber', 'commentNumber'),
        ]:
            value = row.get(json_key)
            if _is_present(value):
                child = ET.SubElement(comment_data, xml_tag)
                child.text = _to_text(value)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')


# (json_key, xml_tags relative to the assets element)
_EX102_ASSET_FIELDS = [
    ('groupId', ['GroupID']),
    ('numberProperties', ['NumberProperties']),
    ('numberPropertiesSecuritization', ['NumberPropertiesSecuritization']),
    ('paymentTypeCode', ['paymentTypeCode']),
    ('deferredInterestCollectedAmount', ['deferredInterestCollectedAmount']),
    ('unscheduledPrincipalCollectedAmount', ['unscheduledPrincipalCollectedAmount']),
    ('armIndexRatePercentage', ['armIndexRatePercentage']),
    ('armMarginNumber', ['armMarginNumber']),
    ('assetAddedIndicator', ['assetAddedIndicator']),
    ('modifiedIndicator', ['modifiedIndicator']),
    ('assetNumber', ['assetNumber']),
    ('assetSubjectDemandIndicator', ['assetSubjectDemandIndicator']),
    ('assetTypeNumber', ['assetTypeNumber']),
    ('balloonIndicator', ['balloonIndicator']),
    ('originatorName', ['originatorName']),
    ('prepaymentPremiumsEndDate', ['prepaymentPremiumsEndDate']),
    ('deferredInterestCumulativeAmount', ['deferredInterestCumulativeAmount']),
    ('paidThroughDate', ['paidThroughDate']),
    ('originalTermLoanNumber', ['originalTermLoanNumber']),
    ('reportPeriodEndActualBalanceAmount', ['reportPeriodEndActualBalanceAmount']),
    ('reportPeriodEndScheduledLoanBalanceAmount', ['reportPeriodEndScheduledLoanBalanceAmount']),
    ('firstLoanPaymentDueDate', ['firstLoanPaymentDueDate']),
    ('graceDaysAllowedNumber', ['graceDaysAllowedNumber']),
    ('hyperAmortizingDate', ['hyperAmortizingDate']),
    ('indexLookbackDaysNumber', ['indexLookbackDaysNumber']),
    ('interestAccrualMethodCode', ['interestAccrualMethodCode']),
    ('interestOnlyIndicator', ['interestOnlyIndicator']),
    ('interestRateSecuritizationPercentage', ['interestRateSecuritizationPercentage']),
    ('originalInterestRateTypeCode', ['originalInterestRateTypeCode']),
    ('primaryServicerName', ['primaryServicerName']),
    ('lastModificationDate', ['lastModificationDate']),
    ('lienPositionSecuritizationCode', ['lienPositionSecuritizationCode']),
    ('lifetimeRateCapPercentage', ['lifetimeRateCapPercentage']),
    ('lifetimeRateFloorPercentage', ['lifetimeRateFloorPercentage']),
    ('liquidationPrepaymentCode', ['liquidationPrepaymentCode']),
    ('liquidationPrepaymentDate', ['liquidationPrepaymentDate']),
    ('loanStructureCode', ['loanStructureCode']),
    ('maturityDate', ['maturityDate']),
    ('maxNegAmortAmount', ['maximumNegativeAmortizationAllowedAmount']),
    ('maxNegAmortPercentage', ['maximumNegativeAmortizationAllowedPercentage']),
    ('modificationCode', ['modificationCode']),
    ('mostRecentMasterServicerReturnDate', ['mostRecentMasterServicerReturnDate']),
    ('mostRecentSpecialServicerTransferDate', ['mostRecentSpecialServicerTransferDate']),
    ('negAmortDeferredInterestCapAmount', ['negativeAmortizationDeferredInterestCapAmount']),
    ('negativeAmortizationIndicator', ['negativeAmortizationIndicator']),
    ('nextInterestRateChangeAdjustmentDate', ['nextInterestRateChangeAdjustmentDate']),
    ('nextInterestRatePercentage', ['nextInterestRatePercentage']),
    ('nonRecoverabilityIndicator', ['nonRecoverabilityIndicator']),
    ('originalAmortizationTermNumber', ['originalAmortizationTermNumber']),
    ('originalInterestOnlyTermNumber', ['originalInterestOnlyTermNumber']),
    ('originalInterestRatePercentage', ['originalInterestRatePercentage']),
    ('originationDate', ['originationDate']),
    ('originalLoanAmount', ['originalLoanAmount']),
    ('otherExpensesAdvancedOutstandingAmount', ['otherExpensesAdvancedOutstandingAmount']),
    ('otherInterestAdjustmentAmount', ['otherInterestAdjustmentAmount']),
    ('otherPrincipalAdjustmentAmount', ['otherPrincipalAdjustmentAmount']),
    ('paymentFrequencyCode', ['paymentFrequencyCode']),
    ('paymentStatusLoanCode', ['paymentStatusLoanCode']),
    ('periodicPaymentAdjustmentMaximumAmount', ['periodicPaymentAdjustmentMaximumAmount']),
    ('periodicPaymentAdjustmentMaximumPercent', ['periodicPaymentAdjustmentMaximumPercent']),
    ('periodicPIPaymentSecuritizationAmount', ['periodicPrincipalAndInterestPaymentSecuritizationAmount']),
    ('periodicRateDecreaseLimitPercentage', ['periodicRateDecreaseLimitPercentage']),
    ('periodicRateIncreaseLimitPercentage', ['periodicRateIncreaseLimitPercentage']),
    ('postModificationAmortizationPeriodAmount', ['postModificationAmortizationPeriodAmount']),
    ('postModificationInterestPercentage', ['postModificationInterestPercentage']),
    ('postModificationMaturityDate', ['postModificationMaturityDate']),
    ('postModificationPaymentAmount', ['postModificationPaymentAmount']),
    ('prepaymentLockOutEndDate', ['prepaymentLockOutEndDate']),
    ('prepaymentPremiumIndicator', ['prepaymentPremiumIndicator']),
    ('prepaymentPremiumYieldMaintenanceReceivedAmount', ['prepaymentPremiumYieldMaintenanceReceivedAmount']),
    ('realizedLossToTrustAmount', ['realizedLossToTrustAmount']),
    ('reportPeriodBeginningScheduleLoanBalanceAmount', ['reportPeriodBeginningScheduleLoanBalanceAmount']),
    ('reportingPeriodBeginningDate', ['reportingPeriodBeginningDate']),
    ('reportingPeriodEndDate', ['reportingPeriodEndDate']),
    ('reportPeriodInterestRatePercentage', ['reportPeriodInterestRatePercentage']),
    ('reportPeriodModificationIndicator', ['reportPeriodModificationIndicator']),
    ('repurchaseAmount', ['repurchaseAmount']),
    ('scheduledInterestAmount', ['scheduledInterestAmount']),
    ('scheduledPrincipalAmount', ['scheduledPrincipalAmount']),
    ('scheduledPrincipalBalanceSecuritizationAmount', ['scheduledPrincipalBalanceSecuritizationAmount']),
    ('servicerTrusteeFeeRatePercentage', ['servicerTrusteeFeeRatePercentage']),
    ('servicingAdvanceMethodCode', ['servicingAdvanceMethodCode']),
    ('totalScheduledPIAmount', ['totalScheduledPrincipalInterestDueAmount']),
    ('totalPIAdvancedOutstandingAmount', ['totalPrincipalInterestAdvancedOutstandingAmount']),
    ('totalTaxesInsuranceAdvancesOutstandingAmount', ['totalTaxesInsuranceAdvancesOutstandingAmount']),
    ('underwritingIndicator', ['underwritingIndicator']),
    ('workoutStrategyCode', ['workoutStrategyCode']),
    ('yieldMaintenanceEndDate', ['yieldMaintenanceEndDate']),
]

_EX102_PROPERTY_FIELDS = [
    ('defeasedStatusCode', ['property', 'DefeasedStatusCode']),
    ('dscNetCashFlowSecuritizationPercentage', ['property', 'debtServiceCoverageNetCashFlowSecuritizationPercentage']),
    ('dscNetOperatingIncomeSecuritizationPercentage', ['property', 'debtServiceCoverageNetOperatingIncomeSecuritizationPercentage']),
    ('debtServiceCoverageSecuritizationCode', ['property', 'debtServiceCoverageSecuritizationCode']),
    ('defeasanceOptionStartDate', ['property', 'defeasanceOptionStartDate']),
    ('financialsSecuritizationDate', ['property', 'financialsSecuritizationDate']),
    ('largestTenant', ['property', 'largestTenant']),
    ('leaseExpirationLargestTenantDate', ['property', 'leaseExpirationLargestTenantDate']),
    ('leaseExpirationSecondLargestTenantDate', ['property', 'leaseExpirationSecondLargestTenantDate']),
    ('leaseExpirationThirdLargestTenantDate', ['property', 'leaseExpirationThirdLargestTenantDate']),
    ('mostRecentAnnualLeaseRolloverReviewDate', ['property', 'mostRecentAnnualLeaseRolloverReviewDate']),
    ('mostRecentDebtServiceAmount', ['property', 'mostRecentDebtServiceAmount']),
    ('mostRecentDebtServiceCoverageCode', ['property', 'mostRecentDebtServiceCoverageCode']),
    ('mostRecentDscNetCashFlowPercentage', ['property', 'mostRecentDebtServiceCoverageNetCashFlowpercentage']),
    ('mostRecentDscNetOperatingIncomePercentage', ['property', 'mostRecentDebtServiceCoverageNetOperatingIncomePercentage']),
    ('mostRecentFinancialsEndDate', ['property', 'mostRecentFinancialsEndDate']),
    ('mostRecentFinancialsStartDate', ['property', 'mostRecentFinancialsStartDate']),
    ('mostRecentNetCashFlowAmount', ['property', 'mostRecentNetCashFlowAmount']),
    ('mostRecentNetOperatingIncomeAmount', ['property', 'mostRecentNetOperatingIncomeAmount']),
    ('mostRecentPhysicalOccupancyPercentage', ['property', 'mostRecentPhysicalOccupancyPercentage']),
    ('mostRecentRevenueAmount', ['property', 'mostRecentRevenueAmount']),
    ('mostRecentValuationAmount', ['property', 'mostRecentValuationAmount']),
    ('mostRecentValuationDate', ['property', 'mostRecentValuationDate']),
    ('mostRecentValuationSourceCode', ['property', 'mostRecentValuationSourceCode']),
    ('netCashFlowSecuritizationAmount', ['property', 'netCashFlowFlowSecuritizationAmount']),
    ('netOperatingIncomeNetCashFlowCode', ['property', 'netOperatingIncomeNetCashFlowCode']),
    ('netOperatingIncomeNetCashFlowSecuritizationCode', ['property', 'netOperatingIncomeNetCashFlowSecuritizationCode']),
    ('netOperatingIncomeSecuritizationAmount', ['property', 'netOperatingIncomeSecuritizationAmount']),
    ('netRentableSquareFeetNumber', ['property', 'netRentableSquareFeetNumber']),
    ('netRentableSquareFeetSecuritizationNumber', ['property', 'netRentableSquareFeetSecuritizationNumber']),
    ('operatingExpensesAmount', ['property', 'operatingExpensesAmount']),
    ('operatingExpensesSecuritizationAmount', ['property', 'operatingExpensesSecuritizationAmount']),
    ('physicalOccupancySecuritizationPercentage', ['property', 'physicalOccupancySecuritizationPercentage']),
    ('propertyAddress', ['property', 'propertyAddress']),
    ('propertyCity', ['property', 'propertyCity']),
    ('propertyCounty', ['property', 'propertyCounty']),
    ('propertyName', ['property', 'propertyName']),
    ('propertyState', ['property', 'propertyState']),
    ('propertyStatusCode', ['property', 'propertyStatusCode']),
    ('propertyTypeCode', ['property', 'propertyTypeCode']),
    ('propertyZip', ['property', 'propertyZip']),
    ('revenueSecuritizationAmount', ['property', 'revenueSecuritizationAmount']),
    ('secondLargestTenant', ['property', 'secondLargestTenant']),
    ('squareFeetLargestTenantNumber', ['property', 'squareFeetLargestTenantNumber']),
    ('squareFeetSecondLargestTenantNumber', ['property', 'squareFeetSecondLargestTenantNumber']),
    ('squareFeetThirdLargestTenantNumber', ['property', 'squareFeetThirdLargestTenantNumber']),
    ('thirdLargestTenant', ['property', 'thirdLargestTenant']),
    ('unitsBedsRoomsNumber', ['property', 'unitsBedsRoomsNumber']),
    ('unitsBedsRoomsSecuritizationNumber', ['property', 'unitsBedsRoomsSecuritizationNumber']),
    ('valuationSecuritizationAmount', ['property', 'valuationSecuritizationAmount']),
    ('valuationSecuritizationDate', ['property', 'valuationSecuritizationDate']),
    ('valuationSourceSecuritizationCode', ['property', 'valuationSourceSecuritizationCode']),
    ('yearBuiltNumber', ['property', 'yearBuiltNumber']),
    ('yearLastRenovated', ['property', 'yearLastRenovated']),
]


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
    _add_created_with_comment(root)

    for row in normalized_rows:
        assets_el = ET.SubElement(root, 'assets')
        for json_key, xml_tags in _EX102_ASSET_FIELDS:
            value = row.get(json_key)
            if _is_present(value):
                _add_path_text(assets_el, xml_tags, value)
        for json_key, xml_tags in _EX102_PROPERTY_FIELDS:
            value = row.get(json_key)
            if _is_present(value):
                _add_path_text(assets_el, xml_tags, value)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')