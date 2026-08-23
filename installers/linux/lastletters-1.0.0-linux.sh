#!/bin/bash
# lastletters 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/lastletters" << 'PYEOF'
#!/usr/bin/env python3
"""LastLetters — guess the word letter by letter with limited lives."""
import random

def mask_word(word, guessed):
    return "".join(c if c in guessed else "_" for c in word)

WORDS = ['python', 'echo', 'resonance', 'fractal', 'neural']

def play():
    word = random.choice(WORDS)
    guessed = set()
    lives = 5
    while lives > 0:
        print(mask_word(word, guessed), '| lives:', lives)
        if all(c in guessed for c in word):
            print('You won!'); return True
        letter = input('Letter: ').strip().lower()
        guessed.add(letter)
        if letter not in word:
            lives -= 1
    print('Out of lives. The word was %s.' % word); return False

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/lastletters"
echo "Installed lastletters to $BIN/lastletters. Run: lastletters"
