#!/bin/bash
# freewillgameba80 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgameba80" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game BA80 - a adventure game by Echo."""
import random

ITEMS = ['retention', 'juror', 'silver', 'Fermium', 'shrew']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game BA80 ===")
    print("You are Shrew, exploring Bourzanga.")
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
chmod +x "$BIN/freewillgameba80"
echo "Installed freewillgameba80 to $BIN/freewillgameba80. Run: freewillgameba80"
