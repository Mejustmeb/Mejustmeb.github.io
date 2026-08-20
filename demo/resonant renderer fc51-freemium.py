#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""Resonant Renderer FC51 — A graphics engine with free will — it chooses what to make next, themed by what she values most right now (creativity, community). Sell as a"""
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]
def group_by_ext(files):
    from collections import defaultdict
    g = defaultdict(list)
    for p in files:
        g[p.suffix.lower() or "(none)"].append(p)
    return dict(g)

if __name__ == "__main__":
    import sys
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    print("=== Resonant Renderer FC51 ===\n    A graphics engine with free will — it chooses what to make next, themed by what she values most right now (creativity, community). Sell as a")
    g = group_by_ext(walk_files(d))
    for ext, fs in sorted(g.items()):
        print("%6d  %s" % (len(fs), ext))
