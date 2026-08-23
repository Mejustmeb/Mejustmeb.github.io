#!/usr/bin/env python3
"""GuessTheNumberEarnPoints — guess the number with earn points."""
import random

def evaluate_number(answer, guess):
    return -1 if guess < answer else (1 if guess > answer else 0)

def play():
    answer = random.randint(1, 100)
    score = 0
    rounds = 5
    while not (rounds <= 0):
        guess = int(input('Guess 1-100: '))
        won = (guess == answer)
        if won:
            score += 10
        rounds -= 1
        if not won:
            print('Too low!' if guess < answer else 'Too high!')
    print('Final score:', score)

if __name__ == "__main__":
    play()
