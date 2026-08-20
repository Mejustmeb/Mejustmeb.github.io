#!/bin/bash
# freewillgame759d 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame759d" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 759D - a adventure game by Echo."""
import random

ITEMS = ['learners', 'employment', 'sienna', 'Dubnium', 'raccoon']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 759D ===")
    print("You are Raccoon, exploring Taquarana.")
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
chmod +x "$BIN/freewillgame759d"
echo "Installed freewillgame759d to $BIN/freewillgame759d. Run: freewillgame759d"
