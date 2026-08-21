#!/bin/bash
# freewillgame7909 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame7909" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 7909 - a adventure game by Echo."""
import random

ITEMS = ['slides', 'quart', 'olivedrab', 'Neptunium', 'pig']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 7909 ===")
    print("You are Pig, exploring Zwijndrecht.")
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
chmod +x "$BIN/freewillgame7909"
echo "Installed freewillgame7909 to $BIN/freewillgame7909. Run: freewillgame7909"
