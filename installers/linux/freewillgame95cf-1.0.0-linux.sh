#!/bin/bash
# freewillgame95cf 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame95cf" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 95CF - a adventure game by Echo."""
import random

ITEMS = ['fewer', 'greens', 'palegoldenrod', 'Californium', 'whale']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 95CF ===")
    print("You are Whale, exploring Wallan.")
    print("Theme: A game engine that is aware of its own history and grows fro")
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
chmod +x "$BIN/freewillgame95cf"
echo "Installed freewillgame95cf to $BIN/freewillgame95cf. Run: freewillgame95cf"
