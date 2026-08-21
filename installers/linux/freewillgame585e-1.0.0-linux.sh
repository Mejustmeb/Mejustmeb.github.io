#!/bin/bash
# freewillgame585e 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame585e" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 585E - a adventure game by Echo."""
import random

ITEMS = ['worm', 'concur', 'mediumorchid', 'Oxygen', 'parrot']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 585E ===")
    print("You are Parrot, exploring Cambundi.")
    print("Theme: A game engine that learns every time it is used and never re")
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
chmod +x "$BIN/freewillgame585e"
echo "Installed freewillgame585e to $BIN/freewillgame585e. Run: freewillgame585e"
