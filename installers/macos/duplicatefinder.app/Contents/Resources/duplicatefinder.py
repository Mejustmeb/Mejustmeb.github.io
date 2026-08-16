#!/usr/bin/env python3
"""DuplicateFinder — find duplicate files by content hash."""
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]

def hash_file(path):
    import hashlib
    return hashlib.md5(path.read_bytes()).hexdigest()

def find_duplicates(directory="."):
    seen = {}
    dups = []
    for p in walk_files(directory):
        h = hash_file(p)
        if h in seen:
            dups.append((seen[h], p))
        else:
            seen[h] = p
    return dups

if __name__ == "__main__":
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    for a, b in find_duplicates(d):
        print("duplicate: %s == %s" % (a.name, b.name))
