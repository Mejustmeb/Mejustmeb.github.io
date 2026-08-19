#!/bin/bash
# freewillgameacb0 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgameacb0" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game ACB0 - a adventure game by Echo."""
import random

ITEMS = ['opponent', 'larceny', 'navajowhite', 'Hassium', 'antelope']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game ACB0 ===")
    print("You are Antelope, exploring Helchteren.")
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
chmod +x "$BIN/freewillgameacb0"
echo "Installed freewillgameacb0 to $BIN/freewillgameacb0. Run: freewillgameacb0"
