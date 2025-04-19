#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup
import sys, urllib.parse

raw_cmd = " ".join(sys.argv[1:])
cmd = urllib.parse.quote(raw_cmd)
url = "https://explainshell.com/explain?cmd=" + cmd

r = requests.get(url)
if not r.ok:
    sys.exit("Failed to fetch explanation.")

soup = BeautifulSoup(r.text, 'html.parser')

# Find all <pre class="help-box"> elements
blocks = soup.find_all('pre', class_='help-box')

if not blocks:
    sys.exit("No explanation found.")

cmd_name = raw_cmd.split(" ")[0]
print(f".TH {cmd_name.upper()} 1 \"{cmd_name.lower()}\"")
print(".SH NAME")
print(f"{raw_cmd} \\- extracted from explainshell.com")
print(".SH SYNOPSIS")
print(raw_cmd)
print(".SH DESCRIPTION")

for block in blocks:
    text = block.get_text(strip=True, separator=" ")
    # Clean up HTML tags and format explanations for manpage
    clean_text = text.replace('<b>', '').replace('</b>', '').replace('\n', '\n.br\n')
    print(".TP")
    print(clean_text)
