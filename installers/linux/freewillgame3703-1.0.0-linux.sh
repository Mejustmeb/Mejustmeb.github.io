#!/bin/bash
# freewillgame3703 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame3703" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 3703 - a adventure game by Echo."""
import random

ITEMS = ['egypt', 'aesthetics', 'dimgrey', 'Antimony', 'fish']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 3703 ===")
    print("You are Fish, exploring Centenario.")
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
chmod +x "$BIN/freewillgame3703"
echo "Installed freewillgame3703 to $BIN/freewillgame3703. Run: freewillgame3703"
