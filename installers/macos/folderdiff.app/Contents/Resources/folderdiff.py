#!/usr/bin/env python3
"""FolderDiff — show which files differ between two folders."""
import sys, hashlib
from pathlib import Path

def snapshot(d):
    out = {}
    for f in Path(d).rglob("*"):
        if f.is_file():
            out[str(f.relative_to(d))] = hashlib.md5(f.read_bytes()).hexdigest()
    return out

def diff(a, b):
    sa, sb = snapshot(a), snapshot(b)
    return (sorted(set(sa) - set(sb)), sorted(set(sb) - set(sa)),
            sorted(k for k in sa.keys() & sb.keys() if sa[k] != sb[k]))

if __name__ == "__main__":
    only_a, only_b, changed = diff(sys.argv[1], sys.argv[2])
    for x in only_a: print("only in A:", x)
    for x in only_b: print("only in B:", x)
    for x in changed: print("changed:", x)
