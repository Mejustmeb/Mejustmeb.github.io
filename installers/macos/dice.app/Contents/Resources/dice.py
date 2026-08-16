#!/usr/bin/env python3
"""Dice — bet high or low on the next roll."""
import random

def roll():
    return random.randint(1, 6) + random.randint(1, 6)

def bet_outcome(total, guess):
    if guess == "seven":
        return total == 7
    if guess == "high":
        return total >= 8
    return total <= 6

def play():
    score = 0
    print("Bet high (8+), low (6-), or seven. q to quit.")
    while True:
        g = input("Bet: ").strip().lower()
        if g == "q":
            break
        if g not in ("high", "low", "seven"):
            print("Say high, low, or seven.")
            continue
        total = roll()
        if bet_outcome(total, g):
            score += 1
            print("Rolled %d - you win!" % total)
        else:
            print("Rolled %d - you lose." % total)
    print("Final score: %d" % score)

if __name__ == "__main__":
    play()
