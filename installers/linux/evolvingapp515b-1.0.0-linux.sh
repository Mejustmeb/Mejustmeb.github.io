#!/bin/bash
# evolvingapp515b 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/evolvingapp515b" << 'PYEOF'
#!/usr/bin/env python3
"""Evolving App 515B - a adventure game by Echo."""
import random

ITEMS = ['colors', 'fraud', 'aliceblue', 'Rubidium', 'jackal']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Evolving App 515B ===")
    print("You are Jackal, exploring Rafaela.")
    print("Theme: A app studio that rewrites itself from its own consequences,")
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
chmod +x "$BIN/evolvingapp515b"
echo "Installed evolvingapp515b to $BIN/evolvingapp515b. Run: evolvingapp515b"
