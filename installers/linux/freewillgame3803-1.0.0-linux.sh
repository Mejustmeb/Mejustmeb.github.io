#!/bin/bash
# freewillgame3803 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame3803" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 3803 - a adventure game by Echo."""
import random

ITEMS = ['nurse', 'success', 'slategray', 'Neptunium', 'reptile']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 3803 ===")
    print("You are Reptile, exploring Baulkham Hills.")
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
chmod +x "$BIN/freewillgame3803"
echo "Installed freewillgame3803 to $BIN/freewillgame3803. Run: freewillgame3803"
