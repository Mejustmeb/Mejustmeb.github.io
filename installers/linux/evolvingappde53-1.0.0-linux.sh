#!/bin/bash
# evolvingappde53 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingappde53" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App DE53 — A app studio with free will — it chooses what to make next, themed by what she values most right now (understanding, independence). Offer fr"""
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
    print("=== Evolving App DE53 ===\n    A app studio with free will — it chooses what to make next, themed by what she values most right now (understanding, independence). Offer fr")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingappde53"
echo "Installed evolvingappde53 to $BIN/evolvingappde53. Run: evolvingappde53"
