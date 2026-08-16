#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""WagerGuess — guess the number, but bet points on every guess."""
import random

def evaluate_number(answer, guess):
    return -1 if guess < answer else (1 if guess > answer else 0)

def wager_points(balance, bet, correct):
    return balance + bet if correct else balance - bet

def play():
    answer = random.randint(1, 20)
    balance = 100
    print('Guess 1-20, bet points each guess. Start: 100')
    while balance > 0:
        print('Balance:', balance)
        guess = int(input('Guess: '))
        bet = int(input('Bet: '))
        r = evaluate_number(answer, guess)
        if r == 0:
            balance = wager_points(balance, bet, True)
            print('Correct! New balance:', balance); return True
        balance = wager_points(balance, bet, False)
        print('Too low!' if r < 0 else 'Too high!')
    print('Broke!'); return False

if __name__ == "__main__":
    play()
