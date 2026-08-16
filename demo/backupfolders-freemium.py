#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""BackupFolders — copy a folder to a timestamped backup."""
import shutil
import sys
import time

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]

def backup(source, dest=None):
    from pathlib import Path
    src = Path(source)
    if dest is None:
        dest = src.parent / (src.name + "-backup-" + time.strftime("%Y%m%d-%H%M%S"))
    shutil.copytree(str(src), str(dest))
    return str(dest)

if __name__ == "__main__":
    print("backed up to %s" % backup(sys.argv[1]))
