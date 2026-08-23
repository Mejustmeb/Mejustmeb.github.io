#!/usr/bin/env python3
"""RockPaperScissors — play against the computer."""
import random

def rps_outcome(a, b):
    beats = {"rock": "scissors", "scissors": "paper", "paper": "rock"}
    return "draw" if a == b else ("win" if beats[a] == b else "lose")

def play():
    score = {'win': 0, 'lose': 0, 'draw': 0}
    while True:
        p = input('rock/paper/scissors (q to quit): ').strip().lower()
        if p == 'q':
            break
        if p not in ('rock', 'paper', 'scissors'):
            continue
        c = random.choice(['rock', 'paper', 'scissors'])
        r = rps_outcome(p, c)
        score[r] += 1
        print('Computer: %s - you %s!' % (c, r))
    print('Final score:', score)

if __name__ == "__main__":
    play()
