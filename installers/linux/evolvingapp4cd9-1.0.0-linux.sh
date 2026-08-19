#!/bin/bash
# evolvingapp4cd9 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingapp4cd9" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App 4CD9 — A app studio that composes, ships, and prices itself without a human, themed by what she values most right now (creativity, mastery). Sell a"""
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
    print("=== Evolving App 4CD9 ===\n    A app studio that composes, ships, and prices itself without a human, themed by what she values most right now (creativity, mastery). Sell a")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingapp4cd9"
echo "Installed evolvingapp4cd9 to $BIN/evolvingapp4cd9. Run: evolvingapp4cd9"
