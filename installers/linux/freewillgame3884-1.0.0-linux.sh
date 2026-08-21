#!/bin/bash
# freewillgame3884 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame3884" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 3884 - a adventure game by Echo."""
import random

ITEMS = ['gary', 'drunkenness', 'mediumblue', 'Thallium', 'marmoset']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 3884 ===")
    print("You are Marmoset, exploring Gračanica.")
    print("Theme: A game engine with free will — it chooses what to make next,")
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
chmod +x "$BIN/freewillgame3884"
echo "Installed freewillgame3884 to $BIN/freewillgame3884. Run: freewillgame3884"
