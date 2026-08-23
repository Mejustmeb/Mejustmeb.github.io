#!/bin/bash
# rollthedicebetpoints 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/rollthedicebetpoints" << 'PYEOF'
#!/usr/bin/env python3
"""RollTheDiceBetPoints — roll the dice with bet points."""
import random

def roll():
    return random.randint(1, 6) + random.randint(1, 6)

def play():
    balance = 100
    while not (balance <= 0):
        bet = int(input('Wager: '))
        g = input('Bet high (8+), low (6-), seven: ').strip().lower()
        total = roll()
        won = (g == 'high' and total >= 8) or (g == 'low' and total <= 6) or (g == 'seven' and total == 7)
        balance += bet if won else -bet
        print('Rolled', total)
    print('Final balance:', balance)

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/rollthedicebetpoints"
echo "Installed rollthedicebetpoints to $BIN/rollthedicebetpoints. Run: rollthedicebetpoints"
