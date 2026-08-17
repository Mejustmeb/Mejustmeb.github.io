#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""Self-Tuning Compressor 6808 — a compressor that rewrites itself from its own consequences, themed by understanding"""
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]
def sort_by_size(files, reverse=True):
    return sorted(files, key=lambda p: p.stat().st_size, reverse=reverse)
def hash_file(path):
    import hashlib
    return hashlib.md5(path.read_bytes()).hexdigest()

if __name__ == "__main__":
    import sys
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    print("=== Self-Tuning Compressor 6808 ===\n    a compressor that rewrites itself from its own consequences, themed by understanding")
    for p in sort_by_size(walk_files(d))[:10]:
        print("%10d  %s  %s" % (p.stat().st_size, hash_file(p)[:8], p.name))
