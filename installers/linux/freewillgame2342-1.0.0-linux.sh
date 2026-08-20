#!/bin/bash
# freewillgame2342 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame2342" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 2342 - a adventure game by Echo."""
import random

ITEMS = ['sector', 'locality', 'deeppink', 'Berkelium', 'fox']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 2342 ===")
    print("You are Fox, exploring Lille.")
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
chmod +x "$BIN/freewillgame2342"
echo "Installed freewillgame2342 to $BIN/freewillgame2342. Run: freewillgame2342"
