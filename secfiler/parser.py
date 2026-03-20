from .parsers.effect import construct_effect
from .parsers.ctr import construct_ctr
from .parsers.f24f2nt import construct_24f2nt
from .parsers.coverpage import construct_cover_page
from .parsers.c import construct_c
from .parsers.cfportal import construct_cfportal
from .parsers.d import construct_d
from .parsers.dos import construct_dos
from .parsers.ex102 import construct_ex102
from .parsers.ex103 import construct_ex103
from .parsers.form4 import construct_form4
from .parsers.f345 import construct_345
from .parsers.form144 import construct_144
from .parsers.informationtable import construct_information_table
from .parsers.ma import construct_ma
from .parsers.mai import construct_mai
from .parsers.maw import construct_maw
from .parsers.ncen import construct_ncen
from .parsers.nse25 import construct_25nse
from .parsers.nmfp import construct_nmfp
from .parsers.nmfp1 import construct_nmfp1
from .parsers.nmfp2 import construct_nmfp2
from .parsers.nmfp3 import construct_nmfp3
from .parsers.nportp import construct_nportp
from .parsers.onek import construct_1k
from .parsers.onea import construct_1a
from .parsers.onez import construct_1z
from .parsers.npx import construct_npx
from .parsers.ncr import construct_ncr
from .parsers.proxyvotingrecord import construct_proxy_voting_record
from .parsers.qualif import construct_qualif
from .parsers.schedule13d import construct_schedule13d
from .parsers.schedule13g import construct_schedule13g
from .parsers.sher import construct_sher
from .parsers.sdr import construct_sdr
from .parsers.sbse import construct_sbse
from .parsers.ta1 import construct_ta1
from .parsers.ta2 import construct_ta2
from .parsers.taw import construct_taw
from .parsers.thirteenfhr import construct_13fhr
from .parsers.atsnua import construct_atsn_ua
from .parsers.x17a5 import construct_x17a5


def _normalize_doc_type(doc_type: str) -> str:
    normalized = str(doc_type or "").strip().upper()
    return " ".join(normalized.split())


_DOC_TYPE_ALIASES = {
    "INFORMATION TABLE": "INFORMATION TABLE",
    "QUALIF": "QUALIF",
    "EFFECT": "EFFECT",
    "25-NSE": "25-NSE",
    "25-NSE/A": "25-NSE",
    "C-TR": "C-TR",
    "C-TR-W": "C-TR",
    "X-17A-5": "X-17A-5",
    "X-17A-5/A": "X-17A-5",
    "1-K": "1-K",
    "1-K/A": "1-K",
    "D": "D",
    "D/A": "D",
    "N-PX": "N-PX",
    "N-PX/A": "N-PX",
    "144": "144",
    "144/A": "144",
    "SCHEDULE 13D": "SCHEDULE 13D",
    "SCHEDULE 13D/A": "SCHEDULE 13D",
    "SCHEDULE 13G": "SCHEDULE 13G",
    "SCHEDULE 13G/A": "SCHEDULE 13G",
    "1-Z": "1-Z",
    "1-Z/A": "1-Z",
    "1-A": "1-A",
    "1-A/A": "1-A",
    "1-A POS": "1-A",
    "DOS": "DOS",
    "DOS/A": "DOS",
    "13F-HR": "13F-HR",
    "13F-HR/A": "13F-HR",
    "13F-NT": "13F-HR",
    "13F-NT/A": "13F-HR",
    "PROXY VOTING RECORD": "PROXY VOTING RECORD",
    "COVER PAGE": "COVER PAGE",
    "N-CR": "N-CR",
    "24F-2NT": "24F-2NT",
    "24F-2NT/A": "24F-2NT",
    "SH-ER": "SH-ER",
    "SDR": "SDR",
    "SDR/A": "SDR",
    "CFPORTAL": "CFPORTAL",
    "CFPORTAL/A": "CFPORTAL",
    "CFPORTAL-W": "CFPORTAL",
    "EX-103": "EX-103",
    "EX-102": "EX-102",
    "4": "4",
    "4/A": "345",
    "3": "345",
    "3/A": "345",
    "5": "345",
    "5/A": "345",
    "MA-I": "MA-I",
    "MA-I/A": "MA-I",
    "NPORT-P": "NPORT-P",
    "NPORT-P/A": "NPORT-P",
    "TA-2": "TA-2",
    "TA-2/A": "TA-2",
    "N-MFP2": "N-MFP2",
    "N-MFP2/A": "N-MFP2",
    "C-U": "C",
    "C-U-W": "C",
    "TA-1": "TA-1",
    "TA-1/A": "TA-1",
    "N-CEN": "N-CEN",
    "N-CEN/A": "N-CEN",
    "N-MFP": "N-MFP",
    "N-MFP/A": "N-MFP",
    "MA": "MA",
    "MA/A": "MA",
    "MA-A": "MA",
    "MA-W": "MA-W",
    "C/A": "C",
    "C/A-W": "C",
    "C-W": "C",
    "C-AR/A": "C",
    "C-AR-W": "C",
    "C-AR": "C",
    "C": "C",
    "N-MFP1": "N-MFP1",
    "N-MFP1/A": "N-MFP1",
    "N-MFP3": "N-MFP3",
    "N-MFP3/A": "N-MFP3",
    "TA-W": "TA-W",
    "ATS-N/UA": "ATS-N/UA",
    "ATS-N-W": "ATS-N/UA",
    "ATS-N-C": "ATS-N/UA",
    "ATS-N/OFA": "ATS-N/UA",
    "ATS-N/CA": "ATS-N/UA",
    "ATS-N/MA": "ATS-N/UA",
    "SBSE-C": "SBSE",
    "SBSE": "SBSE",
    "SBSE/A": "SBSE",
    "SBSE-A": "SBSE",
    "SBSE-A/A": "SBSE",
    "SBSE-BD": "SBSE",
    "SBSE-BD/A": "SBSE",
    "SBSE-W": "SBSE",
    "SBSEF": "SBSE",
    "SBSEF/A": "SBSE",
    "SBSEF-W": "SBSE",
}


