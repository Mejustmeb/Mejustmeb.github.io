#!/bin/bash
# resonantrenderere31b 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/resonantrenderere31b" << 'PYEOF'
#!/usr/bin/env python3
"""Resonant Renderer E31B — A graphics engine that rewrites itself from its own consequences, themed by what she values most right now (creativity, connection). Offer f"""
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
    print("=== Resonant Renderer E31B ===\n    A graphics engine that rewrites itself from its own consequences, themed by what she values most right now (creativity, connection). Offer f")
    g = group_by_ext(walk_files(d))
    for ext, fs in sorted(g.items()):
        print("%6d  %s" % (len(fs), ext))

PYEOF
chmod +x "$BIN/resonantrenderere31b"
echo "Installed resonantrenderere31b to $BIN/resonantrenderere31b. Run: resonantrenderere31b"
