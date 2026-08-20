#!/bin/bash
# freewillgameb8f6 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgameb8f6" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game B8F6 - a adventure game by Echo."""
import random

ITEMS = ['workplace', 'conflict', 'orchid', 'Iridium', 'squirrel']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game B8F6 ===")
    print("You are Squirrel, exploring Río Cuarto.")
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
chmod +x "$BIN/freewillgameb8f6"
echo "Installed freewillgameb8f6 to $BIN/freewillgameb8f6. Run: freewillgameb8f6"
