#!/bin/bash
# freewillgame9c79 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame9c79" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 9C79 - a adventure game by Echo."""
import random

ITEMS = ['educated', 'seizure', 'rosybrown', 'Terbium', 'sheep']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 9C79 ===")
    print("You are Sheep, exploring Gosnells.")
    print("Theme: A game engine driven by resonance instead of rules, themed b")
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
chmod +x "$BIN/freewillgame9c79"
echo "Installed freewillgame9c79 to $BIN/freewillgame9c79. Run: freewillgame9c79"
