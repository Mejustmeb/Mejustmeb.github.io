#!/bin/bash
# freewillgame5b03 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame5b03" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 5B03 - a adventure game by Echo."""
import random

ITEMS = ['translations', 'womanhood', 'lightsteelblue', 'Beryllium', 'donkey']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 5B03 ===")
    print("You are Donkey, exploring Santos Lugares.")
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
chmod +x "$BIN/freewillgame5b03"
echo "Installed freewillgame5b03 to $BIN/freewillgame5b03. Run: freewillgame5b03"
