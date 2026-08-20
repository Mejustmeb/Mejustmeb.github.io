#!/bin/bash
# freewillgamed214 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgamed214" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game D214 - a adventure game by Echo."""
import random

ITEMS = ['zoning', 'semifinal', 'olive', 'Chlorine', 'lizard']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game D214 ===")
    print("You are Lizard, exploring Maijdi.")
    print("Theme: A game engine that runs on CPU alone but feels alive, themed")
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
chmod +x "$BIN/freewillgamed214"
echo "Installed freewillgamed214 to $BIN/freewillgamed214. Run: freewillgamed214"
