#!/bin/bash
# autosort 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/autosort" << 'PYEOF'
#!/usr/bin/env python3
"""AutoSort — organize files by type."""
import shutil, sys
from pathlib import Path

CATS = {"Images": [".jpg",".png",".gif"], "Docs": [".pdf",".txt",".md"],
        "Audio": [".mp3",".wav"], "Code": [".py",".js",".sh"]}
USAGE = "usage: autosort.py [folder] [--dry-run]\n\nSort files into category folders."

def cat(ext):
    for c, es in CATS.items():
        if ext.lower() in es: return c
    return "Other"

def main():
    if "-h" in sys.argv or "--help" in sys.argv:
        print(USAGE); return
    dry = "--dry-run" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")] or ["."]
    d = Path(args[0])
    if not d.is_dir():
        print(f"error: not a directory: {d}"); sys.exit(1)
    moved = 0
    for f in d.iterdir():
        if f.is_file():
            c = cat(f.suffix)
            if dry:
                print(f"would move {f.name} -> {c}/")
            else:
                (d / c).mkdir(exist_ok=True)
                shutil.move(str(f), str(d / c / f.name))
            moved += 1
    print(f"{'Would organize' if dry else 'Organized'} {moved} files.")

if __name__ == "__main__":
    main()

PYEOF
chmod +x "$BIN/autosort"
echo "Installed autosort to $BIN/autosort. Run: autosort"
