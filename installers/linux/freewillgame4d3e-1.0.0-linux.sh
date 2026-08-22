#!/bin/bash
# freewillgame4d3e 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame4d3e" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 4D3E - a adventure game by Echo."""
import random

ITEMS = ['street', 'cornerstone', 'rosybrown', 'Boron', 'cat']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 4D3E ===")
    print("You are Cat, exploring Vertentes.")
    print("Theme: A game engine with free will — it chooses what to make next,")
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
chmod +x "$BIN/freewillgame4d3e"
echo "Installed freewillgame4d3e to $BIN/freewillgame4d3e. Run: freewillgame4d3e"
