#!/bin/bash
# textstats 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/textstats" << 'PYEOF'
#!/usr/bin/env python3
"""TextStats — report line, word, and character counts for a file."""
import sys

def count_text(text):
    lines = text.splitlines()
    words = text.split()
    return {"lines": len(lines), "words": len(words), "chars": len(text)}

if __name__ == "__main__":
    from pathlib import Path
    f = Path(sys.argv[1])
    s = count_text(f.read_text())
    print("lines=%d words=%d chars=%d" % (s["lines"], s["words"], s["chars"]))

PYEOF
chmod +x "$BIN/textstats"
echo "Installed textstats to $BIN/textstats. Run: textstats"
