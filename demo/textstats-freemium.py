#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
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
