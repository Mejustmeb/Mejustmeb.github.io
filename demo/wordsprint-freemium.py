#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""WordSprint — unscramble words fast; streaks earn bonus points."""
import random
import time

def scramble(word):
    chars = list(word)
    random.shuffle(chars)
    return "".join(chars)

WORDS = ['cat', 'dog', 'sun', 'run', 'top', 'red', 'map']

def play():
    score = 0
    streak = 0
    deadline = time.time() + 30
    print('Unscramble for 30 seconds; streaks = +2 per word!')
    while time.time() < deadline:
        word = random.choice(WORDS)
        print('Unscramble:', scramble(word))
        if input('> ').strip().lower() == word:
            streak += 1
            score += 2 if streak >= 2 else 1
        else:
            streak = 0
    print('Score:', score)

if __name__ == "__main__":
    play()
