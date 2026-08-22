#!/bin/bash
# freewillgamef6f5 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgamef6f5" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game F6F5 - a adventure game by Echo."""
import random

ITEMS = ['reprint', 'recurrence', 'gray', 'Xenon', 'coyote']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game F6F5 ===")
    print("You are Coyote, exploring Palm Beach.")
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
chmod +x "$BIN/freewillgamef6f5"
echo "Installed freewillgamef6f5 to $BIN/freewillgamef6f5. Run: freewillgamef6f5"
