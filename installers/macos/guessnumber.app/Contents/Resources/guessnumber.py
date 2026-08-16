#!/usr/bin/env python3
"""GuessNumber — guess the number in as few tries as possible."""
import random

def evaluate(answer, guess):
    """-1 = too low, 1 = too high, 0 = correct."""
    return -1 if guess < answer else (1 if guess > answer else 0)

def play(low=1, high=100):
    answer = random.randint(low, high)
    tries = 0
    print("I'm thinking of a number between %d and %d." % (low, high))
    while True:
        guess = int(input("Your guess: "))
        tries += 1
        r = evaluate(answer, guess)
        if r == 0:
            print("Correct in %d tries!" % tries)
            return tries
        print("Too low!" if r < 0 else "Too high!")

if __name__ == "__main__":
    play()
