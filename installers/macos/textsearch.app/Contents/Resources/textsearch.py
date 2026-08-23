#!/usr/bin/env python3
"""TextSearch — find a string across files in a folder."""
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]

def contains_text(path, needle):
    try:
        return needle in path.read_text(errors="ignore")
    except Exception:
        return False

def search(needle, directory="."):
    return [str(p) for p in walk_files(directory) if contains_text(p, needle)]

if __name__ == "__main__":
    needle = sys.argv[1]
    d = sys.argv[2] if len(sys.argv) > 2 else "."
    for hit in search(needle, d):
        print(hit)
