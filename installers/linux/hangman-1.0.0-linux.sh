#!/bin/bash
# hangman 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/hangman" << 'PYEOF'
#!/usr/bin/env python3
"""Hangman — guess the word one letter at a time."""
import random

WORDS = ["python", "echo", "resonance", "fractal", "neural", "quantum", "mirror"]

def mask(word, guessed):
    return "".join(c if c in guessed else "_" for c in word)

def is_won(word, guessed):
    return all(c in guessed for c in word)

def play():
    word = random.choice(WORDS)
    guessed = set()
    lives = 6
    print("Guess the word, one letter at a time.")
    while lives > 0:
        print(mask(word, guessed), " lives:", lives)
        if is_won(word, guessed):
            print("You won! The word was %s." % word)
            return True
        letter = input("Letter: ").strip().lower()
        if not letter:
            continue
        guessed.add(letter)
        if letter not in word:
            lives -= 1
    print("Out of lives. The word was %s." % word)
    return False

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/hangman"
echo "Installed hangman to $BIN/hangman. Run: hangman"
