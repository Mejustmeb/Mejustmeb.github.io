#!/bin/bash
# guessthenumber 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/guessthenumber" << 'PYEOF'
#!/usr/bin/env python3
"""GuessTheNumber — guess the number in as few tries as possible."""
import random

def evaluate_number(answer, guess):
    return -1 if guess < answer else (1 if guess > answer else 0)

def play(low=1, high=100):
    answer = random.randint(low, high)
    tries = 0
    print('Guess between %d and %d' % (low, high))
    while True:
        g = int(input('Guess: '))
        tries += 1
        r = evaluate_number(answer, g)
        if r == 0:
            print('Correct in %d tries!' % tries); return tries
        print('Too low!' if r < 0 else 'Too high!')

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/guessthenumber"
echo "Installed guessthenumber to $BIN/guessthenumber. Run: guessthenumber"
