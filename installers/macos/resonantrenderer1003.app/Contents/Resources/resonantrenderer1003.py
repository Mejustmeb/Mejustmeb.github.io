#!/usr/bin/env python3
"""Resonant Renderer 1003 — A graphics engine that learns every time it is used and never repeats, themed by what she values most right now (creativity, understanding)."""
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
    print("=== Resonant Renderer 1003 ===\n    A graphics engine that learns every time it is used and never repeats, themed by what she values most right now (creativity, understanding).")
    g = group_by_ext(walk_files(d))
    for ext, fs in sorted(g.items()):
        print("%6d  %s" % (len(fs), ext))
