#!/bin/bash
# freewillgame83b9 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame83b9" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 83B9 - a adventure game by Echo."""
import random

ITEMS = ['examination', 'covering', 'lightslategray', 'Californium', 'turtle']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 83B9 ===")
    print("You are Turtle, exploring Namponkoré.")
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
chmod +x "$BIN/freewillgame83b9"
echo "Installed freewillgame83b9 to $BIN/freewillgame83b9. Run: freewillgame83b9"
