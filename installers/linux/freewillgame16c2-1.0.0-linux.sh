#!/bin/bash
# freewillgame16c2 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame16c2" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 16C2 - a adventure game by Echo."""
import random

ITEMS = ['should', 'jenny', 'darkgray', 'Fluorine', 'cow']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 16C2 ===")
    print("You are Cow, exploring Aalst.")
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
chmod +x "$BIN/freewillgame16c2"
echo "Installed freewillgame16c2 to $BIN/freewillgame16c2. Run: freewillgame16c2"
