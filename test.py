from datamule import Submission, Sheet, format_accession
from secfiler import construct_document

sub = Submission(url='https://www.sec.gov/Archives/edgar/data/1318605/000110465925089693/0001104659-25-089693.txt')
document_type = '4'

for doc in sub:
    if doc.extension in '.xml':
        with open('original.xml', 'wb') as f:
            f.write(doc.content)

        rows = []
        for table in doc.tables:
            print(table)
            table_name = str(getattr(table, "name", "") or "")
            for row in (table.data or []):
                normalized_row = dict(row) if not isinstance(row, dict) else dict(row)
                if table_name and "table" not in normalized_row:
                    normalized_row["table"] = table_name
                rows.append(normalized_row)

        if not rows and doc.tables:
            rows = doc.tables[0].data or []

        print(f"Using {len(rows)} rows across matching tables for {document_type}.")
        result = construct_document(rows, document_type)
        
        with open('new.xml', 'wb') as f:
            f.write(result)
