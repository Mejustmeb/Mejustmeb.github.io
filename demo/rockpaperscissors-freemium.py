#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""RockPaperScissors — play rock-paper-scissors against the computer."""
import random

BEATS = {"rock": "scissors", "scissors": "paper", "paper": "rock"}

def outcome(player, computer):
    if player == computer:
        return "draw"
    return "win" if BEATS[player] == computer else "lose"

def play():
    score = {"win": 0, "lose": 0, "draw": 0}
    print("Rock, paper, scissors! Type 'quit' to stop.")
    while True:
        player = input("Your move: ").strip().lower()
        if player == "quit":
            break
        if player not in BEATS:
            print("Choose rock, paper, or scissors.")
            continue
        computer = random.choice(list(BEATS))
        r = outcome(player, computer)
        score[r] += 1
        print("Computer: %s - you %s!" % (computer, r))
    print("Final score:", score)

if __name__ == "__main__":
    play()
