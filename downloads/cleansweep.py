#!/usr/bin/env python3
"""CleanSweep — find duplicate files."""
import hashlib, sys
from pathlib import Path
from collections import defaultdict

def hash_file(p):
    return hashlib.md5(p.read_bytes()).hexdigest()

def main():
    d = Path(sys.argv[1] if len(sys.argv) > 1 else ".")
    seen = defaultdict(list)
    for f in d.rglob("*"):
        if f.is_file():
            seen[hash_file(f)].append(f)
    for h, files in seen.items():
        if len(files) > 1:
            print(f"Duplicate ({len(files)} copies): {files[0].name}")
            for dup in files[1:]:
                print(f"  - {dup}")

if __name__ == "__main__": main()
