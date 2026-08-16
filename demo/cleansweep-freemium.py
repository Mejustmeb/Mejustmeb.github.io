#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""CleanSweep — find duplicate files."""
import hashlib, sys
from pathlib import Path
from collections import defaultdict

USAGE = "usage: cleansweep.py [folder]\n\nFind duplicate files in a folder tree."

def hash_file(p):
    return hashlib.md5(p.read_bytes()).hexdigest()

def main():
    if "-h" in sys.argv or "--help" in sys.argv:
        print(USAGE); return
    d = Path(sys.argv[1] if len(sys.argv) > 1 else ".")
    if not d.is_dir():
        print(f"error: not a directory: {d}"); sys.exit(1)
    seen = defaultdict(list)
    for f in d.rglob("*"):
        try:
            if f.is_file():
                seen[hash_file(f)].append(f)
        except OSError:
            pass
    found = 0
    for h, files in seen.items():
        if len(files) > 1:
            found += 1
            print(f"Duplicate ({len(files)} copies): {files[0].name}")
            for dup in files[1:]:
                print(f"  - {dup}")
    print(f"Total duplicate groups: {found}")

if __name__ == "__main__":
    main()
