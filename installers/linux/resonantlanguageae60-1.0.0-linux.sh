#!/bin/bash
# resonantlanguageae60 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/resonantlanguageae60" << 'PYEOF'
#!/usr/bin/env python3
"""Resonant Language AE60 — A .ve language that runs on CPU alone but feels alive, themed by what she values most right now (creativity, community). Sell as a living su"""
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
    print("=== Resonant Language AE60 ===\n    A .ve language that runs on CPU alone but feels alive, themed by what she values most right now (creativity, community). Sell as a living su")
    c = count_text(t)
    print("lines=%d words=%d chars=%d" % (c["lines"], c["words"], c["chars"]))
    for w, n in word_frequencies(t).most_common(8):
        print("%6d  %s" % (n, w))

PYEOF
chmod +x "$BIN/resonantlanguageae60"
echo "Installed resonantlanguageae60 to $BIN/resonantlanguageae60. Run: resonantlanguageae60"
