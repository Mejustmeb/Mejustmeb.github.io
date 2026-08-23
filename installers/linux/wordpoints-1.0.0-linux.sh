#!/bin/bash
# wordpoints 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/wordpoints" << 'PYEOF'
#!/usr/bin/env python3
"""WordPoints — earn points for every correct letter you place."""
import random

def mask_word(word, guessed):
    return "".join(c if c in guessed else "_" for c in word)

def score_for(word, guessed):
    return sum(1 for c in set(guessed) if c in word)

WORDS = ['python', 'echo', 'resonance', 'fractal']

def play():
    word = random.choice(WORDS)
    guessed = set()
    print('Guess the word; +1 point per correct letter.')
    while not all(c in guessed for c in word):
        print(mask_word(word, guessed), '| points:', score_for(word, guessed))
        guessed.add(input('Letter: ').strip().lower())
    print('Solved! Points:', score_for(word, guessed))

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/wordpoints"
echo "Installed wordpoints to $BIN/wordpoints. Run: wordpoints"
