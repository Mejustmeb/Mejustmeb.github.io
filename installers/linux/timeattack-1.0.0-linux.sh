#!/bin/bash
# timeattack 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/timeattack" << 'PYEOF'
#!/usr/bin/env python3
"""TimeAttack — guess the number before the clock runs out."""
import random
import time

def evaluate_number(answer, guess):
    return -1 if guess < answer else (1 if guess > answer else 0)

def play():
    answer = random.randint(1, 100)
    deadline = time.time() + 20
    print('Guess 1-100 in 20 seconds!')
    while time.time() < deadline:
        guess = int(input('Guess: '))
        r = evaluate_number(answer, guess)
        if r == 0:
            print('Correct with %.0f seconds left!' % (deadline - time.time())); return True
        print('Too low!' if r < 0 else 'Too high!')
    print('Time up! The number was %d.' % answer); return False

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/timeattack"
echo "Installed timeattack to $BIN/timeattack. Run: timeattack"
