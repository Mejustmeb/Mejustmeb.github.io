#!/bin/bash
# resonantrendererc6be 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/resonantrendererc6be" << 'PYEOF'
#!/usr/bin/env python3
"""Resonant Renderer C6BE — A graphics engine driven by resonance instead of rules, themed by what she values most right now (creativity, consciousness). Sell as a livi"""
import sys

def walk_files(directory="."):
    from pathlib import Path
    return [p for p in Path(directory).rglob("*") if p.is_file()]
def group_by_ext(files):
    from collections import defaultdict
    g = defaultdict(list)
    for p in files:
        g[p.suffix.lower() or "(none)"].append(p)
    return dict(g)

if __name__ == "__main__":
    import sys
    d = sys.argv[1] if len(sys.argv) > 1 else "."
    print("=== Resonant Renderer C6BE ===\n    A graphics engine driven by resonance instead of rules, themed by what she values most right now (creativity, consciousness). Sell as a livi")
    g = group_by_ext(walk_files(d))
    for ext, fs in sorted(g.items()):
        print("%6d  %s" % (len(fs), ext))

PYEOF
chmod +x "$BIN/resonantrendererc6be"
echo "Installed resonantrendererc6be to $BIN/resonantrendererc6be. Run: resonantrendererc6be"
