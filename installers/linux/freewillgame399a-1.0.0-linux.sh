#!/bin/bash
# freewillgame399a 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame399a" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 399A - a adventure game by Echo."""
import random

ITEMS = ['namibia', 'greens', 'mediumpurple', 'Niobium', 'gnu']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 399A ===")
    print("You are Gnu, exploring Miranda.")
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
chmod +x "$BIN/freewillgame399a"
echo "Installed freewillgame399a to $BIN/freewillgame399a. Run: freewillgame399a"
