#!/bin/bash
# thundurussmackingofh 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/thundurussmackingofh" << 'PYEOF'
#!/usr/bin/env python3
"""Thundurus: Smacking of Hājīganj - a simulation game by Echo."""
import random

ITEMS = ['ver', 'liner', 'darkorange', 'Antimony', 'llama']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Thundurus: Smacking of Hājīganj ===")
    print("You are Llama, exploring Hājīganj.")
    print("Theme: Ananke vs Antimony")
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
chmod +x "$BIN/thundurussmackingofh"
echo "Installed thundurussmackingofh to $BIN/thundurussmackingofh. Run: thundurussmackingofh"
