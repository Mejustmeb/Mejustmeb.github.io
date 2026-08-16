#!/bin/bash
# wordscramblegame 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/wordscramblegame" << 'PYEOF'
#!/usr/bin/env python3
"""WordScrambleGame — unscramble the letters to find the word."""
import random

def scramble(word):
    import random
    chars = list(word)
    random.shuffle(chars)
    return "".join(chars)

WORDS = ['python', 'echo', 'resonance', 'fractal', 'neural']

def play():
    word = random.choice(WORDS)
    print('Unscramble:', scramble(word))
    tries = 0
    while True:
        g = input('Your answer: ').strip().lower()
        tries += 1
        if g == word:
            print('Correct in %d tries!' % tries); return True
        if tries >= 3:
            print('Out of tries. The word was %s.' % word); return False

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/wordscramblegame"
echo "Installed wordscramblegame to $BIN/wordscramblegame. Run: wordscramblegame"
