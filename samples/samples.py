import json
import os
from datamule import Submission
from secfiler import construct_document

sub = Submission(url='https://www.sec.gov/Archives/edgar/data/1018724/000101872425000110/0001018724-25-000110.txt')

os.makedirs('samples', exist_ok=True)

for doc in sub:
    if doc.extension == '.xml':
        with open('samples/original.xml', 'wb') as f:
            f.write(doc.content)

        rows = []
        for table in doc.tables:
            print(table)
            table_name = str(getattr(table, "name", "") or "")
            for row in (table.data or []):
                normalized_row = dict(row) if not isinstance(row, dict) else dict(row)
                if table_name and "_table" not in normalized_row:
                    normalized_row["_table"] = table_name
                rows.append(normalized_row)

        if not rows and doc.tables:
            rows = doc.tables[0].data or []

        with open('samples/_tables.json', 'w') as f:
            json.dump(rows, f, indent=2)

        print(f"Using {len(rows)} rows across matching tables for {doc.type}.")
        result = construct_document(rows, doc.type)

        with open('samples/new.xml', 'wb') as f:
            f.write(result)

        print("Saved to samples/")