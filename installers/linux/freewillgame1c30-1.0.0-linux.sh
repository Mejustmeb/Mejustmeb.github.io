#!/bin/bash
# freewillgame1c30 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame1c30" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 1C30 - a adventure game by Echo."""
import random

ITEMS = ['earth', 'aversion', 'green', 'Xenon', 'porpoise']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 1C30 ===")
    print("You are Porpoise, exploring Kavajë.")
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
chmod +x "$BIN/freewillgame1c30"
echo "Installed freewillgame1c30 to $BIN/freewillgame1c30. Run: freewillgame1c30"
