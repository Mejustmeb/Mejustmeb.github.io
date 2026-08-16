#!/usr/bin/env python3
"""Haunter: Abroad of São José de Ribamar - a puzzle game by Echo."""
import random

ITEMS = ['pf', 'bounds', 'chocolate', 'Boron', 'sloth']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Haunter: Abroad of São José de Ribamar ===")
    print("You are Sloth, exploring São José de Ribamar.")
    print("Theme: Aphrodite vs Boron")
    print("Goal: find the " + goal + ".")
    bag = []
    for i in range(3):
        found = rng.choice(ITEMS)
        bag.append(found)
        print("  spot " + str(i + 1) + ": " + found)
    if goal in bag:
        print("VICTORY - you found the " + goal + "!")
        return True
    print("The " + goal + " eluded you.")
    return False

if __name__ == "__main__":
    play()
