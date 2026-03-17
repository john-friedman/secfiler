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

def construct_atsn_ua(rows: list) -> bytes:
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
    root.set('xmlns', 'http://www.sec.gov/edgar/atsn')
    root.set('xmlns:com', 'http://www.sec.gov/edgar/common')
    root.set('xmlns:ats', 'http://www.sec.gov/edgar/atsncommon')
    _add_path_text(root, ['headerData', 'accessionNumber'], _first_across_rows(normalized_rows, ['accessionNumber']))
    _add_path_text(root, ['headerData', 'dateCeaseToOperate'], _first_across_rows(normalized_rows, ['dateCeaseToOperate']))
    _add_path_text(root, ['headerData', 'rbOperatesPursuantToFormATS'], _first_across_rows(normalized_rows, ['rbOperatesPursuantToFormAts']))
    _add_path_text(root, ['headerData', 'submissionType'], _first_across_rows(normalized_rows, ['submissionType']))
    _add_path_text(root, ['formData', 'cover', 'rbOperatesPursuantToFormATS'], _first_across_rows(normalized_rows, ['coverRbOperatesPursuantToFormAts']))
    _add_path_text(root, ['formData', 'cover', 'taStatementAboutAmendment'], _first_across_rows(normalized_rows, ['taStatementAboutAmendment']))
    _add_path_text(root, ['formData', 'cover', 'txNMSStockATSName'], _first_across_rows(normalized_rows, ['txNMSStockATSName']))
    _add_path_text(root, ['formData', 'partOne', 'cbPart1Item8Exhibit1atWebsite'], _first_across_rows(normalized_rows, ['cbPart1Item8Exhibit1atWebsite']))
    _add_path_text(root, ['formData', 'partOne', 'cbPart1Item9Exhibit2atWebsite'], _first_across_rows(normalized_rows, ['cbPart1Item9Exhibit2atWebsite']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item5bEffectiveMembershipDate'], _first_across_rows(normalized_rows, ['part1Item5bEffectiveMembershipDate']))
    _add_path_text(root, ['formData', 'partOne', 'rbPart1Item1IsBd'], _first_across_rows(normalized_rows, ['rbPart1Item1IsBd']))
    _add_path_text(root, ['formData', 'partOne', 'txPart1Item2ATSName'], _first_across_rows(normalized_rows, ['txPart1Item2ATSName']))
    _add_path_text(root, ['formData', 'partOne', 'txPart1Item4aBdCrdNumber'], _first_across_rows(normalized_rows, ['txPart1Item4aBdCrdNumber']))
    _add_path_text(root, ['formData', 'partOne', 'txPart1Item4aBdFileNumber'], _first_across_rows(normalized_rows, ['txPart1Item4aBdFileNumber']))
    _add_path_text(root, ['formData', 'partOne', 'txPart1Item5aNsaFullName'], _first_across_rows(normalized_rows, ['txPart1Item5aNsaFullName']))
    _add_path_text(root, ['formData', 'partOne', 'txtPart1Item5cNmsStockMPID'], _first_across_rows(normalized_rows, ['txtPart1Item5cNmsStockMPID']))
    _add_path_text(root, ['formData', 'partOne', 'txtPart1Item6uwebsite'], _first_across_rows(normalized_rows, ['txtPart1Item6uwebsite']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item10bIsOpnReopnSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item10bIsOpnReopnSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item10dIsAnyDifBtwnExeProcTrdHrs'], _first_across_rows(normalized_rows, ['rbPart3Item10dIsAnyDifBtwnExeProcTrdHrs']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item10eIsAnyDifBtwnPreOpExecFlwngStpg'], _first_across_rows(normalized_rows, ['rbPart3Item10eIsAnyDifBtwnPreOpExecFlwngStpg']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item11bIsMeansFeciltsSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item11BIsMeansFeciltsSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item11dIsProcsRulsSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item11DIsProcsRulsSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item12aIsAnyFrmlInfrmlArngmnts'], _first_across_rows(normalized_rows, ['rbPart3Item12aIsAnyFrmlInfrmlArngmnts']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item13aIsOrdrTiSegmntd'], _first_across_rows(normalized_rows, ['rbPart3Item13AIsOrdrTiSegmntd']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item13cIsCustmrOrdr'], _first_across_rows(normalized_rows, ['rbPart3Item13cIsCustmrOrdr']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item14aIsDsgToIntrctOrNot'], _first_across_rows(normalized_rows, ['rbPart3Item14AIsDsgToIntrctOrNot']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item15aIsElectrncCommu'], _first_across_rows(normalized_rows, ['rbPart3Item15aIsElectrncCommu']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item15bIsSubScrbOrdBnd'], _first_across_rows(normalized_rows, ['rbPart3Item15BIsSubScrbOrdBnd']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item16aIsInstRoutd'], _first_across_rows(normalized_rows, ['rbPart3Item16aIsInstRoutd']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item17aIsDiffBtwnOrdTITrtmnt'], _first_across_rows(normalized_rows, ['rbPart3Item17AIsDiffBtwnOrdTiTrtmnt']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item17bIsTrtmntSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item17bIsTrtmntSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item18aIsOutsdeTrdingHrs'], _first_across_rows(normalized_rows, ['rbPart3Item18aIsOutsdeTrdingHrs']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item20bIsSuspndProcdurSameFrAll'], _first_across_rows(normalized_rows, ['rbPart3Item20bIsSuspndProcdurSameFrAll']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item21bIsMtrlArngmtSameFrAll'], _first_across_rows(normalized_rows, ['rbPart3Item21bIsMtrlArngmtSameFrAll']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item22bIsMtrlArngmtSameFrAll'], _first_across_rows(normalized_rows, ['rbPart3Item22BIsMtrlArngmtSameFrAll']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item23bIsSrcSameFrAll'], _first_across_rows(normalized_rows, ['rbPart3Item23bIsSrcSameFrAll']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item24aIsSubScrbrOrdr'], _first_across_rows(normalized_rows, ['rbPart3Item24aIsSubScrbrOrdr']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item25aIsAvgDlyTradinVolExcd'], _first_across_rows(normalized_rows, ['rbPart3Item25aIsAvgDlyTradinVolExcd']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item26IsOrdrFloExecStatsPublshd'], _first_across_rows(normalized_rows, ['rbPart3Item26IsOrdrFloExecStatsPublshd']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item2aRegisteredBD'], _first_across_rows(normalized_rows, ['rbPart3Item2aRegisteredBD']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item2dIsThereWrittenAgreement'], _first_across_rows(normalized_rows, ['rbPart3Item2dIsThereWrittenAgreement']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item4bIsHrsOfOperationsame'], _first_across_rows(normalized_rows, ['rbPart3Item4bIsHrsOfOperationsame']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item5aIsPermitOrdrTradng'], _first_across_rows(normalized_rows, ['rbPart3Item5AIsPermitOrdrTradng']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item5cIsAnyOtherMeans'], _first_across_rows(normalized_rows, ['rbPart3Item5CIsAnyOtherMeans']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item6aIsCoLocRltdSrvcsOfrd'], _first_across_rows(normalized_rows, ['rbPart3Item6AIsCoLocRltdSrvcsOfrd']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item6cIsAnyOtherMeans'], _first_across_rows(normalized_rows, ['rbPart3Item6cIsAnyOtherMeans']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item6eIsAnyRducdSpOfCom'], _first_across_rows(normalized_rows, ['rbPart3Item6eIsAnyRducdSpOfCom']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item7bIsTnCSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item7BIsTnCSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item8cIsOddLotsAcptdExecutd'], _first_across_rows(normalized_rows, ['rbPart3Item8CIsOddLotsAcptdExecutd']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item8eIsMixLotOrdrsAcptdExecutd'], _first_across_rows(normalized_rows, ['rbPart3Item8EIsMixLotOrdrsAcptdExecutd']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item9aIsAnyMsgToIndicTI'], _first_across_rows(normalized_rows, ['rbPart3Item9AIsAnyMsgToIndicTi']))
    _add_path_text(root, ['formData', 'partThree', 'rbPart3Item9bIsIndIntrstSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item9BIsIndIntrstSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item10aOpenReOpenDtls'], _first_across_rows(normalized_rows, ['taPart3Item10aOpenReOpenDtls']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item10cUnexeOrdrTIDtls'], _first_across_rows(normalized_rows, ['taPart3Item10cUnexeOrdrTIDtls']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item11aStrucOfNmsStk'], _first_across_rows(normalized_rows, ['taPart3Item11aStrucOfNmsStk']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item11cRulsProcsOfNmsStk'], _first_across_rows(normalized_rows, ['taPart3Item11cRulsProcsOfNmsStk']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item19aSrvcUsgFees'], _first_across_rows(normalized_rows, ['taPart3Item19aSrvcUsgFees']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item19bBundldSrvcUsgFees'], _first_across_rows(normalized_rows, ['taPart3Item19bBundldSrvcUsgFees']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item19cRbtDiscOfFees'], _first_across_rows(normalized_rows, ['taPart3Item19cRbtDiscOfFees']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item1OtherSubscrbrDtls'], _first_across_rows(normalized_rows, ['taPart3Item1OtherSubscrbrDtls']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item1SubscriberType'], _first_across_rows(normalized_rows, ['taPart3Item1SubscriberType']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item20aSuspndProcdur'], _first_across_rows(normalized_rows, ['taPart3Item20aSuspndProcdur']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item21aMtrlArngmntDtls'], _first_across_rows(normalized_rows, ['taPart3Item21aMtrlArngmntDtls']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item22aMtrlArngmntDtls'], _first_across_rows(normalized_rows, ['taPart3Item22aMtrlArngmntDtls']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item23aMrktDatSrc'], _first_across_rows(normalized_rows, ['taPart3Item23aMrktDatSrc']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item4aHrsOfOperation'], _first_across_rows(normalized_rows, ['taPart3Item4aHrsOfOperation']))
    _add_path_text(root, ['formData', 'partThree', 'taPart3Item7AOrdrTypExplain'], _first_across_rows(normalized_rows, ['taPart3Item7AOrdrTypExplain']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item1aArePermittedToEnterInterest'], _first_across_rows(normalized_rows, ['rbPart2Item1AArePermittedToEnterInterest']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item1dCanOATInterestBeRouted'], _first_across_rows(normalized_rows, ['rbPart2Item1dCanOATInterestBeRouted']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item2aAreAfflPermittedToEnterInterest'], _first_across_rows(normalized_rows, ['rbPart2Item2AAreAfflPermittedToEnterInterest']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item2dCanOATIBeRoutedByAffl'], _first_across_rows(normalized_rows, ['rbPart2Item2dCanOATIBeRoutedByAffl']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item3aCanSubscrOptOutWithOATIOfAffl'], _first_across_rows(normalized_rows, ['rbPart2Item3ACanSubscrOptOutWithOatiOfAffl']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item3aCanSubscrOptOutWithOATIOfBD'], _first_across_rows(normalized_rows, ['rbPart2Item3ACanSubscrOptOutWithOatiOfBd']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item3cAreOptOutSametoAllSubscribers'], _first_across_rows(normalized_rows, ['rbPart2Item3CAreOptOutSametoAllSubscribers']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item4aAreThereArrangementsBtwBDAndTC'], _first_across_rows(normalized_rows, ['rbPart2Item4AAreThereArrangementsBtwBdAndTc']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item5cDoesAfflOfferProductsAndServices'], _first_across_rows(normalized_rows, ['rbPart2Item5cDoesAfflOfferProductsAndServices']))
    _add_path_text(root, ['formData', 'partTwo', 'rbPart2Item7bCanSubscriberConsentToDisclosure'], _first_across_rows(normalized_rows, ['rbPart2Item7BCanSubscriberConsentToDisclosure']))
    _add_path_text(root, ['formData', 'partTwo', 'taPart2Item7aDescrOfSafeGaurdsAndProcedures'], _first_across_rows(normalized_rows, ['taPart2Item7aDescrOfSafeGaurdsAndProcedures']))
    _add_path_text(root, ['formData', 'partTwo', 'taPart2Item7dSummaryOfRolesRespOfPersons'], _first_across_rows(normalized_rows, ['taPart2Item7dSummaryOfRolesRespOfPersons']))
    _add_path_text(root, ['headerData', 'filerInfo', 'liveTestFlag'], _first_across_rows(normalized_rows, ['liveTestFlag']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7PrimarySite', 'city'], _first_across_rows(normalized_rows, ['city']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7PrimarySite', 'state'], _first_across_rows(normalized_rows, ['state']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7PrimarySite', 'street1'], _first_across_rows(normalized_rows, ['street1']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7PrimarySite', 'street2'], _first_across_rows(normalized_rows, ['street2']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7PrimarySite', 'zip'], _first_across_rows(normalized_rows, ['zip']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item10eDiffDtls'], 'rbPart3Item10eIsAnyDifBtwnPreOpExecFlwngStpg', _first_across_rows(normalized_rows, ['rbPart3Item10EIsAnyDifBtwnPreOpExecFlwngStpg']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item10eDiffDtls', 'taPart3Item10eDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item10EDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item11bMeansFeciltsDtls'], 'rbPart3Item11bIsMeansFeciltsSameForAll', _first_across_rows(normalized_rows, ['part3Item11BMeansFeciltsDtlsRbPart3Item11BIsMeansFeciltsSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item11bMeansFeciltsDtls', 'taPart3Item11bMeansFeciltsDtls'], _first_across_rows(normalized_rows, ['taPart3Item11BMeansFeciltsDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item11dDiffDtls'], 'rbPart3Item11dIsProcsRulsSameForAll', _first_across_rows(normalized_rows, ['part3Item11DDiffDtlsRbPart3Item11DIsProcsRulsSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item11dDiffDtls', 'taPart3Item11dDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item11DDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item9aMsgDtls'], 'rbPart3Item9aIsAnyMsgToIndicTI', _first_across_rows(normalized_rows, ['part3Item9AMsgDtlsRbPart3Item9AIsAnyMsgToIndicTi']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item17aAffirInstrDtls', 'taPart3Item17aTrtmntDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item17ATrtmntDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item13aSegmntDtls'], 'rbPart3Item13aIsOrdrTiSegmntd', _first_across_rows(normalized_rows, ['part3Item13ASegmntDtlsRbPart3Item13AIsOrdrTiSegmntd']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item13aSegmntDtls', 'rbPart3Item13bIsSegmntatnSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item13BIsSegmntatnSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item13aSegmntDtls', 'taPart3Item13aSegProcdurDtls'], _first_across_rows(normalized_rows, ['taPart3Item13ASegProcdurDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item14aCntrPrtySelectnDtls'], 'rbPart3Item14aIsDsgToIntrctOrNot', _first_across_rows(normalized_rows, ['rbPart3Item14aIsDsgToIntrctOrNot']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item14aCntrPrtySelectnDtls', 'rbPart3Item14bIsSelectnSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item14BIsSelectnSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item14aCntrPrtySelectnDtls', 'taPart3Item14aCntrPrtyDtls'], _first_across_rows(normalized_rows, ['taPart3Item14aCntrPrtyDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item15bSubSctbDtls'], 'rbPart3Item15bIsSubScrbOrdBnd', _first_across_rows(normalized_rows, ['rbPart3Item15bIsSubScrbOrdBnd']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item15bSubSctbDtls', 'rbPart3Item15cIsDsplyProcSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item15CIsDsplyProcSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item15bSubSctbDtls', 'taPart3Item15bSubscrBndDtls'], _first_across_rows(normalized_rows, ['taPart3Item15bSubscrBndDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item16aAffirInstrDtls'], 'rbPart3Item16aIsInstRoutd', _first_across_rows(normalized_rows, ['rbPart3Item16AIsInstRoutd']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item18aTrdingHrDtls', 'rbPart3Item18cIsTrtedDiffOutsdHrs'], _first_across_rows(normalized_rows, ['rbPart3Item16BIsRoutdBefrInstr']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item16aAffirInstrDtls', 'taPart3Item16bAffirmInstrDiffDtlsNo'], _first_across_rows(normalized_rows, ['taPart3Item16BAffirmInstrDiffDtlsNo']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item17aAffirInstrDtls'], 'rbPart3Item17aIsDiffBtwnOrdTITrtmnt', _first_across_rows(normalized_rows, ['part3Item17AAffirInstrDtlsRbPart3Item17AIsDiffBtwnOrdTiTrtmnt']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item17bTrtmntDtls'], 'rbPart3Item17bIsTrtmntSameForAll', _first_across_rows(normalized_rows, ['rbPart3Item17BIsTrtmntSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item17bTrtmntDtls', 'taPart3Item17bDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item17BDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item20bSuspndProcdurDiffDtls'], 'rbPart3Item20bIsSuspndProcdurSameFrAll', _first_across_rows(normalized_rows, ['rbPart3Item20BIsSuspndProcdurSameFrAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item20bSuspndProcdurDiffDtls', 'taPart3Item20bDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item20BDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item22bMtrlArngmntDiffDtls'], 'rbPart3Item22bIsMtrlArngmtSameFrAll', _first_across_rows(normalized_rows, ['part3Item22BMtrlArngmntDiffDtlsRbPart3Item22BIsMtrlArngmtSameFrAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item22bMtrlArngmntDiffDtls', 'taPart3Item22bDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item22BDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item25aSubScrbrOrdrDtls'], 'rbPart3Item25aIsAvgDlyTradinVolExcd', _first_across_rows(normalized_rows, ['rbPart3Item25AIsAvgDlyTradinVolExcd']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item26PlatFrmData'], 'rbPart3Item26IsOrdrFloExecStatsPublshd', _first_across_rows(normalized_rows, ['part3Item26PlatFrmDataRbPart3Item26IsOrdrFloExecStatsPublshd']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item26PlatFrmData', 'cbPart3Item26iInfoRqstdUndrExbt4AvlblAtWebst'], _first_across_rows(normalized_rows, ['cbPart3Item26IInfoRqstdUndrExbt4AvlblAtWebst']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item26PlatFrmData', 'cbPart3Item26iiInfoRqstdUndrExbt5AvlblAtWebst'], _first_across_rows(normalized_rows, ['cbPart3Item26IiInfoRqstdUndrExbt5AvlblAtWebst']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item2bSummaryOfConditions'], 'rbPart3Item2bIsThereOtherConditions', _first_across_rows(normalized_rows, ['rbPart3Item2bIsThereOtherConditions']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item2bSummaryOfConditions', 'rbPart3Item2cIsConditionsSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item2CIsConditionsSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item2bSummaryOfConditions', 'taPart3Item2bSummaryOfCndtns'], _first_across_rows(normalized_rows, ['taPart3Item2bSummaryOfCndtns']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item3aSumryOfExcludngCondtns'], 'rbPart3Item3aIsExcludeSubscriber', _first_across_rows(normalized_rows, ['rbPart3Item3aIsExcludeSubscriber']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item3aSumryOfExcludngCondtns', 'rbPart3Item3bIsCondtnsSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item3BIsCondtnsSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item3aSumryOfExcludngCondtns', 'taPart3Item3aExcludngSumryDtls'], _first_across_rows(normalized_rows, ['taPart3Item3aExcludngSumryDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item5aProtocolDetails'], 'rbPart3Item5aIsPermitOrdrTradng', _first_across_rows(normalized_rows, ['rbPart3Item5aIsPermitOrdrTradng']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item5aProtocolDetails', 'rbPart3Item5bIsProtclsameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item5BIsProtclsameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item5aProtocolDetails', 'taPart3Item5aProtocolused'], _first_across_rows(normalized_rows, ['taPart3Item5aProtocolused']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item5cOthrDtls'], 'rbPart3Item5cIsAnyOtherMeans', _first_across_rows(normalized_rows, ['part3Item5COthrDtlsRbPart3Item5CIsAnyOtherMeans']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item5cOthrDtls', 'rbPart3Item5dIsTnCSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item5DIsTnCSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item5cOthrDtls', 'taPart3Item5cOthrMeansDtls'], _first_across_rows(normalized_rows, ['taPart3Item5COthrMeansDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item6aProtocolDetails'], 'rbPart3Item6aIsCoLocRltdSrvcsOfrd', _first_across_rows(normalized_rows, ['part3Item6AProtocolDetailsRbPart3Item6AIsCoLocRltdSrvcsOfrd']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item6aProtocolDetails', 'rbPart3Item6bIsTNCsameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item6BIsTnCsameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item6aProtocolDetails', 'taPart3Item6aCoLocRltdSrvcsDtls'], _first_across_rows(normalized_rows, ['taPart3Item6ACoLocRltdSrvcsDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item7bTnCDetails'], 'rbPart3Item7bIsTnCSameForAll', _first_across_rows(normalized_rows, ['part3Item7BTnCDetailsRbPart3Item7BIsTnCSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item7bTnCDetails', 'taPart3Item7bTnCSumryDtls'], _first_across_rows(normalized_rows, ['taPart3Item7BTnCSumryDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item8aSizeReqrmnts'], 'rbPart3Item8aIsMinOrMaxSizeReqd', _first_across_rows(normalized_rows, ['rbPart3Item8aIsMinOrMaxSizeReqd']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item8aSizeReqrmnts', 'rbPart3Item8bIsReqProcSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item8BIsReqProcSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item8aSizeReqrmnts', 'taPart3Item8aOtiSizeReqrmns'], _first_across_rows(normalized_rows, ['taPart3Item8aOtiSizeReqrmns']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item8cOddltOrdrReqs'], 'rbPart3Item8cIsOddLotsAcptdExecutd', _first_across_rows(normalized_rows, ['part3Item8COddltOrdrReqsRbPart3Item8CIsOddLotsAcptdExecutd']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item8cOddltOrdrReqs', 'rbPart3Item8dIsReqsProcdurSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item8DIsReqsProcdurSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item8cOddltOrdrReqs', 'taPart3Item8cOddLtOrdrReqsnProcdurs'], _first_across_rows(normalized_rows, ['taPart3Item8COddLtOrdrReqsnProcdurs']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item8eMixltOrdrDetails'], 'rbPart3Item8eIsMixLotOrdrsAcptdExecutd', _first_across_rows(normalized_rows, ['rbPart3Item8eIsMixLotOrdrsAcptdExecutd']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item8eMixltOrdrDetails', 'rbPart3Item8fIsRecProcSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item8fIsRecProcSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item8eMixltOrdrDetails', 'taPart3Item8eMixltOrdrReqsProcDtls'], _first_across_rows(normalized_rows, ['taPart3Item8eMixltOrdrReqsProcDtls']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item9aMsgDtls', 'taPart3Item9aMsgUsgDtls'], _first_across_rows(normalized_rows, ['taPart3Item9AMsgUsgDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item9bMsgDtls'], 'rbPart3Item9bIsIndIntrstSameForAll', _first_across_rows(normalized_rows, ['part3Item9BMsgDtlsRbPart3Item9BIsIndIntrstSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item9bMsgDtls', 'taPart3Item9bMsgUsgDtls'], _first_across_rows(normalized_rows, ['taPart3Item9BMsgUsgDtls']))
    _add_path_attr(root, ['formData', 'partTwo', 'affiliatesPermittedToEnterInterest'], 'rbPart2Item2aAreAfflPermittedToEnterInterest', _first_across_rows(normalized_rows, ['affiliatesPermittedToEnterInterestRbPart2Item2AAreAfflPermittedToEnterInterest']))
    _add_path_text(root, ['formData', 'partTwo', 'affiliatesPermittedToEnterInterest', 'rbPart2Item2bAreSevicestoAfflSametoSubscribers'], _first_across_rows(normalized_rows, ['rbPart2Item2BAreSevicestoAfflSametoSubscribers']))
    _add_path_text(root, ['formData', 'partTwo', 'affiliatesPermittedToEnterInterest', 'rbPart2Item2cAreThereArrangementsWithAffl'], _first_across_rows(normalized_rows, ['rbPart2Item2CAreThereArrangementsWithAffl']))
    _add_path_text(root, ['formData', 'partTwo', 'affiliatesPermittedToEnterInterest', 'taPart2Item2aAfflThatEnterInterest'], _first_across_rows(normalized_rows, ['taPart2Item2AAfflThatEnterInterest']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item1aArePermittedToEnterInterest'], 'rbPart2Item1aArePermittedToEnterInterest', _first_across_rows(normalized_rows, ['part2Item1AArePermittedToEnterInterestRbPart2Item1AArePermittedToEnterInterest']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item1aArePermittedToEnterInterest', 'rbPart2Item1bAreSevicesSametoAllSubscribers'], _first_across_rows(normalized_rows, ['rbPart2Item1BAreSevicesSametoAllSubscribers']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item1aArePermittedToEnterInterest', 'rbPart2Item1cAreThereArrangements'], _first_across_rows(normalized_rows, ['rbPart2Item1CAreThereArrangements']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item1aArePermittedToEnterInterest', 'taPart2Item1aUnitNamesEnterInterest'], _first_across_rows(normalized_rows, ['taPart2Item1AUnitNamesEnterInterest']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item3aCanSubscrOptOutWithOATIOfAffl'], 'rbPart2Item3aCanSubscrOptOutWithOATIOfAffl', _first_across_rows(normalized_rows, ['part2Item3ACanSubscrOptOutWithOatiOfAfflRbPart2Item3ACanSubscrOptOutWithOatiOfAffl']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item3aCanSubscrOptOutWithOATIOfAffl', 'taPart2Item3bExplianOptOut'], _first_across_rows(normalized_rows, ['taPart2Item3BExplianOptOut']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item3aCanSubscrOptOutWithOATIOfBD'], 'rbPart2Item3aCanSubscrOptOutWithOATIOfBD', _first_across_rows(normalized_rows, ['part2Item3ACanSubscrOptOutWithOatiOfBdRbPart2Item3ACanSubscrOptOutWithOatiOfBd']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item3aCanSubscrOptOutWithOATIOfBD', 'taPart2Item3aExplianOptOut'], _first_across_rows(normalized_rows, ['taPart2Item3AExplianOptOut']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item3cAreOptOutSametoAllSubscribers'], 'rbPart2Item3cAreOptOutSametoAllSubscribers', _first_across_rows(normalized_rows, ['part2Item3CAreOptOutSametoAllSubscribersRbPart2Item3CAreOptOutSametoAllSubscribers']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item3cAreOptOutSametoAllSubscribers', 'taPart2Item3cExplainDiff'], _first_across_rows(normalized_rows, ['taPart2Item3CExplainDiff']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item4aAreThereArrangementsBtwBDAndTC'], 'rbPart2Item4aAreThereArrangementsBtwBDAndTC', _first_across_rows(normalized_rows, ['part2Item4AAreThereArrangementsBtwBdAndTcRbPart2Item4AAreThereArrangementsBtwBdAndTc']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item4aAreThereArrangementsBtwBDAndTC', 'rbPart2Item4bAreThereArrangementsBtwAfflAndTC'], _first_across_rows(normalized_rows, ['rbPart2Item4BAreThereArrangementsBtwAfflAndTc']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item4aAreThereArrangementsBtwBDAndTC', 'taPart2Item4aTDAndATSServices'], _first_across_rows(normalized_rows, ['taPart2Item4ATdAndAtsServices']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item5aDoesOfferProductsAndServices'], 'rbPart2Item5aDoesOfferProductsAndServices', _first_across_rows(normalized_rows, ['rbPart2Item5aDoesOfferProductsAndServices']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item5aDoesOfferProductsAndServices', 'rbPart2Item5bAreSevicesSametoAllSubscribersAndBD'], _first_across_rows(normalized_rows, ['rbPart2Item5BAreSevicesSametoAllSubscribersAndBd']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item5aDoesOfferProductsAndServices', 'taPart2Item5aProductsAndServices'], _first_across_rows(normalized_rows, ['taPart2Item5aProductsAndServices']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item6aDoesEmployeeAccessConfidentialInfo'], 'rbPart2Item6aDoesEmployeeAccessConfidentialInfo', _first_across_rows(normalized_rows, ['rbPart2Item6aDoesEmployeeAccessConfidentialInfo']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item6aDoesEmployeeAccessConfidentialInfo', 'taPart2Item6aUnitAfflEmployeeServices'], _first_across_rows(normalized_rows, ['taPart2Item6aUnitAfflEmployeeServices']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item6bDoesAnyEntitySupportServices'], 'rbPart2Item6bDoesAnyEntitySupportServices', _first_across_rows(normalized_rows, ['rbPart2Item6bDoesAnyEntitySupportServices']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item6bDoesAnyEntitySupportServices', 'rbPart2Item6cDoesServiceProviderUseATSServices'], _first_across_rows(normalized_rows, ['rbPart2Item6CDoesServiceProviderUseAtsServices']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item6bDoesAnyEntitySupportServices', 'taPart2Item6bServiceProvider'], _first_across_rows(normalized_rows, ['taPart2Item6bServiceProvider']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item7bCanSubscriberConsentToDisclosure'], 'rbPart2Item7bCanSubscriberConsentToDisclosure', _first_across_rows(normalized_rows, ['part2Item7BCanSubscriberConsentToDisclosureRbPart2Item7BCanSubscriberConsentToDisclosure']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item7bCanSubscriberConsentToDisclosure', 'taPart2Item7bExplainHowAndConditions'], _first_across_rows(normalized_rows, ['taPart2Item7BExplainHowAndConditions']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'contactEmailAddress'], _first_across_rows(normalized_rows, ['contactEmailAddress']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'contactName'], _first_across_rows(normalized_rows, ['contactName']))
    _add_path_text(root, ['headerData', 'filerInfo', 'contact', 'contactPhoneNumber'], _first_across_rows(normalized_rows, ['contactPhoneNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'MPID'], _first_across_rows(normalized_rows, ['mpid']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'NMSStockATSName'], _first_across_rows(normalized_rows, ['nmsStockAtsName']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'fileNumber'], _first_across_rows(normalized_rows, ['fileNumber']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'confirmingCopyFlag'], _first_across_rows(normalized_rows, ['confirmingCopyFlag']))
    _add_path_text(root, ['headerData', 'filerInfo', 'flags', 'overrideInternetFlag'], _first_across_rows(normalized_rows, ['overrideInternetFlag']))
    _add_path_attr(root, ['formData', 'partOne', 'atsNames', 'atsName'], 'txPart1Item3ATSName', _first_across_rows(normalized_rows, ['txPart1Item3ATSName']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7SecondarySiteRecords', 'secondarySiteI7', 'city'], _first_across_rows(normalized_rows, ['secondarySite7City']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7SecondarySiteRecords', 'secondarySiteI7', 'state'], _first_across_rows(normalized_rows, ['secondarySite7State']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7SecondarySiteRecords', 'secondarySiteI7', 'street1'], _first_across_rows(normalized_rows, ['secondarySite7Street1']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7SecondarySiteRecords', 'secondarySiteI7', 'street2'], _first_across_rows(normalized_rows, ['secondarySite7Street2']))
    _add_path_text(root, ['formData', 'partOne', 'part1Item7SecondarySiteRecords', 'secondarySiteI7', 'zip'], _first_across_rows(normalized_rows, ['secondarySite7Zip']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item13aSegmntDtls', 'part3Item13bSegmntDtls'], 'rbPart3Item13bIsSegmntatnSameForAll', _first_across_rows(normalized_rows, ['part3Item13BSegmntDtlsRbPart3Item13BIsSegmntatnSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item13aSegmntDtls', 'part3Item13bSegmntDtls', 'taPart3Item13bSegDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item13BSegDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item13aSegmntDtls', 'part3Item13dDsclrContntDtls'], 'rbPart3Item13dIsSegCatgDisclosd', _first_across_rows(normalized_rows, ['rbPart3Item13DIsSegCatgDisclosd']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item13aSegmntDtls', 'part3Item13dDsclrContntDtls', 'rbPart3Item13eIsDsclosrSameForAll'], _first_across_rows(normalized_rows, ['rbPart3Item13EIsDsclosrSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item13aSegmntDtls', 'part3Item13dDsclrContntDtls', 'taPart3Item13dDsclosrContntDtls'], _first_across_rows(normalized_rows, ['taPart3Item13DDsclosrContntDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item14aCntrPrtySelectnDtls', 'part3Item14bSelectDtls'], 'rbPart3Item14bIsSelectnSameForAll', _first_across_rows(normalized_rows, ['part3Item14BSelectDtlsRbPart3Item14BIsSelectnSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item14aCntrPrtySelectnDtls', 'part3Item14bSelectDtls', 'taPart3Item14bSelectnDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item14BSelectnDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item15bSubSctbDtls', 'part3Item15cDsplyProcDtls'], 'rbPart3Item15cIsDsplyProcSameForAll', _first_across_rows(normalized_rows, ['part3Item15CDsplyProcDtlsRbPart3Item15CIsDsplyProcSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item15bSubSctbDtls', 'part3Item15cDsplyProcDtls', 'taPart3Item5cDsplyProcDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item5CDsplyProcDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item16aAffirInstrDtls', 'part3Item16bAffirmInstrDtls'], 'rbPart3Item16bIsRoutdBefrInstr', _first_across_rows(normalized_rows, ['part3Item16BAffirmInstrDtlsRbPart3Item16BIsRoutdBefrInstr']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item16aAffirInstrDtls', 'part3Item16bAffirmInstrDtls', 'taPart3Item16bAffirmInstrDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item16BAffirmInstrDiffDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item25aSubScrbrOrdrDtls', 'part3Item25bAccessDtls'], 'rbPart3Item25bIsCmplyRule301', _first_across_rows(normalized_rows, ['rbPart3Item25BIsCmplyRule301']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item25aSubScrbrOrdrDtls', 'part3Item25bAccessDtls', 'taPart3Item25biTickrSymbol'], _first_across_rows(normalized_rows, ['taPart3Item25BiTickrSymbol']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item25aSubScrbrOrdrDtls', 'part3Item25bAccessDtls', 'taPart3Item25biiDWrtnStndrds'], _first_across_rows(normalized_rows, ['taPart3Item25BiiDWrtnStndrds']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item2bSummaryOfConditions', 'part3Item2cSummaryOfConditions'], 'rbPart3Item2cIsConditionsSameForAll', _first_across_rows(normalized_rows, ['part3Item2CSummaryOfConditionsRbPart3Item2CIsConditionsSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item2bSummaryOfConditions', 'part3Item2cSummaryOfConditions', 'taPart3Item2cSummaryOfDifferences'], _first_across_rows(normalized_rows, ['taPart3Item2CSummaryOfDifferences']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item3aSumryOfExcludngCondtns', 'part3Item3bSummaryOfConditions'], 'rbPart3Item3bIsCondtnsSameForAll', _first_across_rows(normalized_rows, ['part3Item3BSummaryOfConditionsRbPart3Item3BIsCondtnsSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item3aSumryOfExcludngCondtns', 'part3Item3bSummaryOfConditions', 'taPart3Item3bSummaryOfDifferences'], _first_across_rows(normalized_rows, ['taPart3Item3BSummaryOfDifferences']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item5aProtocolDetails', 'part3Item5bProtocolDetails'], 'rbPart3Item5bIsProtclsameForAll', _first_across_rows(normalized_rows, ['part3Item5BProtocolDetailsRbPart3Item5BIsProtclsameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item5aProtocolDetails', 'part3Item5bProtocolDetails', 'taPart3Item5aProtocolSumryDtls'], _first_across_rows(normalized_rows, ['taPart3Item5AProtocolSumryDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item5cOthrDtls', 'part3Item5dTnCDetails'], 'rbPart3Item5dIsTnCSameForAll', _first_across_rows(normalized_rows, ['part3Item5DTnCDetailsRbPart3Item5DIsTnCSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item5cOthrDtls', 'part3Item5dTnCDetails', 'taPart3Item5dTnCSumryDtls'], _first_across_rows(normalized_rows, ['taPart3Item5DTnCSumryDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item6aProtocolDetails', 'part3Item6bTNCDetails'], 'rbPart3Item6bIsTNCsameForAll', _first_across_rows(normalized_rows, ['part3Item6BTncDetailsRbPart3Item6BIsTnCsameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item6aProtocolDetails', 'part3Item6bTNCDetails', 'taPart3Item6bTNCSumryDtls'], _first_across_rows(normalized_rows, ['taPart3Item6BTncSumryDtls']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item8aSizeReqrmnts', 'part3Item8bReqProcDetails'], 'rbPart3Item8bIsReqProcSameForAll', _first_across_rows(normalized_rows, ['part3Item8BReqProcDetailsRbPart3Item8BIsReqProcSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item8aSizeReqrmnts', 'part3Item8bReqProcDetails', 'taPart3Item8bDiffrncsInOtiReqrmnts'], _first_across_rows(normalized_rows, ['taPart3Item8BDiffrncsInOtiReqrmnts']))
    _add_path_attr(root, ['formData', 'partTwo', 'affiliatesPermittedToEnterInterest', 'part2Item2bAreSevicestoAfflSametoSubscribers'], 'rbPart2Item2bAreSevicestoAfflSametoSubscribers', _first_across_rows(normalized_rows, ['part2Item2BAreSevicestoAfflSametoSubscribersRbPart2Item2BAreSevicestoAfflSametoSubscribers']))
    _add_path_text(root, ['formData', 'partTwo', 'affiliatesPermittedToEnterInterest', 'part2Item2bAreSevicestoAfflSametoSubscribers', 'taPart2Item2bExplainDiff'], _first_across_rows(normalized_rows, ['taPart2Item2BExplainDiff']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item1aArePermittedToEnterInterest', 'part2Item1bAreSevicesSametoAllSubscribers'], 'rbPart2Item1bAreSevicesSametoAllSubscribers', _first_across_rows(normalized_rows, ['part2Item1BAreSevicesSametoAllSubscribersRbPart2Item1BAreSevicesSametoAllSubscribers']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item1aArePermittedToEnterInterest', 'part2Item1bAreSevicesSametoAllSubscribers', 'taPart2Item2bExplainDiff'], _first_across_rows(normalized_rows, ['part2Item1BAreSevicesSametoAllSubscribersTaPart2Item2BExplainDiff']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item5aDoesOfferProductsAndServices', 'part2Item5bAreSevicesSametoAllSubscribersAndBD'], 'rbPart2Item5bAreSevicesSametoAllSubscribersAndBD', _first_across_rows(normalized_rows, ['part2Item5BAreSevicesSametoAllSubscribersAndBdRbPart2Item5BAreSevicesSametoAllSubscribersAndBd']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item5aDoesOfferProductsAndServices', 'part2Item5bAreSevicesSametoAllSubscribersAndBD', 'taPart2Item5bExplainDiff'], _first_across_rows(normalized_rows, ['taPart2Item5BExplainDiff']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item6bDoesAnyEntitySupportServices', 'part2Item6cDoesServiceProviderUseATSServices'], 'rbPart2Item6cDoesServiceProviderUseATSServices', _first_across_rows(normalized_rows, ['part2Item6CDoesServiceProviderUseAtsServicesRbPart2Item6CDoesServiceProviderUseAtsServices']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item6bDoesAnyEntitySupportServices', 'part2Item6cDoesServiceProviderUseATSServices', 'rbPart2Item6dAreATSSevicesSametoAll'], _first_across_rows(normalized_rows, ['rbPart2Item6DAreAtsSevicesSametoAll']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item6bDoesAnyEntitySupportServices', 'part2Item6cDoesServiceProviderUseATSServices', 'taPart2Item6cProviderAfflAndServicesUsed'], _first_across_rows(normalized_rows, ['taPart2Item6CProviderAfflAndServicesUsed']))
    _add_path_attr(root, ['formData', 'partTwo', 'part2Item7bCanSubscriberConsentToDisclosure', 'part2Item7cCanSubscriberWithdrawConsent'], 'rbPart2Item7cCanSubscriberWithdrawConsent', _first_across_rows(normalized_rows, ['rbPart2Item7CCanSubscriberWithdrawConsent']))
    _add_path_text(root, ['formData', 'partTwo', 'part2Item7bCanSubscriberConsentToDisclosure', 'part2Item7cCanSubscriberWithdrawConsent', 'taPart2Item7cExplainHowAndConditions'], _first_across_rows(normalized_rows, ['taPart2Item7CExplainHowAndConditions']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'ccc'], _first_across_rows(normalized_rows, ['ccc']))
    _add_path_text(root, ['headerData', 'filerInfo', 'filer', 'filerCredentials', 'cik'], _first_across_rows(normalized_rows, ['cik']))
    _add_path_attr(root, ['formData', 'partThree', 'part3Item13aSegmntDtls', 'part3Item13dDsclrContntDtls', 'part3Item13eArngmntDtls'], 'rbPart3Item13eIsDsclosrSameForAll', _first_across_rows(normalized_rows, ['part3Item13EArngmntDtlsRbPart3Item13EIsDsclosrSameForAll']))
    _add_path_text(root, ['formData', 'partThree', 'part3Item13aSegmntDtls', 'part3Item13dDsclrContntDtls', 'part3Item13eArngmntDtls', 'taPart3Item13eDsclosrDiffDtls'], _first_across_rows(normalized_rows, ['taPart3Item13EDsclosrDiffDtls']))
    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')

    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')
