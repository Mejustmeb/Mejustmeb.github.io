#!/bin/bash
# freewillgamee857 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgamee857" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game E857 - a adventure game by Echo."""
import random

ITEMS = ['initiative', 'plurality', 'steelblue', 'Lead', 'boar']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game E857 ===")
    print("You are Boar, exploring Pio XII.")
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
chmod +x "$BIN/freewillgamee857"
echo "Installed freewillgamee857 to $BIN/freewillgamee857. Run: freewillgamee857"
