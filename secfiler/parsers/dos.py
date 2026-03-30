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




def _add_repeated_child(parent: ET.Element, tag: str, values: list[str]) -> None:
    seen = set()
    for value in values:
        if not _is_present(value):
            continue
        text = _to_text(value)
        if text in seen:
            continue
        seen.add(text)
        ET.SubElement(parent, tag).text = text


def construct_dos(rows: list) -> bytes:
    normalized_rows = []
    if rows:
        for row in rows:
            if isinstance(row, dict) or hasattr(row, "get"):
                normalized_rows.append(row)
            else:
                normalized_rows.append(dict(row))
    else:
        normalized_rows = [{}]

    root = ET.Element("edgarSubmission")
    root.set("xmlns", "http://www.sec.gov/edgar/rega/oneafiler")
    root.set("xmlns:com", "http://www.sec.gov/edgar/common")
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], _first_across_rows(normalized_rows, ['liveTestFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], _first_across_rows(normalized_rows, ['returnCopyFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], _first_across_rows(normalized_rows, ['overrideInternetFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'sinceLastFiling'], _first_across_rows(normalized_rows, ['sinceLastFiling']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'issuerCredentials', 'cik'], _first_across_rows(normalized_rows, ['filerCik']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'issuerCredentials', 'ccc'], _first_across_rows(normalized_rows, ['filerCcc']))
    _add_path_text(root, ['formData', 'employeesInfo', 'cik'], _first_across_rows(normalized_rows, ['cik']))
    _add_path_text(root, ['formData', 'employeesInfo', 'issuerName'], _first_across_rows(normalized_rows, ['issuerName']))
    _add_path_text(root, ['formData', 'employeesInfo', 'irsNum'], _first_across_rows(normalized_rows, ['irsNum']))
    _add_path_text(root, ['formData', 'employeesInfo', 'sicCode'], _first_across_rows(normalized_rows, ['sicCode']))
    _add_path_text(root, ['formData', 'employeesInfo', 'jurisdictionOrganization'], _first_across_rows(normalized_rows, ['jurisdictionOrganization']))
    _add_path_text(root, ['formData', 'employeesInfo', 'yearIncorporation'], _first_across_rows(normalized_rows, ['yearIncorporation']))
    _add_path_text(root, ['formData', 'employeesInfo', 'fullTimeEmployees'], _first_across_rows(normalized_rows, ['fullTimeEmployees']))
    _add_path_text(root, ['formData', 'employeesInfo', 'partTimeEmployees'], _first_across_rows(normalized_rows, ['partTimeEmployees']))
    _add_path_text(root, ['formData', 'issuerInfo', 'connectionName'], _first_across_rows(normalized_rows, ['connectionName']))
    _add_path_text(root, ['formData', 'issuerInfo', 'street1'], _first_across_rows(normalized_rows, ['street1']))
    _add_path_text(root, ['formData', 'issuerInfo', 'street2'], _first_across_rows(normalized_rows, ['street2']))
    _add_path_text(root, ['formData', 'issuerInfo', 'city'], _first_across_rows(normalized_rows, ['city']))
    _add_path_text(root, ['formData', 'issuerInfo', 'stateOrCountry'], _first_across_rows(normalized_rows, ['stateOrCountry']))
    _add_path_text(root, ['formData', 'issuerInfo', 'zipCode'], _first_across_rows(normalized_rows, ['zipCode']))
    _add_path_text(root, ['formData', 'issuerInfo', 'phoneNumber'], _first_across_rows(normalized_rows, ['phoneNumber']))
    _add_path_text(root, ['formData', 'issuerInfo', 'industryGroup'], _first_across_rows(normalized_rows, ['industryGroup']))
    _add_path_text(root, ['formData', 'issuerInfo', 'nameAuditor'], _first_across_rows(normalized_rows, ['nameAuditor']))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalAssets'], _first_across_rows(normalized_rows, ['totalAssets']))
    _add_path_text(root, ['formData', 'issuerInfo', 'cashEquivalents'], _first_across_rows(normalized_rows, ['cashEquivalents']))
    _add_path_text(root, ['formData', 'issuerInfo', 'accountsReceivable'], _first_across_rows(normalized_rows, ['accountsReceivable']))
    _add_path_text(root, ['formData', 'issuerInfo', 'investmentSecurities'], _first_across_rows(normalized_rows, ['investmentSecurities']))
    _add_path_text(root, ['formData', 'issuerInfo', 'propertyPlantEquipment'], _first_across_rows(normalized_rows, ['propertyPlantEquipment']))
    _add_path_text(root, ['formData', 'issuerInfo', 'propertyAndEquipment'], _first_across_rows(normalized_rows, ['propertyAndEquipment']))
    _add_path_text(root, ['formData', 'issuerInfo', 'deposits'], _first_across_rows(normalized_rows, ['deposits']))
    _add_path_text(root, ['formData', 'issuerInfo', 'accountsPayable'], _first_across_rows(normalized_rows, ['accountsPayable']))
    _add_path_text(root, ['formData', 'issuerInfo', 'longTermDebt'], _first_across_rows(normalized_rows, ['longTermDebt']))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalLiabilities'], _first_across_rows(normalized_rows, ['totalLiabilities']))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalStockholderEquity'], _first_across_rows(normalized_rows, ['totalStockholderEquity']))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalLiabilitiesAndEquity'], _first_across_rows(normalized_rows, ['totalLiabilitiesAndEquity']))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalRevenues'], _first_across_rows(normalized_rows, ['totalRevenues']))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalInterestIncome'], _first_across_rows(normalized_rows, ['totalInterestIncome']))
    _add_path_text(root, ['formData', 'issuerInfo', 'costAndExpensesApplToRevenues'], _first_across_rows(normalized_rows, ['costAndExpensesApplToRevenues']))
    _add_path_text(root, ['formData', 'issuerInfo', 'totalInterestExpenses'], _first_across_rows(normalized_rows, ['totalInterestExpenses']))
    _add_path_text(root, ['formData', 'issuerInfo', 'depreciationAndAmortization'], _first_across_rows(normalized_rows, ['depreciationAndAmortization']))
    _add_path_text(root, ['formData', 'issuerInfo', 'netIncome'], _first_across_rows(normalized_rows, ['netIncome']))
    _add_path_text(root, ['formData', 'issuerInfo', 'earningsPerShareBasic'], _first_across_rows(normalized_rows, ['earningsPerShareBasic']))
    _add_path_text(root, ['formData', 'issuerInfo', 'earningsPerShareDiluted'], _first_across_rows(normalized_rows, ['earningsPerShareDiluted']))
    _add_path_text(root, ['formData', 'issuerInfo', 'loans'], _first_across_rows(normalized_rows, ['loans']))
    _add_path_text(root, ['formData', 'commonEquity', 'commonEquityClassName'], _first_across_rows(normalized_rows, ['commonEquityClassName']))
    _add_path_text(root, ['formData', 'commonEquity', 'outstandingCommonEquity'], _first_across_rows(normalized_rows, ['outstandingCommonEquity']))
    _add_path_text(root, ['formData', 'commonEquity', 'publiclyTradedCommonEquity'], _first_across_rows(normalized_rows, ['publiclyTradedCommonEquity']))
    _add_path_text(root, ['formData', 'commonEquity', 'commonCusipEquity'], _first_across_rows(normalized_rows, ['commonCusipEquity']))
    _add_path_text(root, ['formData', 'preferredEquity', 'preferredEquityClassName'], _first_across_rows(normalized_rows, ['preferredEquityClassName']))
    _add_path_text(root, ['formData', 'preferredEquity', 'outstandingPreferredEquity'], _first_across_rows(normalized_rows, ['outstandingPreferredEquity']))
    _add_path_text(root, ['formData', 'preferredEquity', 'publiclyTradedPreferredEquity'], _first_across_rows(normalized_rows, ['publiclyTradedPreferredEquity']))
    _add_path_text(root, ['formData', 'preferredEquity', 'preferredCusipEquity'], _first_across_rows(normalized_rows, ['preferredCusipEquity']))
    _add_path_text(root, ['formData', 'debtSecurities', 'debtSecuritiesClassName'], _first_across_rows(normalized_rows, ['debtSecuritiesClassName']))
    _add_path_text(root, ['formData', 'debtSecurities', 'outstandingDebtSecurities'], _first_across_rows(normalized_rows, ['outstandingDebtSecurities']))
    _add_path_text(root, ['formData', 'debtSecurities', 'publiclyTradedDebtSecurities'], _first_across_rows(normalized_rows, ['publiclyTradedDebtSecurities']))
    _add_path_text(root, ['formData', 'debtSecurities', 'cusipDebtSecurities'], _first_across_rows(normalized_rows, ['cusipDebtSecurities']))
    _add_path_text(root, ['formData', 'securitiesIssued', 'securitiesIssuerName'], _first_across_rows(normalized_rows, ['securitiesIssuerName']))
    _add_path_text(root, ['formData', 'securitiesIssued', 'securitiesIssuerTitle'], _first_across_rows(normalized_rows, ['securitiesIssuerTitle']))
    _add_path_text(root, ['formData', 'securitiesIssued', 'securitiesIssuedAggregateAmount'], _first_across_rows(normalized_rows, ['securitiesIssuedAggregateAmount']))
    _add_path_text(root, ['formData', 'securitiesIssued', 'securitiesIssuedTotalAmount'], _first_across_rows(normalized_rows, ['securitiesIssuedTotalAmount']))
    _add_path_text(root, ['formData', 'securitiesIssued', 'securitiesPrincipalHolderAmount'], _first_across_rows(normalized_rows, ['securitiesPrincipalHolderAmount']))
    _add_path_text(root, ['formData', 'securitiesIssued', 'aggregateConsiderationBasis'], _first_across_rows(normalized_rows, ['aggregateConsiderationBasis']))
    _add_path_text(root, ['formData', 'unregisteredSecurities', 'ifUnregsiteredNone'], _first_across_rows(normalized_rows, ['ifUnregisteredNone']))
    _add_path_text(root, ['formData', 'unregisteredSecuritiesAct', 'securitiesActExcemption'], _first_across_rows(normalized_rows, ['securitiesActExemption']))
    _add_path_text(root, ['formData', 'juridictionSecuritiesOffered', 'jurisdictionsOfSecOfferedSame'], _first_across_rows(normalized_rows, ['jurisdictionsOfSecOfferedSame']))
    _add_path_text(root, ['formData', 'juridictionSecuritiesOffered', 'jurisdictionsOfSecOfferedNone'], _first_across_rows(normalized_rows, ['jurisdictionsOfSecOfferedNone']))
    _add_path_text(root, ['formData', 'summaryInfo', 'securitiesOffered'], _first_across_rows(normalized_rows, ['securitiesOffered']))
    _add_path_text(root, ['formData', 'summaryInfo', 'securitiesOfferedTypes'], _first_across_rows(normalized_rows, ['securitiesOfferedTypes']))
    _add_path_text(root, ['formData', 'summaryInfo', 'securitiesOfferedOtherDesc'], _first_across_rows(normalized_rows, ['securitiesOfferedOtherDesc']))
    _add_path_text(root, ['formData', 'summaryInfo', 'outstandingSecurities'], _first_across_rows(normalized_rows, ['outstandingSecurities']))
    _add_path_text(root, ['formData', 'summaryInfo', 'pricePerSecurity'], _first_across_rows(normalized_rows, ['pricePerSecurity']))
    _add_path_text(root, ['formData', 'summaryInfo', 'totalAggregateOffering'], _first_across_rows(normalized_rows, ['totalAggregateOffering']))
    _add_path_text(root, ['formData', 'summaryInfo', 'issuerAggregateOffering'], _first_across_rows(normalized_rows, ['issuerAggregateOffering']))
    _add_path_text(root, ['formData', 'summaryInfo', 'securityHolderAggegate'], _first_across_rows(normalized_rows, ['securityHolderAggregate']))
    _add_path_text(root, ['formData', 'summaryInfo', 'concurrentOfferingAggregate'], _first_across_rows(normalized_rows, ['concurrentOfferingAggregate']))
    _add_path_text(root, ['formData', 'summaryInfo', 'qualificationOfferingAggregate'], _first_across_rows(normalized_rows, ['qualificationOfferingAggregate']))
    _add_path_text(root, ['formData', 'summaryInfo', 'estimatedNetAmount'], _first_across_rows(normalized_rows, ['estimatedNetAmount']))
    _add_path_text(root, ['formData', 'summaryInfo', 'indicateTier1Tier2Offering'], _first_across_rows(normalized_rows, ['indicateTier1Tier2Offering']))
    _add_path_text(root, ['formData', 'summaryInfo', 'offeringYearFlag'], _first_across_rows(normalized_rows, ['offeringYearFlag']))
    _add_path_text(root, ['formData', 'summaryInfo', 'offeringAfterQualifFlag'], _first_across_rows(normalized_rows, ['offeringAfterQualifFlag']))
    _add_path_text(root, ['formData', 'summaryInfo', 'offerDelayedContinuousFlag'], _first_across_rows(normalized_rows, ['offerDelayedContinuousFlag']))
    _add_path_text(root, ['formData', 'summaryInfo', 'offeringBestEffortsFlag'], _first_across_rows(normalized_rows, ['offeringBestEffortsFlag']))
    _add_path_text(root, ['formData', 'summaryInfo', 'resaleSecuritiesAffiliatesFlag'], _first_across_rows(normalized_rows, ['resaleSecuritiesAffiliatesFlag']))
    _add_path_text(root, ['formData', 'summaryInfo', 'solicitationProposedOfferingFlag'], _first_across_rows(normalized_rows, ['solicitationProposedOfferingFlag']))
    _add_path_text(root, ['formData', 'summaryInfo', 'financialStatementAuditStatus'], _first_across_rows(normalized_rows, ['financialStatementAuditStatus']))
    _add_path_text(root, ['formData', 'summaryInfo', 'legalFees'], _first_across_rows(normalized_rows, ['legalFees']))
    _add_path_text(root, ['formData', 'summaryInfo', 'legalServiceProviderName'], _first_across_rows(normalized_rows, ['legalServiceProviderName']))
    _add_path_text(root, ['formData', 'summaryInfo', 'auditorFees'], _first_across_rows(normalized_rows, ['auditorFees']))
    _add_path_text(root, ['formData', 'summaryInfo', 'auditorServiceProviderName'], _first_across_rows(normalized_rows, ['auditorServiceProviderName']))
    _add_path_text(root, ['formData', 'summaryInfo', 'blueSkyFees'], _first_across_rows(normalized_rows, ['blueSkyFees']))
    _add_path_text(root, ['formData', 'summaryInfo', 'blueSkyServiceProviderName'], _first_across_rows(normalized_rows, ['blueSkyServiceProviderName']))
    _add_path_text(root, ['formData', 'summaryInfo', 'promotersFees'], _first_across_rows(normalized_rows, ['promotersFees']))
    _add_path_text(root, ['formData', 'summaryInfo', 'promotersServiceProviderName'], _first_across_rows(normalized_rows, ['promotersServiceProviderName']))
    _add_path_text(root, ['formData', 'summaryInfo', 'salesCommissionsServiceProviderName'], _first_across_rows(normalized_rows, ['salesCommissionsServiceProviderName']))
    _add_path_text(root, ['formData', 'summaryInfo', 'salesCommissionsServiceProviderFees'], _first_across_rows(normalized_rows, ['salesCommissionsServiceProviderFees']))
    _add_path_text(root, ['formData', 'summaryInfo', 'underwritersServiceProviderName'], _first_across_rows(normalized_rows, ['underwritersServiceProviderName']))
    _add_path_text(root, ['formData', 'summaryInfo', 'underwritersFees'], _first_across_rows(normalized_rows, ['underwritersFees']))
    _add_path_text(root, ['formData', 'summaryInfo', 'finderFeesFee'], _first_across_rows(normalized_rows, ['finderFeesFee']))
    _add_path_text(root, ['formData', 'summaryInfo', 'findersFeesServiceProviderName'], _first_across_rows(normalized_rows, ['findersFeesServiceProviderName']))
    _add_path_text(root, ['formData', 'summaryInfo', 'brokerDealerCrdNumber'], _first_across_rows(normalized_rows, ['brokerDealerCrdNumber']))
    _add_path_text(root, ['formData', 'summaryInfo', 'clarificationResponses'], _first_across_rows(normalized_rows, ['clarificationResponses']))
    _add_path_text(root, ['formData', 'issuerEligibility', 'certifyIfTrue'], _first_across_rows(normalized_rows, ['certifyIfTrue']))
    _add_path_text(root, ['formData', 'applicationRule262', 'certifyIfNotDisqualified'], _first_across_rows(normalized_rows, ['certifyIfNotDisqualified']))
    _add_path_text(root, ['formData', 'applicationRule262', 'certifyIfBadActor'], _first_across_rows(normalized_rows, ['certifyIfBadActor']))

    _juris_parent = _ensure_path(root, ["formData", "juridictionSecuritiesOffered"])
    _issue_vals = _normalize_values(_first_across_rows(normalized_rows, ["issueJurisdictionSecuritiesOffering", "issueJurisdiction"]))
    _add_repeated_child(_juris_parent, "issueJuridicationSecuritiesOffering", _issue_vals)
    _dealer_vals = _normalize_values(_first_across_rows(normalized_rows, ["dealersJurisdictionSecuritiesOffering", "dealersJurisdiction"]))
    _add_repeated_child(_juris_parent, "dealersJuridicationSecuritiesOffering", _dealer_vals)
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="	")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)
    return output.getvalue().encode("utf-8")


