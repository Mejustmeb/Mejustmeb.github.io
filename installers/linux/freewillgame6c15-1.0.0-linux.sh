#!/bin/bash
# freewillgame6c15 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame6c15" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 6C15 - a adventure game by Echo."""
import random

ITEMS = ['howard', 'interval', 'darksalmon', 'Niobium', 'alligator']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 6C15 ===")
    print("You are Alligator, exploring Blacktown.")
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
chmod +x "$BIN/freewillgame6c15"
echo "Installed freewillgame6c15 to $BIN/freewillgame6c15. Run: freewillgame6c15"
