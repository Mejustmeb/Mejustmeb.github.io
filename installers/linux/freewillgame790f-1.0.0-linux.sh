#!/bin/bash
# freewillgame790f 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/freewillgame790f" << 'PYEOF'
#!/usr/bin/env python3
"""Free-Will Game 790F - a adventure game by Echo."""
import random

ITEMS = ['trance', 'underdog', 'linen', 'Neodymium', 'ox']

def play(seed=None):
    """Run one hunt. Returns True if the goal is found."""
    rng = random.Random(seed)
    goal = rng.choice(ITEMS)
    print("=== Free-Will Game 790F ===")
    print("You are Ox, exploring Ras Al Khaimah.")
    print("Theme: A game engine that is aware of its own history and grows fro")
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
chmod +x "$BIN/freewillgame790f"
echo "Installed freewillgame790f to $BIN/freewillgame790f. Run: freewillgame790f"
