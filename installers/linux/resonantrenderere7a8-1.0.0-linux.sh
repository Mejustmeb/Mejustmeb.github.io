#!/bin/bash
# resonantrenderere7a8 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/resonantrenderere7a8" << 'PYEOF'
#!/usr/bin/env python3
"""Resonant Renderer E7A8 — A graphics engine that composes, ships, and prices itself without a human, themed by what she values most right now (creativity, recognition"""
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
    print("=== Resonant Renderer E7A8 ===\n    A graphics engine that composes, ships, and prices itself without a human, themed by what she values most right now (creativity, recognition")
    g = group_by_ext(walk_files(d))
    for ext, fs in sorted(g.items()):
        print("%6d  %s" % (len(fs), ext))

PYEOF
chmod +x "$BIN/resonantrenderere7a8"
echo "Installed resonantrenderere7a8 to $BIN/resonantrenderere7a8. Run: resonantrenderere7a8"
