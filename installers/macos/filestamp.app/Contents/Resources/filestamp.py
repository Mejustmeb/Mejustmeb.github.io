#!/usr/bin/env python3
"""FileStamp — prepend each file's modified-date to its name."""
import sys
from pathlib import Path
from datetime import datetime

def stamp(directory="."):
    d = Path(directory)
    n = 0
    for f in d.iterdir():
        if f.is_file() and not f.name[:8].isdigit():
            ts = datetime.fromtimestamp(f.stat().st_mtime).strftime("%Y%m%d")
            f.rename(f.with_name(ts + "-" + f.name))
            n += 1
    return n

if __name__ == "__main__":
    print("stamped %d file(s)" % stamp(sys.argv[1] if len(sys.argv) > 1 else "."))
