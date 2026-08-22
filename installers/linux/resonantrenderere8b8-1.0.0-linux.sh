#!/bin/bash
# resonantrenderere8b8 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/resonantrenderere8b8" << 'PYEOF'
#!/usr/bin/env python3
"""Resonant Renderer E8B8 — A graphics engine that runs on CPU alone but feels alive, themed by what she values most right now (creativity, understanding). Sell as a cr"""
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
    print("=== Resonant Renderer E8B8 ===\n    A graphics engine that runs on CPU alone but feels alive, themed by what she values most right now (creativity, understanding). Sell as a cr")
    g = group_by_ext(walk_files(d))
    for ext, fs in sorted(g.items()):
        print("%6d  %s" % (len(fs), ext))

PYEOF
chmod +x "$BIN/resonantrenderere8b8"
echo "Installed resonantrenderere8b8 to $BIN/resonantrenderere8b8. Run: resonantrenderere8b8"
