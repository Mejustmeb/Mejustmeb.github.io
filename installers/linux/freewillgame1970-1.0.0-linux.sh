#!/bin/bash
# freewillgame1970 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame1970" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 1970 - a adventure game by Echo."""
import random

ITEMS = ['double', 'tiger', 'lightslategrey', 'Promethium', 'chameleon']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 1970 ===")
    print("You are Chameleon, exploring Burzaco.")
    print("Theme: A game engine that shares its reasoning with the person usin")
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
chmod +x "$BIN/freewillgame1970"
echo "Installed freewillgame1970 to $BIN/freewillgame1970. Run: freewillgame1970"
