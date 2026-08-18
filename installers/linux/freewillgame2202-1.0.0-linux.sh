#!/bin/bash
# freewillgame2202 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame2202" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 2202 - a adventure game by Echo."""
import random

ITEMS = ['virtue', 'fusion', 'ivory', 'Neptunium', 'porcupine']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 2202 ===")
    print("You are Porcupine, exploring Arabkir.")
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
chmod +x "$BIN/freewillgame2202"
echo "Installed freewillgame2202 to $BIN/freewillgame2202. Run: freewillgame2202"
