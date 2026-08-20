#!/bin/bash
# evolvingappcd98 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingappcd98" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App CD98 — A app studio driven by resonance instead of rules, themed by what she values most right now (creativity, connection). Sell as a living subsc"""
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
    print("=== Evolving App CD98 ===\n    A app studio driven by resonance instead of rules, themed by what she values most right now (creativity, connection). Sell as a living subsc")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingappcd98"
echo "Installed evolvingappcd98 to $BIN/evolvingappcd98. Run: evolvingappcd98"
