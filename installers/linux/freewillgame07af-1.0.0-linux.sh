#!/bin/bash
# freewillgame07af 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame07af" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 07AF - a adventure game by Echo."""
import random

ITEMS = ['jun', 'panther', 'mintcream', 'Ruthenium', 'gazelle']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 07AF ===")
    print("You are Gazelle, exploring Imishli.")
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
chmod +x "$BIN/freewillgame07af"
echo "Installed freewillgame07af to $BIN/freewillgame07af. Run: freewillgame07af"
