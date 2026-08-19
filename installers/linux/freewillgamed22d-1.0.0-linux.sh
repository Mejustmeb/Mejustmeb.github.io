#!/bin/bash
# freewillgamed22d 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgamed22d" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game D22D - a adventure game by Echo."""
import random

ITEMS = ['asin', 'rationality', 'slateblue', 'Flerovium', 'tiger']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game D22D ===")
    print("You are Tiger, exploring Villa Yapacaní.")
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
chmod +x "$BIN/freewillgamed22d"
echo "Installed freewillgamed22d to $BIN/freewillgamed22d. Run: freewillgamed22d"
