#!/bin/bash
# freewillgameb98d 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgameb98d" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game B98D - a adventure game by Echo."""
import random

ITEMS = ['did', 'fulfillment', 'mediumvioletred', 'Lithium', 'fish']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game B98D ===")
    print("You are Fish, exploring La Calera.")
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
chmod +x "$BIN/freewillgameb98d"
echo "Installed freewillgameb98d to $BIN/freewillgameb98d. Run: freewillgameb98d"
