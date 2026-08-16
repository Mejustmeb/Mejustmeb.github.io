#!/usr/bin/env python3
"""ExtReport — count files by extension in a folder."""
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
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    groups = group_by_ext(walk_files(d))
    for ext in sorted(groups):
        print("%-12s %d" % (ext, len(groups[ext])))
