# SEC Filer (not ready for use)

This is an experimental package suggested by a compliance officer at a trading firm. User inputs a csv, and gets out the formatted document as expected by the SEC.

User is responsible for validating correctness. This is an open source package.

Features

- Map csvs into SEC compliant XML. Supports all SEC XML files.

## Quickstart

```python
construct_document(input_file='13fhr/information_table.csv', output_file='information_table_new.xml', document_type='INFORMATION TABLE')
```

## Notes

- This repository was open sourced to support the development of filing software startups. The following repository may also be of interest to such startups: [Reverse Engineering Columnar Mappings of all SEC XML Files
](https://github.com/john-friedman/Reverse-Engineering-Columnar-Mappings-of-all-SEC-XML-Files/tree/master).
- This repository will get better over time, but the primary goal is as a MVP that allows early stage startups *cough* *cough* *yc*, to quickly validate their ideas.
- This was vibe coded with a harness. That is because the code is the easy part. The difficult part is calculating every xpath. That required 1. hosting an archive of every SEC filing and 2. computing the paths using ec2 instances. Thank you to OpenAI for the free credits.
- There is a comment string: '<!--XML file created with secfiler: https://github.com/john-friedman/secfiler-->' attached to each file. 