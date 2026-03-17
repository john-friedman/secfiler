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


def _normalize_values(value, split_commas: bool = False) -> list[str]:
    if value is None:
        return []

    if isinstance(value, (list, tuple, set)):
        items = []
        for item in value:
            items.extend(_normalize_values(item, split_commas=split_commas))
        return items

    text = _to_text(value).strip()
    if not text:
        return []

    if split_commas:
        normalized = text.replace("\r", "\n").replace(";", ",").replace("|", ",")
        return [item.strip() for item in normalized.split(",") if item.strip()]

    if any(marker in text for marker in ("|", ";", "\n", "\r")):
        normalized = text.replace("\r", "\n").replace("|", "\n").replace(";", "\n")
        return [item.strip() for item in normalized.split("\n") if item.strip()]

    return [text]


def _first_in_row(row: dict, aliases: list[str]):
    for alias in aliases:
        value = row.get(alias)
        if _is_present(value):
            return value
    return None


def _first_across_rows(rows: list[dict], aliases: list[str]):
    for row in rows:
        value = _first_in_row(row, aliases)
        if _is_present(value):
            return value
    return None


def _add_if_present(parent: ET.Element, tag: str, value) -> None:
    if _is_present(value):
        ET.SubElement(parent, tag).text = _to_text(value)


def _collect_values(
    rows: list[dict], aliases: list[str], split_commas: bool = False
) -> list[str]:
    values: list[str] = []
    seen = set()

    for row in rows:
        value = _first_in_row(row, aliases)
        if not _is_present(value):
            continue

        for item in _normalize_values(value, split_commas=split_commas):
            if item in seen:
                continue
            seen.add(item)
            values.append(item)

    return values


def _record_signature(record: dict) -> tuple:
    return tuple((key, "" if record.get(key) is None else _to_text(record[key])) for key in sorted(record))


def _collect_group_records(
    rows: list[dict],
    field_aliases: dict[str, list[str]],
) -> list[dict]:
    records: list[dict] = []
    seen = set()

    for row in rows:
        value_lists: dict[str, list[str]] = {}
        max_items = 0

        for field_name, aliases in field_aliases.items():
            value = _first_in_row(row, aliases)
            normalized = _normalize_values(value)
            value_lists[field_name] = normalized
            if len(normalized) > max_items:
                max_items = len(normalized)

        if max_items == 0:
            continue

        for index in range(max_items):
            record = {}
            for field_name, normalized in value_lists.items():
                if not normalized:
                    record[field_name] = None
                elif len(normalized) == 1:
                    record[field_name] = normalized[0]
                elif index < len(normalized):
                    record[field_name] = normalized[index]
                else:
                    record[field_name] = None

            if not any(_is_present(value) for value in record.values()):
                continue

            signature = _record_signature(record)
            if signature in seen:
                continue

            seen.add(signature)
            records.append(record)

    return records


