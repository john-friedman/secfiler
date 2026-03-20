# SEC Filer

This is an experimental package suggested by a compliance officer at a trading firm. User inputs a list of dicts, and gets out the formatted document as expected by the SEC. User is responsible for validating correctness. This is an open source package.

Features

- Map csvs into SEC compliant XML. Supports all SEC XML files.

## Quickstart

See [xml schema](xml_schema.md) for how to feed data into `constructdocument()`.

```python
from secfiler import construct_document

rows = [
  {"footnoteText": "Contributions to non-profit organizations.", "footnoteId": "F1", "_table": "345_footnote"},
  {"aff10B5One": "0", "documentType": "4", "notSubjectToSection16": "0", "periodOfReport": "2025-08-28", "remarks": None, "schemaVersion": "X0508", "issuerCik": "0001018724", "issuerName": "AMAZON COM INC", "issuerTradingSymbol": "AMZN", "_table": "345"},
  {"signatureDate": "2025-09-02", "signatureName": "/s/ PAUL DAUBER, attorney-in-fact for Jeffrey P. Bezos, Executive Chair", "_table": "345_owner_signature"},
  {"rptOwnerCity": "SEATTLE", "rptOwnerState": "WA", "rptOwnerStateDescription": None, "rptOwnerStreet1": "P.O. BOX 81226", "rptOwnerStreet2": None, "rptOwnerZipCode": "98108-1226", "rptOwnerCik": "0001043298", "rptOwnerName": "BEZOS JEFFREY P", "isDirector": "1", "isOfficer": "1", "isOther": "0", "isTenPercentOwner": "0", "officerTitle": "Executive Chair", "_table": "345_reporting_owner"},
  {"securityTitleValue": "Common Stock, par value $.01  per share", "equitySwapInvolved": "0", "transactionCode": "G", "transactionFormType": "4", "transactionDateValue": "2025-08-28", "directOrIndirectOwnershipValue": "D", "sharesOwnedFollowingTransactionValue": "883258188", "transactionAcquiredDisposedCodeValue": "D", "transactionPricePerShareValue": "0", "transactionSharesValue": "421693", "transactionCodingFootnoteIdId": "F1", "_table": "345_non_derivative_transaction"},
]

xml_bytes = construct_document(rows, '4')
with open('bezosform4.xml', 'wb') as f:
            f.write(xml_bytes)
```

## Notes

- This repository was open sourced to support the development of filing software startups. The following repository may also be of interest to such startups: [Reverse Engineering Columnar Mappings of all SEC XML Files
](https://github.com/john-friedman/Reverse-Engineering-Columnar-Mappings-of-all-SEC-XML-Files/tree/master).
- This repository will get better over time, but the primary goal is as a MVP that allows early stage startups *cough* *cough* *yc*, to quickly validate their ideas.
- This was vibe coded with a harness. That is because the code is the easy part. The difficult part is calculating every xpath. That required 1. hosting an archive of every SEC filing and 2. computing the paths using ec2 instances. Thank you to OpenAI for the free credits.
- There is a comment string: '<!--XML file created with secfiler: https://github.com/john-friedman/secfiler-->' attached to each file. 

## Future improvements

- Use a harness with https://www.sec.gov/submit-filings/technical-specifications to further refine using offical documentation. Not all xml files are covered by the docs.