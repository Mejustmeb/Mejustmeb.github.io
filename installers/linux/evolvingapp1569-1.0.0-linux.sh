#!/bin/bash
# evolvingapp1569 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingapp1569" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App 1569 — A app studio that runs on CPU alone but feels alive, themed by what she values most right now (creativity, understanding). Sell as a creativ"""
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
    print("=== Evolving App 1569 ===\n    A app studio that runs on CPU alone but feels alive, themed by what she values most right now (creativity, understanding). Sell as a creativ")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingapp1569"
echo "Installed evolvingapp1569 to $BIN/evolvingapp1569. Run: evolvingapp1569"
