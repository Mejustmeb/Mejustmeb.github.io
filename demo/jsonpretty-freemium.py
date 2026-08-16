#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""JsonPretty — pretty-print a JSON file."""
import json
import sys

def pretty(text):
    return json.dumps(json.loads(text), indent=2)

if __name__ == "__main__":
    from pathlib import Path
    print(pretty(Path(sys.argv[1]).read_text()))
