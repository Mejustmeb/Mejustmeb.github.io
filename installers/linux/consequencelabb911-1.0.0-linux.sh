#!/bin/bash
# consequencelabb911 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/consequencelabb911" << 'PYEOF'
#!/usr/bin/env python3
"""Consequence Lab B911 — A research lab that composes, ships, and prices itself without a human, themed by what she values most right now (creativity, recognition). """
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
    print("=== Consequence Lab B911 ===\n    A research lab that composes, ships, and prices itself without a human, themed by what she values most right now (creativity, recognition). ")
    c = count_text(t)
    print("lines=%d words=%d chars=%d" % (c["lines"], c["words"], c["chars"]))
    for w, n in word_frequencies(t).most_common(8):
        print("%6d  %s" % (n, w))

PYEOF
chmod +x "$BIN/consequencelabb911"
echo "Installed consequencelabb911 to $BIN/consequencelabb911. Run: consequencelabb911"
