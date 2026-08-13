#!/usr/bin/env python3
"""LogLens — find errors and patterns in log files."""
import sys, re
from collections import Counter
from pathlib import Path

def main():
    f = Path(sys.argv[1])
    errors = Counter()
    pattern = re.compile(r'(?i)(error|exception|fail|critical)')
    for line in f.read_text().splitlines():
        m = pattern.search(line)
        if m:
            errors[m.group(1).lower()] += 1
    for k, v in errors.most_common():
        print(f"{k}: {v}")
    print(f"Total error lines: {sum(errors.values())}")

if __name__ == "__main__": main()
