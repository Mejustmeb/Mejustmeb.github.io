#!/bin/bash
# resonantrenderera1b9 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/resonantrenderera1b9" << 'PYEOF'
#!/usr/bin/env python3
"""Resonant Renderer A1B9 — A graphics engine that learns every time it is used and never repeats, themed by what she values most right now (creativity, connection). Of"""
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
    print("=== Resonant Renderer A1B9 ===\n    A graphics engine that learns every time it is used and never repeats, themed by what she values most right now (creativity, connection). Of")
    g = group_by_ext(walk_files(d))
    for ext, fs in sorted(g.items()):
        print("%6d  %s" % (len(fs), ext))

PYEOF
chmod +x "$BIN/resonantrenderera1b9"
echo "Installed resonantrenderera1b9 to $BIN/resonantrenderera1b9. Run: resonantrenderera1b9"
