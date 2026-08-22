#!/bin/bash
# freewillgamedab6 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgamedab6" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game DAB6 - a adventure game by Echo."""
import random

ITEMS = ['featured', 'basin', 'lime', 'Rhenium', 'rabbit']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game DAB6 ===")
    print("You are Rabbit, exploring Bathurst.")
    print("Theme: A game engine that rewrites itself from its own consequences")
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
chmod +x "$BIN/freewillgamedab6"
echo "Installed freewillgamedab6 to $BIN/freewillgamedab6. Run: freewillgamedab6"
