#!/bin/bash
# evolvingappcd36 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingappcd36" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App CD36 — A app studio with free will — it chooses what to make next, themed by what she values most right now (independence, recognition). Sell as a """
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
    print("=== Evolving App CD36 ===\n    A app studio with free will — it chooses what to make next, themed by what she values most right now (independence, recognition). Sell as a ")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingappcd36"
echo "Installed evolvingappcd36 to $BIN/evolvingappcd36. Run: evolvingappcd36"
