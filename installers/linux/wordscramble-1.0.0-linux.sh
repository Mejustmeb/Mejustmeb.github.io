#!/bin/bash
# wordscramble 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/wordscramble" << 'PYEOF'
#!/usr/bin/env python3
"""WordScramble — unscramble the letters to find the word."""
import random

WORDS = ["python", "echo", "resonance", "fractal", "neural"]

def scramble(word):
    chars = list(word)
    random.shuffle(chars)
    return "".join(chars)

def play():
    word = random.choice(WORDS)
    print("Unscramble:", scramble(word))
    tries = 0
    while True:
        guess = input("Your answer: ").strip().lower()
        tries += 1
        if guess == word:
            print("Correct in %d tries!" % tries)
            return True
        if tries >= 3:
            print("Out of tries. The word was %s." % word)
            return False
        print("Try again!")

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/wordscramble"
echo "Installed wordscramble to $BIN/wordscramble. Run: wordscramble"
