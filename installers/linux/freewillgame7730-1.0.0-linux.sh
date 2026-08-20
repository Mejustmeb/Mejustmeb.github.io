#!/bin/bash
# freewillgame7730 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame7730" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 7730 - a adventure game by Echo."""
import random

ITEMS = ['alot', 'processor', 'oldlace', 'Iodine', 'shrew']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 7730 ===")
    print("You are Shrew, exploring Sakhipur.")
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
chmod +x "$BIN/freewillgame7730"
echo "Installed freewillgame7730 to $BIN/freewillgame7730. Run: freewillgame7730"
