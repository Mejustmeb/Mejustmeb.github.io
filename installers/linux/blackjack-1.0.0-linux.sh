#!/bin/bash
# blackjack 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/blackjack" << 'PYEOF'
#!/usr/bin/env python3
"""Blackjack — play a simplified hand against the dealer."""
import random

def card():
    return min(10, random.randint(1, 13))

def hand_value(cards):
    total = sum(cards)
    return total if total <= 21 else 0

def dealer_plays(cards):
    while sum(cards) < 17:
        cards.append(card())
    return cards

def play():
    player = [card(), card()]
    dealer = [card(), card()]
    print("Your cards: %s (total %d)" % (player, sum(player)))
    print("Dealer shows: %d" % dealer[0])
    while sum(player) < 21:
        move = input("Hit or stand? (h/s): ").strip().lower()
        if move == "s":
            break
        if move == "h":
            player.append(card())
            print("Your cards: %s (total %d)" % (player, sum(player)))
    if sum(player) > 21:
        print("Bust! Dealer wins.")
        return False
    dealer = dealer_plays(dealer)
    print("Dealer cards: %s (total %d)" % (dealer, sum(dealer)))
    if sum(dealer) > 21 or sum(player) > sum(dealer):
        print("You win!")
        return True
    print("Dealer wins.")
    return False

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/blackjack"
echo "Installed blackjack to $BIN/blackjack. Run: blackjack"
