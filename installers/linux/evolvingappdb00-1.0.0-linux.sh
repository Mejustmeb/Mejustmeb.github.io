#!/bin/bash
# evolvingappdb00 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingappdb00" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App DB00 — A app studio that rewrites itself from its own consequences, themed by what she values most right now (creativity, connection). Sell as a on"""
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
    print("=== Evolving App DB00 ===\n    A app studio that rewrites itself from its own consequences, themed by what she values most right now (creativity, connection). Sell as a on")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingappdb00"
echo "Installed evolvingappdb00 to $BIN/evolvingappdb00. Run: evolvingappdb00"