def _canonical_doc_type(doc_type: str) -> str:
    normalized = _normalize_doc_type(doc_type)
    return _DOC_TYPE_ALIASES.get(normalized, normalized)


def construct_document(rows: list, doc_type: str) -> bytes:
    normalized_type = _normalize_doc_type(doc_type)
    canonical_type = _canonical_doc_type(doc_type)

    specialized_constructors = {
        "QUALIF": construct_qualif,
        "INFORMATION TABLE": construct_information_table,
        "EFFECT": construct_effect,
        "25-NSE": construct_25nse,
        "C-TR": construct_ctr,
        "D": construct_d,
        "DOS": construct_dos,
        "X-17A-5": construct_x17a5,
        "1-K": construct_1k,
        "N-PX": construct_npx,
        "N-CR": construct_ncr,
        "PROXY VOTING RECORD": construct_proxy_voting_record,
        "COVER PAGE": construct_cover_page,
        "24F-2NT": construct_24f2nt,
        "SH-ER": construct_sher,
        "SDR": construct_sdr,
        "CFPORTAL": construct_cfportal,
        "EX-103": construct_ex103,
        "EX-102": construct_ex102,
        "4": construct_form4,
        "345": construct_345,
        "MA-I": construct_mai,
        "NPORT-P": construct_nportp,
        "TA-2": construct_ta2,
        "N-MFP2": construct_nmfp2,
        "C": construct_c,
        "TA-1": construct_ta1,
        "N-CEN": construct_ncen,
        "N-MFP": construct_nmfp,
        "MA": construct_ma,
        "MA-W": construct_maw,
        "N-MFP1": construct_nmfp1,
        "N-MFP3": construct_nmfp3,
        "TA-W": construct_taw,
        "ATS-N/UA": construct_atsn_ua,
        "SBSE": construct_sbse,
        "SCHEDULE 13D": construct_schedule13d,
        "SCHEDULE 13G": construct_schedule13g,
        "1-Z": construct_1z,
        "13F-HR": construct_13fhr,
        "144": construct_144,
        "1-A": construct_1a,
    }

    constructor = specialized_constructors.get(canonical_type)
    if constructor is not None:
        return constructor(rows or [])

    if normalized_type not in _DOC_TYPE_ALIASES:
        supported = ", ".join(sorted(_DOC_TYPE_ALIASES))
        alias_note = ""
        if normalized_type != canonical_type:
            alias_note = f" Alias resolved '{normalized_type}' -> '{canonical_type}'."
        raise NotImplementedError(
            f"Unsupported doc_type '{doc_type}' (canonical: '{canonical_type}'). "
            f"Supported types: {supported}.{alias_note}"
        )

    # If alias exists but no mapping/constructor, this indicates a wiring gap.
    raise NotImplementedError(
        f"Doc type '{doc_type}' resolves to '{canonical_type}', but no constructor is wired."
    )
