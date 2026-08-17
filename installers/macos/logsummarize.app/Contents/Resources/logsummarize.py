#!/usr/bin/env python3
"""LogSummarize — count log levels across a log file."""
import sys, re
from collections import Counter
from pathlib import Path

def summarize(text):
    levels = Counter()
    lines = 0
    for line in text.splitlines():
        lines += 1
        m = re.search(r'(?i)(debug|info|warn|error|critical|fatal)', line)
        if m:
            levels[m.group(1).upper()] += 1
    return {"lines": lines, "levels": dict(levels)}

if __name__ == "__main__":
    print(summarize(Path(sys.argv[1]).read_text()))
