#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""MergeFiles — concatenate text files into one output file."""
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]

def merge(directory, outfile):
    from pathlib import Path
    parts = []
    for p in sorted(walk_files(directory)):
        parts.append(p.read_text(errors="ignore"))
    Path(outfile).write_text(chr(10).join(parts))
    return len(parts)

if __name__ == "__main__":
    d = sys.argv[1]
    out = sys.argv[2] if len(sys.argv) > 2 else "merged.txt"
    print("merged %d files into %s" % (merge(d, out), out))
