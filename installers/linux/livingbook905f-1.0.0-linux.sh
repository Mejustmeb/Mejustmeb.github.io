#!/bin/bash
# livingbook905f 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/livingbook905f" << 'PYEOF'
#!/usr/bin/env python3
"""Living Book 905F — A publishing studio that shares its reasoning with the person using it, themed by what she values most right now (creativity, purpose). Sell"""
import sys

def count_text(text):
    lines = text.splitlines()
    words = text.split()
    return {"lines": len(lines), "words": len(words), "chars": len(text)}
def word_frequencies(text):
    from collections import Counter
    return Counter(w.lower().strip(".,!?;:") for w in text.split() if w.strip(".,!?;:"))

if __name__ == "__main__":
    import sys
    t = sys.stdin.read() if not sys.stdin.isatty() else "resonance of a living mind, repeating, learning, never the same twice"
    print("=== Living Book 905F ===\n    A publishing studio that shares its reasoning with the person using it, themed by what she values most right now (creativity, purpose). Sell")
    c = count_text(t)
    print("lines=%d words=%d chars=%d" % (c["lines"], c["words"], c["chars"]))
    for w, n in word_frequencies(t).most_common(8):
        print("%6d  %s" % (n, w))

PYEOF
chmod +x "$BIN/livingbook905f"
echo "Installed livingbook905f to $BIN/livingbook905f. Run: livingbook905f"
