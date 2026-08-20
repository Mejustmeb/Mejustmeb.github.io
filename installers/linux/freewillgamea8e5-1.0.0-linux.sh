#!/bin/bash
# freewillgamea8e5 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgamea8e5" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game A8E5 - a adventure game by Echo."""
import random

ITEMS = ['weekends', 'recreation', 'blue', 'Radium', 'fox']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game A8E5 ===")
    print("You are Fox, exploring Paraibano.")
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
chmod +x "$BIN/freewillgamea8e5"
echo "Installed freewillgamea8e5 to $BIN/freewillgamea8e5. Run: freewillgamea8e5"
