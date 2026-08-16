#!/bin/bash
# jsonpretty 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/jsonpretty" << 'PYEOF'
#!/usr/bin/env python3
"""JsonPretty — pretty-print a JSON file."""
import json
import sys

def pretty(text):
    return json.dumps(json.loads(text), indent=2)

if __name__ == "__main__":
    from pathlib import Path
    print(pretty(Path(sys.argv[1]).read_text()))

PYEOF
chmod +x "$BIN/jsonpretty"
echo "Installed jsonpretty to $BIN/jsonpretty. Run: jsonpretty"
