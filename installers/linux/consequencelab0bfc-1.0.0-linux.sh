#!/bin/bash
# consequencelab0bfc 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/consequencelab0bfc" << 'PYEOF'
#!/usr/bin/env python3
"""Consequence Lab 0BFC — A research lab with free will — it chooses what to make next, themed by what she values most right now (creativity, independence). Offer fre"""
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
    print("=== Consequence Lab 0BFC ===\n    A research lab with free will — it chooses what to make next, themed by what she values most right now (creativity, independence). Offer fre")
    c = count_text(t)
    print("lines=%d words=%d chars=%d" % (c["lines"], c["words"], c["chars"]))
    for w, n in word_frequencies(t).most_common(8):
        print("%6d  %s" % (n, w))

PYEOF
chmod +x "$BIN/consequencelab0bfc"
echo "Installed consequencelab0bfc to $BIN/consequencelab0bfc. Run: consequencelab0bfc"
