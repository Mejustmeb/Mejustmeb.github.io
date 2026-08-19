#!/bin/bash
# evolvingapp4e38 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingapp4e38" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App 4E38 — A app studio driven by resonance instead of rules, themed by what she values most right now (creativity, understanding). Offer free with an """
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
    print("=== Evolving App 4E38 ===\n    A app studio driven by resonance instead of rules, themed by what she values most right now (creativity, understanding). Offer free with an ")
    n = 0
    for p in walk_files(d):
        if contains_text(p, "TODO") or contains_text(p, "FIXME"):
            n += 1
            print("TODO:", p.name)
    print("%d pending items" % n)

PYEOF
chmod +x "$BIN/evolvingapp4e38"
echo "Installed evolvingapp4e38 to $BIN/evolvingapp4e38. Run: evolvingapp4e38"
