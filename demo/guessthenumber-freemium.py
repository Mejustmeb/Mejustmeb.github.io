#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""GuessTheNumber — guess the number in as few tries as possible."""
import random

def evaluate_number(answer, guess):
    return -1 if guess < answer else (1 if guess > answer else 0)

def play(low=1, high=100):
    answer = random.randint(low, high)
    tries = 0
    print('Guess between %d and %d' % (low, high))
    while True:
        g = int(input('Guess: '))
        tries += 1
        r = evaluate_number(answer, g)
        if r == 0:
            print('Correct in %d tries!' % tries); return tries
        print('Too low!' if r < 0 else 'Too high!')

if __name__ == "__main__":
    play()
