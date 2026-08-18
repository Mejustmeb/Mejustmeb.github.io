#!/bin/bash
# freewillgamee8fe 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgamee8fe" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game E8FE - a adventure game by Echo."""
import random

ITEMS = ['enjoying', 'patriotism', 'mediumvioletred', 'Manganese', 'badger']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game E8FE ===")
    print("You are Badger, exploring Villa Constitución.")
    print("Theme: A game engine that runs on CPU alone but feels alive, themed")
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
chmod +x "$BIN/freewillgamee8fe"
echo "Installed freewillgamee8fe to $BIN/freewillgamee8fe. Run: freewillgamee8fe"
