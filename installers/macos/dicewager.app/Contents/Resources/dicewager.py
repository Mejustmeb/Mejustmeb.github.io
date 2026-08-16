#!/usr/bin/env python3
"""DiceWager — roll dice and wager on the total."""
import random

def roll():
    return random.randint(1, 6) + random.randint(1, 6)

def settle(balance, bet, won):
    return balance + bet if won else balance - bet

def play():
    balance = 100
    while balance > 0:
        print('Balance:', balance)
        guess = input('Bet high (8+), low (6-), or seven? (q to quit): ').strip().lower()
        if guess == 'q':
            break
        bet = int(input('Wager: '))
        total = roll()
        won = (guess == 'high' and total >= 8) or (guess == 'low' and total <= 6) or (guess == 'seven' and total == 7)
        balance = settle(balance, bet, won)
        print('Rolled %d - %s' % (total, 'you win!' if won else 'you lose.'))
    print('Final balance:', balance)

if __name__ == "__main__":
    play()
