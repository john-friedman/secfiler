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

def construct_c(rows: list) -> bytes:
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
    root.set('xmlns', 'http://www.sec.gov/edgar/formc')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'actReceivedMostRecentFiscalYear'], _first_across_rows(normalized_rows, ['actReceivedMostRecentFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'actReceivedPriorFiscalYear'], _first_across_rows(normalized_rows, ['actReceivedPriorFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'cashEquiMostRecentFiscalYear'], _first_across_rows(normalized_rows, ['cashEquiMostRecentFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'cashEquiPriorFiscalYear'], _first_across_rows(normalized_rows, ['cashEquiPriorFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'costGoodsSoldMostRecentFiscalYear'], _first_across_rows(normalized_rows, ['costGoodsSoldMostRecentFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'costGoodsSoldPriorFiscalYear'], _first_across_rows(normalized_rows, ['costGoodsSoldPriorFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'currentEmployees'], _first_across_rows(normalized_rows, ['currentEmployees']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'issueJurisdictionSecuritiesOffering'], _first_across_rows(normalized_rows, ['issueJurisdictionSecuritiesOffering']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'longTermDebtMostRecentFiscalYear'], _first_across_rows(normalized_rows, ['longTermDebtMostRecentFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'longTermDebtPriorFiscalYear'], _first_across_rows(normalized_rows, ['longTermDebtPriorFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'netIncomeMostRecentFiscalYear'], _first_across_rows(normalized_rows, ['netIncomeMostRecentFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'netIncomePriorFiscalYear'], _first_across_rows(normalized_rows, ['netIncomePriorFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'revenueMostRecentFiscalYear'], _first_across_rows(normalized_rows, ['revenueMostRecentFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'revenuePriorFiscalYear'], _first_across_rows(normalized_rows, ['revenuePriorFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'shortTermDebtMostRecentFiscalYear'], _first_across_rows(normalized_rows, ['shortTermDebtMostRecentFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'shortTermDebtPriorFiscalYear'], _first_across_rows(normalized_rows, ['shortTermDebtPriorFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'taxPaidMostRecentFiscalYear'], _first_across_rows(normalized_rows, ['taxPaidMostRecentFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'taxPaidPriorFiscalYear'], _first_across_rows(normalized_rows, ['taxPaidPriorFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'totalAssetMostRecentFiscalYear'], _first_across_rows(normalized_rows, ['totalAssetMostRecentFiscalYear']))
    _add_path_text(root, ['formData', 'annualReportDisclosureRequirements', 'totalAssetPriorFiscalYear'], _first_across_rows(normalized_rows, ['totalAssetPriorFiscalYear']))
    _add_path_text(root, ['formData', 'issuerInformation', 'commissionCik'], _first_across_rows(normalized_rows, ['commissionCik']))
    _add_path_text(root, ['formData', 'issuerInformation', 'commissionFileNumber'], _first_across_rows(normalized_rows, ['commissionFileNumber']))
    _add_path_text(root, ['formData', 'issuerInformation', 'companyName'], _first_across_rows(normalized_rows, ['companyName']))
    _add_path_text(root, ['formData', 'issuerInformation', 'crdNumber'], _first_across_rows(normalized_rows, ['crdNumber']))
    _add_path_text(root, ['formData', 'issuerInformation', 'isAmendment'], _first_across_rows(normalized_rows, ['isAmendment']))
    _add_path_text(root, ['formData', 'issuerInformation', 'isCoIssuer'], _first_across_rows(normalized_rows, ['isCoIssuer']))
    _add_path_text(root, ['formData', 'issuerInformation', 'natureOfAmendment'], _first_across_rows(normalized_rows, ['natureOfAmendment']))
    _add_path_text(root, ['formData', 'issuerInformation', 'progressUpdate'], _first_across_rows(normalized_rows, ['progressUpdate']))
    _add_path_text(root, ['formData', 'offeringInformation', 'compensationAmount'], _first_across_rows(normalized_rows, ['compensationAmount']))
    _add_path_text(root, ['formData', 'offeringInformation', 'deadlineDate'], _first_across_rows(normalized_rows, ['deadlineDate']))
    _add_path_text(root, ['formData', 'offeringInformation', 'descOverSubscription'], _first_across_rows(normalized_rows, ['descOverSubscription']))
    _add_path_text(root, ['formData', 'offeringInformation', 'financialInterest'], _first_across_rows(normalized_rows, ['financialInterest']))
    _add_path_text(root, ['formData', 'offeringInformation', 'maximumOfferingAmount'], _first_across_rows(normalized_rows, ['maximumOfferingAmount']))
    _add_path_text(root, ['formData', 'offeringInformation', 'noOfSecurityOffered'], _first_across_rows(normalized_rows, ['noOfSecurityOffered']))
    _add_path_text(root, ['formData', 'offeringInformation', 'offeringAmount'], _first_across_rows(normalized_rows, ['offeringAmount']))
    _add_path_text(root, ['formData', 'offeringInformation', 'overSubscriptionAccepted'], _first_across_rows(normalized_rows, ['overSubscriptionAccepted']))
    _add_path_text(root, ['formData', 'offeringInformation', 'overSubscriptionAllocationType'], _first_across_rows(normalized_rows, ['overSubscriptionAllocationType']))
    _add_path_text(root, ['formData', 'offeringInformation', 'price'], _first_across_rows(normalized_rows, ['price']))
    _add_path_text(root, ['formData', 'offeringInformation', 'priceDeterminationMethod'], _first_across_rows(normalized_rows, ['priceDeterminationMethod']))
    _add_path_text(root, ['formData', 'offeringInformation', 'securityOfferedOtherDesc'], _first_across_rows(normalized_rows, ['securityOfferedOtherDesc']))
    _add_path_text(root, ['formData', 'offeringInformation', 'securityOfferedType'], _first_across_rows(normalized_rows, ['securityOfferedType']))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], _first_across_rows(normalized_rows, ['liveTestFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'period'], _first_across_rows(normalized_rows, ['period']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerWebsite'], _first_across_rows(normalized_rows, ['issuerWebsite']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'nameOfIssuer'], _first_across_rows(normalized_rows, ['nameOfIssuer']))
    _add_path_text(root, ['formData', 'signatureInfo', 'issuerSignature', 'issuer'], _first_across_rows(normalized_rows, ['issuer']))
    _add_path_text(root, ['formData', 'signatureInfo', 'issuerSignature', 'issuerSignature'], _first_across_rows(normalized_rows, ['issuerSignature']))
    _add_path_text(root, ['formData', 'signatureInfo', 'issuerSignature', 'issuerTitle'], _first_across_rows(normalized_rows, ['issuerTitle']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'fileNumber'], _first_across_rows(normalized_rows, ['fileNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], _first_across_rows(normalized_rows, ['confirmingCopyFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], _first_across_rows(normalized_rows, ['overrideInternetFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'returnCopyFlag'], _first_across_rows(normalized_rows, ['returnCopyFlag']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'coIssuerCik'], _first_across_rows(normalized_rows, ['coIssuerCik']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'coIssuerWebsite'], _first_across_rows(normalized_rows, ['coIssuerWebsite']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'isEdgarFiler'], _first_across_rows(normalized_rows, ['isEdgarFiler']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'nameOfCoIssuer'], _first_across_rows(normalized_rows, ['nameOfCoIssuer']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'city'], _first_across_rows(normalized_rows, ['city']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['stateOrCountry']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'street1'], _first_across_rows(normalized_rows, ['street1']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'street2'], _first_across_rows(normalized_rows, ['street2']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'issuerAddress', 'zipCode'], _first_across_rows(normalized_rows, ['zipCode']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'dateIncorporation'], _first_across_rows(normalized_rows, ['dateIncorporation']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'jurisdictionOrganization'], _first_across_rows(normalized_rows, ['jurisdictionOrganization']))
    _add_path_text(root, ['formData', 'issuerInformation', 'issuerInfo', 'legalStatus', 'legalStatusForm'], _first_across_rows(normalized_rows, ['legalStatusForm']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signaturePersons', 'signaturePerson', 'personSignature'], _first_across_rows(normalized_rows, ['personSignature']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signaturePersons', 'signaturePerson', 'personTitle'], _first_across_rows(normalized_rows, ['personTitle']))
    _add_path_text(root, ['formData', 'signatureInfo', 'signaturePersons', 'signaturePerson', 'signatureDate'], _first_across_rows(normalized_rows, ['signatureDate']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'filerCcc'], _first_across_rows(normalized_rows, ['filerCcc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'filerCik'], _first_across_rows(normalized_rows, ['filerCik']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'coIssuerAddress', 'city'], _first_across_rows(normalized_rows, ['coIssuerAddressCity']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'coIssuerAddress', 'stateOrCountry'], _first_across_rows(normalized_rows, ['coIssuerAddressStateOrCountry']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'coIssuerAddress', 'street1'], _first_across_rows(normalized_rows, ['coIssuerAddressStreet1']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'coIssuerAddress', 'zipCode'], _first_across_rows(normalized_rows, ['coIssuerAddressZipCode']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'coIssuerLegalStatus', 'dateIncorporation'], _first_across_rows(normalized_rows, ['coIssuerLegalStatusDateIncorporation']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'coIssuerLegalStatus', 'jurisdictionOrganization'], _first_across_rows(normalized_rows, ['coIssuerLegalStatusJurisdictionOrganization']))
    _add_path_text(root, ['formData', 'issuerInformation', 'coIssuers', 'coIssuerInfo', 'coIssuerLegalStatus', 'legalStatusForm'], _first_across_rows(normalized_rows, ['coIssuerLegalStatusLegalStatusForm']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')


