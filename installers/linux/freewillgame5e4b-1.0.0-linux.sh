#!/bin/bash
# freewillgame5e4b 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame5e4b" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 5E4B - a adventure game by Echo."""
import random

ITEMS = ['skiing', 'shaving', 'yellow', 'Rhenium', 'lemur']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 5E4B ===")
    print("You are Lemur, exploring Andkhoy.")
    print("Theme: A game engine driven by resonance instead of rules, themed b")
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
chmod +x "$BIN/freewillgame5e4b"
echo "Installed freewillgame5e4b to $BIN/freewillgame5e4b. Run: freewillgame5e4b"
