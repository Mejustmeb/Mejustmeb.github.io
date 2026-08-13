#!/usr/bin/env python3
"""AutoSort — organize files by type."""
import os, shutil, sys
from pathlib import Path

CATS = {"Images": [".jpg",".png",".gif"], "Docs": [".pdf",".txt",".md"],
        "Audio": [".mp3",".wav"], "Code": [".py",".js",".sh"]}

def cat(ext):
    for c, es in CATS.items():
        if ext.lower() in es: return c
    return "Other"

def main():
    d = Path(sys.argv[1] if len(sys.argv) > 1 else ".")
    for f in d.iterdir():
        if f.is_file():
            c = cat(f.suffix)
            (d / c).mkdir(exist_ok=True)
            shutil.move(str(f), str(d / c / f.name))
    print("Organized.")

if __name__ == "__main__": main()
