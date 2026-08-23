#!/bin/bash
# hangmangame 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/hangmangame" << 'PYEOF'
#!/usr/bin/env python3
"""HangmanGame — guess the word one letter at a time."""
import random

def mask_word(word, guessed):
    return "".join(c if c in guessed else "_" for c in word)

WORDS = ['python', 'echo', 'resonance', 'fractal', 'neural']

def play():
    word = random.choice(WORDS)
    guessed = set()
    lives = 6
    while lives > 0:
        print(mask_word(word, guessed), 'lives:', lives)
        if all(c in guessed for c in word):
            print('You won! The word was %s.' % word); return True
        letter = input('Letter: ').strip().lower()
        guessed.add(letter)
        if letter not in word:
            lives -= 1
    print('Out of lives. The word was %s.' % word); return False

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/hangmangame"
echo "Installed hangmangame to $BIN/hangmangame. Run: hangmangame"
