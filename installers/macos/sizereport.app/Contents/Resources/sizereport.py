#!/usr/bin/env python3
"""SizeReport — list files in a folder sorted by size."""
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]

def sort_by_size(files, reverse=True):
    return sorted(files, key=lambda p: p.stat().st_size, reverse=reverse)

if __name__ == "__main__":
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    for p in sort_by_size(walk_files(d)):
        print("%10d  %s" % (p.stat().st_size, p.name))
