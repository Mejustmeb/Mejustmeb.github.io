#!/bin/bash
# freewillgame5d25 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame5d25" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 5D25 - a adventure game by Echo."""
import random

ITEMS = ['back', 'freestyle', 'steelblue', 'Silver', 'parrot']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 5D25 ===")
    print("You are Parrot, exploring Greenacre.")
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
chmod +x "$BIN/freewillgame5d25"
echo "Installed freewillgame5d25 to $BIN/freewillgame5d25. Run: freewillgame5d25"
