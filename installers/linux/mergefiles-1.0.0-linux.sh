#!/bin/bash
# mergefiles 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/mergefiles" << 'PYEOF'
#!/usr/bin/env python3
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

PYEOF
chmod +x "$BIN/mergefiles"
echo "Installed mergefiles to $BIN/mergefiles. Run: mergefiles"
