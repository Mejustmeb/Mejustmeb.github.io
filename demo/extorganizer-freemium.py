#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""ExtOrganizer — move files into subfolders by extension."""
import shutil
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

def organize(directory="."):
    from pathlib import Path
    d = Path(directory)
    moved = 0
    groups = group_by_ext(walk_files(d))
    for ext, files in groups.items():
        if ext == "(none)":
            continue
        folder = d / ext.lstrip(".")
        folder.mkdir(exist_ok=True)
        for f in files:
            shutil.move(str(f), str(folder / f.name))
            moved += 1
    return moved

if __name__ == "__main__":
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    print("moved %d files" % organize(d))
