import io
import xml.etree.ElementTree as ET

from ..utils import _add_created_with_comment, _add_path_text


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



