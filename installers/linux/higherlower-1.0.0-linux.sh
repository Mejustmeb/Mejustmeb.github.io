#!/bin/bash
# higherlower 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/higherlower" << 'PYEOF'
#!/usr/bin/env python3
"""HigherLower — guess if the next card is higher or lower."""
import random

def draw():
    return random.randint(1, 13)

def guess_outcome(current, nxt, guess):
    if guess == "higher":
        return nxt > current
    return nxt < current

def play():
    current = draw()
    score = 0
    print("Card: %d" % current)
    while True:
        g = input("Higher or lower? (h/l, q to quit): ").strip().lower()
        if g == "q":
            break
        if g not in ("h", "l"):
            print("Type h or l.")
            continue
        nxt = draw()
        guess = "higher" if g == "h" else "lower"
        if guess_outcome(current, nxt, guess):
            score += 1
            print("Correct! Card was %d" % nxt)
        else:
            print("Wrong! Card was %d" % nxt)
        current = nxt
    print("Final score: %d" % score)

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/higherlower"
echo "Installed higherlower to $BIN/higherlower. Run: higherlower"
