#!/bin/bash
# freewillgameefa8 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgameefa8" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game EFA8 - a adventure game by Echo."""
import random

ITEMS = ['gains', 'allergy', 'white', 'Californium', 'rabbit']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game EFA8 ===")
    print("You are Rabbit, exploring Orós.")
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
chmod +x "$BIN/freewillgameefa8"
echo "Installed freewillgameefa8 to $BIN/freewillgameefa8. Run: freewillgameefa8"
