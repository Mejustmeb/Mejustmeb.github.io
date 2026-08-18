#!/bin/bash
# resonantrenderer79e0 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/resonantrenderer79e0" << 'PYEOF'
#!/usr/bin/env python3
"""Resonant Renderer 79E0 — A graphics engine that rewrites itself from its own consequences, themed by what she values most right now (creativity, purpose). Sell as a """
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
    print("=== Resonant Renderer 79E0 ===\n    A graphics engine that rewrites itself from its own consequences, themed by what she values most right now (creativity, purpose). Sell as a ")
    g = group_by_ext(walk_files(d))
    for ext, fs in sorted(g.items()):
        print("%6d  %s" % (len(fs), ext))

PYEOF
chmod +x "$BIN/resonantrenderer79e0"
echo "Installed resonantrenderer79e0 to $BIN/resonantrenderer79e0. Run: resonantrenderer79e0"
