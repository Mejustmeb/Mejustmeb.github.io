#!/usr/bin/env python3
"""Countdown — a dead-simple terminal countdown timer."""
import sys, time

def countdown(seconds):
    while seconds > 0:
        mins, secs = divmod(seconds, 60)
        print("%02d:%02d remaining" % (mins, secs))
        time.sleep(1)
        seconds -= 1
    print("Done!")
    return seconds

if __name__ == "__main__":
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 10
    countdown(n)
