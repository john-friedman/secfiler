#!/usr/bin/env python3
"""
Downloads all "full specs" files from the SEC EDGAR technical specifications page.
"""

import os
import re
import time
import gzip
import urllib.request
import urllib.parse

BASE_URL  = "https://www.sec.gov"
PAGE_URL  = f"{BASE_URL}/submit-filings/technical-specifications"
OUT_DIR   = "sec_specs"
DELAY     = 0.3  # seconds between requests

HEADERS = {
    "User-Agent": "YourCompanyName your@email.com",  # <-- required by SEC
    "Accept-Encoding": "gzip, deflate",
    "Accept": "text/html,*/*",
    "Host": "www.sec.gov",
}


def fetch(url, is_index=False):
    req = urllib.request.Request(url, headers=HEADERS)
    with urllib.request.urlopen(req, timeout=30) as resp:
        status = resp.status
        if status != 200:
            raise RuntimeError(f"HTTP {status} for {url}")

        data = resp.read()

        # SEC sends gzip even when you don't explicitly ask
        if resp.headers.get("Content-Encoding") == "gzip" or data[:2] == b"\x1f\x8b":
            data = gzip.decompress(data)

        if not data:
            raise RuntimeError(f"Empty response from {url}")

        if is_index:
            text = data.decode("utf-8", errors="replace")
            if "full specs" not in text.lower():
                raise RuntimeError(
                    f"Page doesn't look right — 'full specs' not found.\n"
                    f"First 500 chars:\n{text[:500]}"
                )
            print(f"  Got index page: {len(text):,} chars")
            return text

        return data


def get_spec_links(html):
    links = []
    seen  = set()

    # Links look like: <a href="/files/...zip">full specs</a>
    for m in re.finditer(r'href="([^"]+)"[^>]*>\s*full spec', html, re.IGNORECASE):
        url = m.group(1)
        if not url.startswith("http"):
            url = BASE_URL + url
        if url not in seen:
            seen.add(url)
            links.append(url)

    return links


def download(url, out_dir):
    filename = os.path.basename(urllib.parse.urlparse(url).path)
    dest     = os.path.join(out_dir, filename)

    if os.path.exists(dest):
        print(f"  skip {filename} (exists)")
        return dest

    data = fetch(url)
    with open(dest, "wb") as f:
        f.write(data)
    print(f"  saved {dest} ({len(data):,} bytes)")
    return dest


def main():
    os.makedirs(OUT_DIR, exist_ok=True)

    print(f"Fetching {PAGE_URL}")
    html = fetch(PAGE_URL, is_index=True)
    time.sleep(DELAY)

    links = get_spec_links(html)
    if not links:
        raise RuntimeError("No 'full specs' links found — page structure may have changed.")

    print(f"\nFound {len(links)} files:\n")
    for url in links:
        print(f"  {url}")

    print()
    saved, failed = [], []
    for i, url in enumerate(links, 1):
        print(f"[{i}/{len(links)}] {os.path.basename(url)}")
        try:
            saved.append(download(url, OUT_DIR))
        except Exception as e:
            print(f"  ERROR: {e}")
            failed.append(url)
        if i < len(links):
            time.sleep(DELAY)

    print(f"\nDone: {len(saved)} saved, {len(failed)} failed")
    for url in failed:
        print(f"  FAILED: {url}")


if __name__ == "__main__":
    main()