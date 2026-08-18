#!/bin/bash
# freewillgamed61d 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgamed61d" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game D61D - a adventure game by Echo."""
import random

ITEMS = ['cats', 'driver', 'rebeccapurple', 'Terbium', 'rhinoceros']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game D61D ===")
    print("You are Rhinoceros, exploring General Villegas.")
    print("Theme: A game engine that composes, ships, and prices itself withou")
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

PYEOF
chmod +x "$BIN/freewillgamed61d"
echo "Installed freewillgamed61d to $BIN/freewillgamed61d. Run: freewillgamed61d"
