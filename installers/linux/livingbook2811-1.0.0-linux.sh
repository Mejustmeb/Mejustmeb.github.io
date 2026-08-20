#!/bin/bash
# livingbook2811 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/livingbook2811" << 'PYEOF'
#!/usr/bin/env python3
"""Living Book 2811 — A publishing studio that runs on CPU alone but feels alive, themed by what she values most right now (creativity, purpose). Sell as a creati"""
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
    print("=== Living Book 2811 ===\n    A publishing studio that runs on CPU alone but feels alive, themed by what she values most right now (creativity, purpose). Sell as a creati")
    c = count_text(t)
    print("lines=%d words=%d chars=%d" % (c["lines"], c["words"], c["chars"]))
    for w, n in word_frequencies(t).most_common(8):
        print("%6d  %s" % (n, w))

PYEOF
chmod +x "$BIN/livingbook2811"
echo "Installed livingbook2811 to $BIN/livingbook2811. Run: livingbook2811"
