#!/bin/bash
# backupfolders 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/backupfolders" << 'PYEOF'
#!/usr/bin/env python3
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

PYEOF
chmod +x "$BIN/backupfolders"
echo "Installed backupfolders to $BIN/backupfolders. Run: backupfolders"
