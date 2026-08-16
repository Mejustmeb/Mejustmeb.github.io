#!/usr/bin/env python3
"""DateReport — list files in a folder sorted by last-modified date."""
import sys
import time

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]

def sort_by_mtime(files, reverse=True):
    return sorted(files, key=lambda p: p.stat().st_mtime, reverse=reverse)

if __name__ == "__main__":
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    for p in sort_by_mtime(walk_files(d)):
        print("%s  %s" % (time.strftime("%Y-%m-%d", time.localtime(p.stat().st_mtime)), p.name))
