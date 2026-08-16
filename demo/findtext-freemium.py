#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""FindText — search for a string across files (grep-like)."""
import sys
from pathlib import Path

def find(needle, directory="."):
    hits = []
    for f in Path(directory).rglob("*"):
        if f.is_file():
            try:
                if needle in f.read_text(errors="ignore"):
                    hits.append(str(f))
            except Exception:
                pass
    return hits

if __name__ == "__main__":
    needle = sys.argv[1]
    d = sys.argv[2] if len(sys.argv) > 2 else "."
    for h in find(needle, d):
        print(h)
