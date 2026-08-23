#!/bin/bash
# renamefiles 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/renamefiles" << 'PYEOF'
#!/usr/bin/env python3
"""RenameFiles — add a prefix or suffix to every file in a folder."""
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]

def rename(directory, prefix="", suffix=""):
    from pathlib import Path
    n = 0
    for p in walk_files(directory):
        new = p.with_name(prefix + p.name + suffix)
        if new != p:
            p.rename(new)
            n += 1
    return n

if __name__ == "__main__":
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    pre = sys.argv[2] if len(sys.argv) > 2 else ""
    suf = sys.argv[3] if len(sys.argv) > 3 else ""
    print("renamed %d files" % rename(d, pre, suf))

PYEOF
chmod +x "$BIN/renamefiles"
echo "Installed renamefiles to $BIN/renamefiles. Run: renamefiles"
