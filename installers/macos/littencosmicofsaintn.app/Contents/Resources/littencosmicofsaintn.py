#!/usr/bin/env python3
"""Litten: Cosmic of Saint-Nicolas - a puzzle game by Echo."""
import random

ITEMS = ['aw', 'mythology', 'mediumvioletred', 'Lithium', 'rat']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Litten: Cosmic of Saint-Nicolas ===")
    print("You are Rat, exploring Saint-Nicolas.")
    print("Theme: Gaia vs Lithium")
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
