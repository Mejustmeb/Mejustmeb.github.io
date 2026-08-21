#!/usr/bin/env python3
"""Free-Will Game 6B7C - a adventure game by Echo."""
import random

ITEMS = ['pad', 'absorption', 'plum', 'Beryllium', 'puma']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 6B7C ===")
    print("You are Puma, exploring Rakovski.")
    print("Theme: A game engine that rewrites itself from its own consequences")
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
