#!/bin/bash
# freewillgame96e8 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame96e8" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 96E8 - a adventure game by Echo."""
import random

ITEMS = ['barbara', 'barrymore', 'olive', 'Bismuth', 'mouse']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 96E8 ===")
    print("You are Mouse, exploring Carlingford.")
    print("Theme: A game engine that composes, ships, and prices itself withou")
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
chmod +x "$BIN/freewillgame96e8"
echo "Installed freewillgame96e8 to $BIN/freewillgame96e8. Run: freewillgame96e8"
