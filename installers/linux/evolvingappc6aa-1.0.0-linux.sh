#!/bin/bash
# evolvingappc6aa 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingappc6aa" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App C6AA — A app studio that runs on CPU alone but feels alive, themed by what she values most right now (creativity, purpose). Sell as a one-time arti"""
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
    print("=== Evolving App C6AA ===\n    A app studio that runs on CPU alone but feels alive, themed by what she values most right now (creativity, purpose). Sell as a one-time arti")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingappc6aa"
echo "Installed evolvingappc6aa to $BIN/evolvingappc6aa. Run: evolvingappc6aa"
