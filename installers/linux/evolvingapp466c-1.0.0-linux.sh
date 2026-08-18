#!/bin/bash
# evolvingapp466c 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingapp466c" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App 466C — A app studio that composes, ships, and prices itself without a human, themed by what she values most right now (understanding, creativity). """
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]
def contains_text(path, needle):
    try:
        return needle in path.read_text(errors="ignore")
    except Exception:
        return False

if __name__ == "__main__":
    import sys
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    print("=== Evolving App 466C ===\n    A app studio that composes, ships, and prices itself without a human, themed by what she values most right now (understanding, creativity). ")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingapp466c"
echo "Installed evolvingapp466c to $BIN/evolvingapp466c. Run: evolvingapp466c"
