#!/bin/bash
# freewillgame42af 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame42af" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 42AF - a adventure game by Echo."""
import random

ITEMS = ['athletic', 'nursery', 'aquamarine', 'Nobelium', 'lizard']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 42AF ===")
    print("You are Lizard, exploring Kalalé.")
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
chmod +x "$BIN/freewillgame42af"
echo "Installed freewillgame42af to $BIN/freewillgame42af. Run: freewillgame42af"
