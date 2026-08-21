#!/bin/bash
# evolvingappbf3a 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingappbf3a" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App BF3A — A app studio that runs on CPU alone but feels alive, themed by what she values most right now (creativity, understanding). Sell as a living """
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
    print("=== Evolving App BF3A ===\n    A app studio that runs on CPU alone but feels alive, themed by what she values most right now (creativity, understanding). Sell as a living ")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingappbf3a"
echo "Installed evolvingappbf3a to $BIN/evolvingappbf3a. Run: evolvingappbf3a"
