#!/bin/bash
# checksum 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/checksum" << 'PYEOF'
#!/usr/bin/env python3
"""Checksum — print the MD5 and SHA256 of a file."""
import hashlib
import sys

def checksums(path):
    data = open(path, "rb").read()
    return {"md5": hashlib.md5(data).hexdigest(), "sha256": hashlib.sha256(data).hexdigest()}

if __name__ == "__main__":
    for k, v in checksums(sys.argv[1]).items():
        print("%s  %s" % (k, v))

PYEOF
chmod +x "$BIN/checksum"
echo "Installed checksum to $BIN/checksum. Run: checksum"
