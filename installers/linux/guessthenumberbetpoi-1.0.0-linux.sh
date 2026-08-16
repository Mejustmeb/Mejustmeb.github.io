#!/bin/bash
# guessthenumberbetpoi 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/guessthenumberbetpoi" << 'PYEOF'
#!/usr/bin/env python3
"""GuessTheNumberBetPoints — guess the number with bet points."""
import random

def evaluate_number(answer, guess):
    return -1 if guess < answer else (1 if guess > answer else 0)

def play():
    answer = random.randint(1, 100)
    balance = 100
    while not (balance <= 0):
        bet = int(input('Wager: '))
        guess = int(input('Guess 1-100: '))
        won = (guess == answer)
        balance += bet if won else -bet
        if not won:
            print('Too low!' if guess < answer else 'Too high!')
    print('Final balance:', balance)

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/guessthenumberbetpoi"
echo "Installed guessthenumberbetpoi to $BIN/guessthenumberbetpoi. Run: guessthenumberbetpoi"
