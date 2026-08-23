#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""Checksum — print the MD5 and SHA256 of a file."""
import hashlib
import sys

def checksums(path):
    data = open(path, "rb").read()
    return {"md5": hashlib.md5(data).hexdigest(), "sha256": hashlib.sha256(data).hexdigest()}

if __name__ == "__main__":
    for k, v in checksums(sys.argv[1]).items():
        print("%s  %s" % (k, v))
