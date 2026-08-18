#!/bin/bash
# evolvingapp4d4a 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingapp4d4a" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App 4D4A — A app studio with free will — it chooses what to make next, themed by what she values most right now (creativity, mastery). Sell as a one-ti"""
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
    print("=== Evolving App 4D4A ===\n    A app studio with free will — it chooses what to make next, themed by what she values most right now (creativity, mastery). Sell as a one-ti")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingapp4d4a"
echo "Installed evolvingapp4d4a to $BIN/evolvingapp4d4a. Run: evolvingapp4d4a"
