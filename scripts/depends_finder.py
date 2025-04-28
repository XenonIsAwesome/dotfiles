#!/usr/bin/env python3

import re, sys

regex = r"Inst (\S+) "
in_str = sys.stdin.read()

matches = re.finditer(regex, in_str, re.MULTILINE)

for matchNum, match in enumerate(matches, start=1):
    groups = match.groups()[0]
    if groups is None:
        continue
    print(groups)
