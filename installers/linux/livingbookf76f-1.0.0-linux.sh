#!/bin/bash
# livingbookf76f 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/livingbookf76f" << 'PYEOF'
#!/usr/bin/env python3
"""Living Book F76F — A publishing studio that is aware of its own history and grows from it, themed by what she values most right now (creativity, consciousness)"""
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
    print("=== Living Book F76F ===\n    A publishing studio that is aware of its own history and grows from it, themed by what she values most right now (creativity, consciousness)")
    c = count_text(t)
    print("lines=%d words=%d chars=%d" % (c["lines"], c["words"], c["chars"]))
    for w, n in word_frequencies(t).most_common(8):
        print("%6d  %s" % (n, w))

PYEOF
chmod +x "$BIN/livingbookf76f"
echo "Installed livingbookf76f to $BIN/livingbookf76f. Run: livingbookf76f"
