#!/bin/bash
# freewillgamec45b 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgamec45b" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game C45B - a adventure game by Echo."""
import random

ITEMS = ['argument', 'ranger', 'darkblue', 'Palladium', 'chipmunk']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game C45B ===")
    print("You are Chipmunk, exploring Córdoba.")
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
chmod +x "$BIN/freewillgamec45b"
echo "Installed freewillgamec45b to $BIN/freewillgamec45b. Run: freewillgamec45b"
