#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""LogLens — find errors and patterns in log files."""
import sys, re
from collections import Counter
from pathlib import Path

USAGE = "usage: loglens.py <logfile>\n\nSummarize error/exception/fail/critical lines in a log file."

def main():
    if len(sys.argv) < 2 or sys.argv[1] in ("--help", "-h"):
        print(USAGE)
        return
    f = Path(sys.argv[1])
    if not f.exists():
        print(f"error: no such file: {sys.argv[1]}")
        sys.exit(1)
    errors = Counter()
    pattern = re.compile(r'(?i)(error|exception|fail|critical)')
    for line in f.read_text(errors='ignore').splitlines():
        m = pattern.search(line)
        if m:
            errors[m.group(1).lower()] += 1
    if not errors:
        print("No error lines found.")
        return
    for k, v in errors.most_common():
        print(f"{k}: {v}")
    print(f"Total error lines: {sum(errors.values())}")

if __name__ == "__main__":
    main()
