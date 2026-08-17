#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
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
