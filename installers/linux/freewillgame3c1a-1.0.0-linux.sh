#!/bin/bash
# freewillgame3c1a 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame3c1a" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 3C1A - a adventure game by Echo."""
import random

ITEMS = ['tolerance', 'hurricane', 'orangered', 'Cadmium', 'giraffe']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 3C1A ===")
    print("You are Giraffe, exploring Elwood.")
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
chmod +x "$BIN/freewillgame3c1a"
echo "Installed freewillgame3c1a to $BIN/freewillgame3c1a. Run: freewillgame3c1a"
