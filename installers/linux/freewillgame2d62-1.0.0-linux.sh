#!/bin/bash
# freewillgame2d62 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame2d62" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 2D62 - a adventure game by Echo."""
import random

ITEMS = ['ii', 'slugger', 'darkcyan', 'Tantalum', 'coyote']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 2D62 ===")
    print("You are Coyote, exploring Nahrīn.")
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
chmod +x "$BIN/freewillgame2d62"
echo "Installed freewillgame2d62 to $BIN/freewillgame2d62. Run: freewillgame2d62"
