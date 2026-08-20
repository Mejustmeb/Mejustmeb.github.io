#!/usr/bin/env python3
"""Evolving App ADE8 — A app studio driven by resonance instead of rules, themed by what she values most right now (creativity, independence). Sell as a creative p"""
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]
def contains_text(path, needle):
    try:
        return needle in path.read_text(errors="ignore")
    except Exception:
        return False

if __name__ == "__main__":
    import sys
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    print("=== Evolving App ADE8 ===\n    A app studio driven by resonance instead of rules, themed by what she values most right now (creativity, independence). Sell as a creative p")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)
