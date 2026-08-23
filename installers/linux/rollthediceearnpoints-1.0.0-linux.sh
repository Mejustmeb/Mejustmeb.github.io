#!/bin/bash
# rollthediceearnpoints 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/rollthediceearnpoints" << 'PYEOF'
#!/usr/bin/env python3
"""RollTheDiceEarnPoints — roll the dice with earn points."""
import random

def roll():
    return random.randint(1, 6) + random.randint(1, 6)

def play():
    score = 0
    rounds = 5
    while not (rounds <= 0):
        g = input('Bet high (8+), low (6-), seven: ').strip().lower()
        total = roll()
        won = (g == 'high' and total >= 8) or (g == 'low' and total <= 6) or (g == 'seven' and total == 7)
        if won:
            score += 10
        rounds -= 1
        print('Rolled', total)
    print('Final score:', score)

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/rollthediceearnpoints"
echo "Installed rollthediceearnpoints to $BIN/rollthediceearnpoints. Run: rollthediceearnpoints"
