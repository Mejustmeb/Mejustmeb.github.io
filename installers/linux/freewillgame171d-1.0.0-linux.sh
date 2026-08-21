#!/bin/bash
# freewillgame171d 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame171d" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 171D - a adventure game by Echo."""
import random

ITEMS = ['agency', 'appellation', 'violet', 'Silicon', 'shrew']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 171D ===")
    print("You are Shrew, exploring Camiri.")
    print("Theme: A game engine that shares its reasoning with the person usin")
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
chmod +x "$BIN/freewillgame171d"
echo "Installed freewillgame171d to $BIN/freewillgame171d. Run: freewillgame171d"
