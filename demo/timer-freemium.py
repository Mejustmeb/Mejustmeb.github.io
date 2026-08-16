#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""Timer — a countdown timer with an optional label."""
import sys
import time

def countdown(seconds, label=""):
    while seconds > 0:
        mins, secs = divmod(seconds, 60)
        print("%02d:%02d %s" % (mins, secs, label))
        time.sleep(1)
        seconds -= 1
    print("Done!")
    return 0

if __name__ == "__main__":
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 10
    label = sys.argv[2] if len(sys.argv) > 2 else ""
    countdown(n, label)
