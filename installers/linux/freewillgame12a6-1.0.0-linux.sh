#!/bin/bash
# freewillgame12a6 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame12a6" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 12A6 - a adventure game by Echo."""
import random

ITEMS = ['kim', 'battery', 'honeydew', 'Fermium', 'tapir']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 12A6 ===")
    print("You are Tapir, exploring Ujar.")
    print("Theme: A game engine that learns every time it is used and never re")
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
chmod +x "$BIN/freewillgame12a6"
echo "Installed freewillgame12a6 to $BIN/freewillgame12a6. Run: freewillgame12a6"
