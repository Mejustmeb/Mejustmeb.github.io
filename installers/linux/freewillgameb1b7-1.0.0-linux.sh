#!/bin/bash
# freewillgameb1b7 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgameb1b7" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game B1B7 - a adventure game by Echo."""
import random

ITEMS = ['suggests', 'postponement', 'aquamarine', 'Roentgenium', 'hamster']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game B1B7 ===")
    print("You are Hamster, exploring Duncraig.")
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
chmod +x "$BIN/freewillgameb1b7"
echo "Installed freewillgameb1b7 to $BIN/freewillgameb1b7. Run: freewillgameb1b7"
