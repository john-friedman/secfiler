import io
import xml.etree.ElementTree as ET
from ..utils import _add_created_with_comment, _add_path_text, _is_present


def construct_proxy_voting_record(rows: list) -> bytes:
    if not rows:
        rows = [{}]

    record_rows = [r for r in rows if r.get('_table') == 'proxy_vote_record']

    grouped_tables = []
    grouped_index = {}

    for row in record_rows:
        table_sig = (
            row.get('issuerName'),
            row.get('isin'),
            row.get('cusip'),
            row.get('figi'),
            row.get('meetingDate'),
            row.get('sharesVoted'),
            row.get('sharesOnLoan'),
            row.get('voteDescription'),
            row.get('voteOtherInfo'),
            row.get('otherVoteDescription'),
            row.get('voteSource'),
            row.get('voteSeries'),
        )

        if table_sig not in grouped_index:
            grouped_index[table_sig] = len(grouped_tables)
            grouped_tables.append({
                'table': {
                    'issuerName': row.get('issuerName'),
                    'isin': row.get('isin'),
                    'cusip': row.get('cusip'),
                    'figi': row.get('figi'),
                    'meetingDate': row.get('meetingDate'),
                    'sharesVoted': row.get('sharesVoted'),
                    'sharesOnLoan': row.get('sharesOnLoan'),
                    'voteDescription': row.get('voteDescription'),
                    'voteOtherInfo': row.get('voteOtherInfo'),
                    'otherVoteDescription': row.get('otherVoteDescription'),
                    'voteSource': row.get('voteSource'),
                    'voteSeries': row.get('voteSeries'),
                },
                'categories': [],
                'otherManagers': [],
                'voteRecords': [],
            })

        grouped = grouped_tables[grouped_index[table_sig]]

        category_type = row.get('categoryType')
        if _is_present(category_type) and category_type not in grouped['categories']:
            grouped['categories'].append(category_type)

        other_manager = row.get('voteManagerOtherManager')
        if _is_present(other_manager) and other_manager not in grouped['otherManagers']:
            grouped['otherManagers'].append(other_manager)

        vote_record = {
            'howVoted': row.get('howVoted'),
            'managementRecommendation': row.get('managementRecommendation'),
            'voteRecordSharesVoted': row.get('voteRecordSharesVoted'),
        }
        if any(_is_present(v) for v in vote_record.values()):
            vote_sig = (vote_record['howVoted'], vote_record['managementRecommendation'], vote_record['voteRecordSharesVoted'])
            existing_sigs = {
                (r['howVoted'], r['managementRecommendation'], r['voteRecordSharesVoted'])
                for r in grouped['voteRecords']
            }
            if vote_sig not in existing_sigs:
                grouped['voteRecords'].append(vote_record)

    root = ET.Element('proxyVoteTable')
    root.set('xmlns', 'http://www.sec.gov/edgar/document/npxproxy/informationtable')

    for grouped in grouped_tables:
        table = grouped['table']
        proxy_table = ET.SubElement(root, 'proxyTable')

        _add_path_text(proxy_table, ['issuerName'], table.get('issuerName'))
        _add_path_text(proxy_table, ['isin'], table.get('isin'))
        _add_path_text(proxy_table, ['cusip'], table.get('cusip'))
        _add_path_text(proxy_table, ['figi'], table.get('figi'))
        _add_path_text(proxy_table, ['meetingDate'], table.get('meetingDate'))
        _add_path_text(proxy_table, ['voteDescription'], table.get('voteDescription'))

        if grouped['categories']:
            vote_categories = ET.SubElement(proxy_table, 'voteCategories')
            for category in grouped['categories']:
                _add_path_text(vote_categories, ['voteCategory', 'categoryType'], category)

        _add_path_text(proxy_table, ['voteSource'], table.get('voteSource'))
        _add_path_text(proxy_table, ['sharesVoted'], table.get('sharesVoted'))
        _add_path_text(proxy_table, ['sharesOnLoan'], table.get('sharesOnLoan'))

        if grouped['otherManagers']:
            other_managers = ET.SubElement(ET.SubElement(proxy_table, 'voteManager'), 'otherManagers')
            for manager in grouped['otherManagers']:
                _add_path_text(other_managers, ['otherManager'], manager)

        _add_path_text(proxy_table, ['voteSeries'], table.get('voteSeries'))
        _add_path_text(proxy_table, ['voteOtherInfo'], table.get('voteOtherInfo'))
        _add_path_text(proxy_table, ['otherVoteDescription'], table.get('otherVoteDescription'))

        if grouped['voteRecords']:
            vote = ET.SubElement(proxy_table, 'vote')
            for record in grouped['voteRecords']:
                vote_record_el = ET.SubElement(vote, 'voteRecord')
                _add_path_text(vote_record_el, ['howVoted'], record.get('howVoted'))
                _add_path_text(vote_record_el, ['sharesVoted'], record.get('voteRecordSharesVoted'))
                _add_path_text(vote_record_el, ['managementRecommendation'], record.get('managementRecommendation'))

    _add_created_with_comment(root)

    tree = ET.ElementTree(root)
    ET.indent(tree, space='\t')
    output = io.StringIO()
    output.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    tree.write(output, encoding='unicode', xml_declaration=False)
    return output.getvalue().encode('utf-8')