def construct_1a(rows: list) -> bytes:
    if rows:
        normalized_rows = []
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

    header_data = ET.SubElement(root, "headerData")
    submission_type = _first_across_rows(normalized_rows, ["submissionType"]) or "1-A"
    _add_if_present(header_data, "submissionType", submission_type)

    filer_info = ET.SubElement(header_data, "filerInfo")
    _add_if_present(filer_info, "liveTestFlag", _first_across_rows(normalized_rows, ["liveTestFlag"]))

    filer_cik = _first_across_rows(normalized_rows, ["filerCik", "cik"])
    filer_ccc = _first_across_rows(normalized_rows, ["filerCcc", "ccc"])
    offering_file_number = _first_across_rows(normalized_rows, ["offeringFileNumber"])
    if _is_present(filer_cik) or _is_present(filer_ccc) or _is_present(offering_file_number):
        filer = ET.SubElement(filer_info, "filer")
        if _is_present(filer_cik) or _is_present(filer_ccc):
            issuer_credentials = ET.SubElement(filer, "issuerCredentials")
            _add_if_present(issuer_credentials, "cik", filer_cik)
            _add_if_present(issuer_credentials, "ccc", filer_ccc)
        _add_if_present(filer, "offeringFileNumber", offering_file_number)

    return_copy_flag = _first_across_rows(normalized_rows, ["returnCopyFlag"])
    override_internet_flag = _first_across_rows(normalized_rows, ["overrideInternetFlag"])
    confirming_copy_flag = _first_across_rows(normalized_rows, ["confirmingCopyFlag"])
    since_last_filing = _first_across_rows(normalized_rows, ["sinceLastFiling"])
    if (
        _is_present(return_copy_flag)
        or _is_present(override_internet_flag)
        or _is_present(confirming_copy_flag)
        or _is_present(since_last_filing)
    ):
        flags = ET.SubElement(filer_info, "flags")
        _add_if_present(flags, "returnCopyFlag", return_copy_flag)
        _add_if_present(flags, "overrideInternetFlag", override_internet_flag)
        _add_if_present(flags, "confirmingCopyFlag", confirming_copy_flag)
        _add_if_present(flags, "sinceLastFiling", since_last_filing)

    co_issuer_file_number = _first_across_rows(normalized_rows, ["coIssuerFileNumber"])
    co_issuer_cik = _first_across_rows(normalized_rows, ["coIssuerCik"])
    co_issuer_ccc = _first_across_rows(normalized_rows, ["coIssuerCcc"])
    if _is_present(co_issuer_file_number) or _is_present(co_issuer_cik) or _is_present(co_issuer_ccc):
        co_issuer_info = ET.SubElement(header_data, "coIssuerInfo")
        co_filer = ET.SubElement(co_issuer_info, "co-filer")
        _add_if_present(co_filer, "coIssuerFileNumber", co_issuer_file_number)
        if _is_present(co_issuer_cik) or _is_present(co_issuer_ccc):
            co_credentials = ET.SubElement(co_filer, "coIssuerCredentials")
            _add_if_present(co_credentials, "cik", co_issuer_cik)
            _add_if_present(co_credentials, "ccc", co_issuer_ccc)

    form_data = ET.SubElement(root, "formData")

    employees_fields = [
        ("issuerName", ["issuerName"]),
        ("jurisdictionOrganization", ["jurisdictionOrganization"]),
        ("yearIncorporation", ["yearIncorporation"]),
        ("cik", ["issuerCik", "cik"]),
        ("sicCode", ["sicCode"]),
        ("irsNum", ["irsNum"]),
        ("fullTimeEmployees", ["fullTimeEmployees"]),
        ("partTimeEmployees", ["partTimeEmployees"]),
    ]
    if any(_is_present(_first_across_rows(normalized_rows, aliases)) for _, aliases in employees_fields):
        employees_info = ET.SubElement(form_data, "employeesInfo")
        for tag, aliases in employees_fields:
            _add_if_present(employees_info, tag, _first_across_rows(normalized_rows, aliases))

    issuer_fields = [
        ("street1", ["street1"]),
        ("street2", ["street2"]),
        ("city", ["city"]),
        ("stateOrCountry", ["stateOrCountry"]),
        ("zipCode", ["zipCode"]),
        ("phoneNumber", ["phoneNumber"]),
        ("connectionName", ["connectionName"]),
        ("industryGroup", ["industryGroup"]),
        ("cashEquivalents", ["cashEquivalents"]),
        ("investmentSecurities", ["investmentSecurities"]),
        ("accountsReceivable", ["accountsReceivable"]),
        ("propertyPlantEquipment", ["propertyPlantEquipment"]),
        ("propertyAndEquipment", ["propertyAndEquipment"]),
        ("deposits", ["deposits"]),
        ("totalAssets", ["totalAssets"]),
        ("accountsPayable", ["accountsPayable"]),
        ("longTermDebt", ["longTermDebt"]),
        ("totalLiabilities", ["totalLiabilities"]),
        ("totalStockholderEquity", ["totalStockholderEquity"]),
        ("totalLiabilitiesAndEquity", ["totalLiabilitiesAndEquity"]),
        ("totalRevenues", ["totalRevenues"]),
        ("totalInterestIncome", ["totalInterestIncome"]),
        ("costAndExpensesApplToRevenues", ["costAndExpensesApplToRevenues"]),
        ("totalInterestExpenses", ["totalInterestExpenses"]),
        ("depreciationAndAmortization", ["depreciationAndAmortization"]),
        ("netIncome", ["netIncome"]),
        ("earningsPerShareBasic", ["earningsPerShareBasic"]),
        ("earningsPerShareDiluted", ["earningsPerShareDiluted"]),
        ("loans", ["loans"]),
        ("nameAuditor", ["nameAuditor"]),
    ]
    if any(_is_present(_first_across_rows(normalized_rows, aliases)) for _, aliases in issuer_fields):
        issuer_info = ET.SubElement(form_data, "issuerInfo")
        for tag, aliases in issuer_fields:
            _add_if_present(issuer_info, tag, _first_across_rows(normalized_rows, aliases))

    common_equity_records = _collect_group_records(
        normalized_rows,
        {
            "commonEquityClassName": ["commonEquityClassName"],
            "outstandingCommonEquity": ["outstandingCommonEquity"],
            "commonCusipEquity": ["commonCusipEquity"],
            "publiclyTradedCommonEquity": ["publiclyTradedCommonEquity"],
        },
    )
    for record in common_equity_records:
        common_equity = ET.SubElement(form_data, "commonEquity")
        _add_if_present(common_equity, "commonEquityClassName", record["commonEquityClassName"])
        _add_if_present(common_equity, "outstandingCommonEquity", record["outstandingCommonEquity"])
        _add_if_present(common_equity, "commonCusipEquity", record["commonCusipEquity"])
        _add_if_present(common_equity, "publiclyTradedCommonEquity", record["publiclyTradedCommonEquity"])

    preferred_equity_records = _collect_group_records(
        normalized_rows,
        {
            "preferredEquityClassName": ["preferredEquityClassName"],
            "outstandingPreferredEquity": ["outstandingPreferredEquity"],
            "preferredCusipEquity": ["preferredCusipEquity"],
            "publiclyTradedPreferredEquity": ["publiclyTradedPreferredEquity"],
        },
    )
    for record in preferred_equity_records:
        preferred_equity = ET.SubElement(form_data, "preferredEquity")
        _add_if_present(preferred_equity, "preferredEquityClassName", record["preferredEquityClassName"])
        _add_if_present(preferred_equity, "outstandingPreferredEquity", record["outstandingPreferredEquity"])
        _add_if_present(preferred_equity, "preferredCusipEquity", record["preferredCusipEquity"])
        _add_if_present(preferred_equity, "publiclyTradedPreferredEquity", record["publiclyTradedPreferredEquity"])

    debt_securities_records = _collect_group_records(
        normalized_rows,
        {
            "debtSecuritiesClassName": ["debtSecuritiesClassName"],
            "outstandingDebtSecurities": ["outstandingDebtSecurities"],
            "cusipDebtSecurities": ["cusipDebtSecurities"],
            "publiclyTradedDebtSecurities": ["publiclyTradedDebtSecurities"],
        },
    )
    for record in debt_securities_records:
        debt_securities = ET.SubElement(form_data, "debtSecurities")
        _add_if_present(debt_securities, "debtSecuritiesClassName", record["debtSecuritiesClassName"])
        _add_if_present(debt_securities, "outstandingDebtSecurities", record["outstandingDebtSecurities"])
        _add_if_present(debt_securities, "cusipDebtSecurities", record["cusipDebtSecurities"])
        _add_if_present(debt_securities, "publiclyTradedDebtSecurities", record["publiclyTradedDebtSecurities"])

    certify_if_true = _first_across_rows(normalized_rows, ["certifyIfTrue"])
    if _is_present(certify_if_true):
        issuer_eligibility = ET.SubElement(form_data, "issuerEligibility")
        _add_if_present(issuer_eligibility, "certifyIfTrue", certify_if_true)

    certify_not_disqualified = _first_across_rows(normalized_rows, ["certifyIfNotDisqualified"])
    certify_bad_actor = _first_across_rows(normalized_rows, ["certifyIfBadActor"])
    if _is_present(certify_not_disqualified) or _is_present(certify_bad_actor):
        application_rule_262 = ET.SubElement(form_data, "applicationRule262")
        _add_if_present(application_rule_262, "certifyIfNotDisqualified", certify_not_disqualified)
        _add_if_present(application_rule_262, "certifyIfBadActor", certify_bad_actor)

    summary_scalars = [
        ("indicateTier1Tier2Offering", ["indicateTier1Tier2Offering"]),
        ("financialStatementAuditStatus", ["financialStatementAuditStatus"]),
        ("securitiesOffered", ["securitiesOffered"]),
        ("securitiesOfferedOtherDesc", ["securitiesOfferedOtherDesc"]),
        ("offerDelayedContinuousFlag", ["offerDelayedContinuousFlag"]),
        ("offeringYearFlag", ["offeringYearFlag"]),
        ("offeringAfterQualifFlag", ["offeringAfterQualifFlag"]),
        ("offeringBestEffortsFlag", ["offeringBestEffortsFlag"]),
        ("solicitationProposedOfferingFlag", ["solicitationProposedOfferingFlag"]),
        ("resaleSecuritiesAffiliatesFlag", ["resaleSecuritiesAffiliatesFlag"]),
        ("outstandingSecurities", ["outstandingSecurities"]),
        ("pricePerSecurity", ["pricePerSecurity"]),
        ("issuerAggregateOffering", ["issuerAggregateOffering"]),
        ("securityHolderAggegate", ["securityHolderAggregate", "securityHolderAggegate"]),
        ("qualificationOfferingAggregate", ["qualificationOfferingAggregate"]),
        ("concurrentOfferingAggregate", ["concurrentOfferingAggregate"]),
        ("totalAggregateOffering", ["totalAggregateOffering"]),
        ("underwritersServiceProviderName", ["underwritersServiceProviderName"]),
        ("underwritersFees", ["underwritersFees"]),
        ("salesCommissionsServiceProviderName", ["salesCommissionsServiceProviderName"]),
        ("salesCommissionsServiceProviderFees", ["salesCommissionsServiceProviderFees"]),
        ("findersFeesServiceProviderName", ["findersFeesServiceProviderName"]),
        ("finderFeesFee", ["finderFeesFee"]),
        ("auditorServiceProviderName", ["auditorServiceProviderName"]),
        ("auditorFees", ["auditorFees"]),
        ("legalServiceProviderName", ["legalServiceProviderName"]),
        ("legalFees", ["legalFees"]),
        ("promotersServiceProviderName", ["promotersServiceProviderName"]),
        ("promotersFees", ["promotersFees"]),
        ("blueSkyServiceProviderName", ["blueSkyServiceProviderName"]),
        ("blueSkyFees", ["blueSkyFees"]),
        ("brokerDealerCrdNumber", ["brokerDealerCrdNumber"]),
        ("estimatedNetAmount", ["estimatedNetAmount"]),
        ("clarificationResponses", ["clarificationResponses"]),
    ]
    securities_offered_types = _collect_values(normalized_rows, ["securitiesOfferedTypes"])

    has_summary = any(
        _is_present(_first_across_rows(normalized_rows, aliases))
        for _, aliases in summary_scalars
    ) or bool(securities_offered_types)
    if has_summary:
        summary_info = ET.SubElement(form_data, "summaryInfo")
        for tag, aliases in summary_scalars:
            if tag == "securitiesOfferedOtherDesc":
                # Keep this tag adjacent to securitiesOfferedTypes for readability.
                continue
            if tag == "offerDelayedContinuousFlag":
                for offered_type in securities_offered_types:
                    _add_if_present(summary_info, "securitiesOfferedTypes", offered_type)
                _add_if_present(summary_info, "securitiesOfferedOtherDesc", _first_across_rows(normalized_rows, ["securitiesOfferedOtherDesc"]))
            _add_if_present(summary_info, tag, _first_across_rows(normalized_rows, aliases))

    jurisdictions_none = _first_across_rows(normalized_rows, ["jurisdictionsOfSecOfferedNone"])
    jurisdictions_same = _first_across_rows(normalized_rows, ["jurisdictionsOfSecOfferedSame"])
    issue_jurisdictions = _collect_values(normalized_rows, ["issueJurisdiction"], split_commas=True)
    dealer_jurisdictions = _collect_values(normalized_rows, ["dealersJurisdiction"], split_commas=True)
    if (
        _is_present(jurisdictions_none)
        or _is_present(jurisdictions_same)
        or issue_jurisdictions
        or dealer_jurisdictions
    ):
        jurisdiction_section = ET.SubElement(form_data, "juridictionSecuritiesOffered")
        _add_if_present(jurisdiction_section, "jurisdictionsOfSecOfferedNone", jurisdictions_none)
        _add_if_present(jurisdiction_section, "jurisdictionsOfSecOfferedSame", jurisdictions_same)
        for value in issue_jurisdictions:
            _add_if_present(jurisdiction_section, "issueJuridicationSecuritiesOffering", value)
        for value in dealer_jurisdictions:
            _add_if_present(jurisdiction_section, "dealersJuridicationSecuritiesOffering", value)

    unregistered_none = _first_across_rows(normalized_rows, ["ifUnregisteredNone", "ifUnregsiteredNone"])
    if _is_present(unregistered_none):
        unregistered_securities = ET.SubElement(form_data, "unregisteredSecurities")
        _add_if_present(unregistered_securities, "ifUnregsiteredNone", unregistered_none)

    securities_issued_records = _collect_group_records(
        normalized_rows,
        {
            "securitiesIssuerName": ["securitiesIssuerName"],
            "securitiesIssuerTitle": ["securitiesIssuerTitle"],
            "securitiesIssuedTotalAmount": ["securitiesIssuedTotalAmount"],
            "securitiesPrincipalHolderAmount": ["securitiesPrincipalHolderAmount"],
            "securitiesIssuedAggregateAmount": ["securitiesIssuedAggregateAmount"],
            "aggregateConsiderationBasis": ["aggregateConsiderationBasis"],
        },
    )
    for record in securities_issued_records:
        securities_issued = ET.SubElement(form_data, "securitiesIssued")
        _add_if_present(securities_issued, "securitiesIssuerName", record["securitiesIssuerName"])
        _add_if_present(securities_issued, "securitiesIssuerTitle", record["securitiesIssuerTitle"])
        _add_if_present(securities_issued, "securitiesIssuedTotalAmount", record["securitiesIssuedTotalAmount"])
        _add_if_present(securities_issued, "securitiesPrincipalHolderAmount", record["securitiesPrincipalHolderAmount"])
        _add_if_present(securities_issued, "securitiesIssuedAggregateAmount", record["securitiesIssuedAggregateAmount"])
        _add_if_present(securities_issued, "aggregateConsiderationBasis", record["aggregateConsiderationBasis"])

    securities_act_exemption = _first_across_rows(normalized_rows, ["securitiesActExemption", "securitiesActExcemption"])
    if _is_present(securities_act_exemption):
        unregistered_securities_act = ET.SubElement(form_data, "unregisteredSecuritiesAct")
        _add_if_present(unregistered_securities_act, "securitiesActExcemption", securities_act_exemption)
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space="\t")

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding="unicode", xml_declaration=False)

    return output.getvalue().encode("utf-8")
