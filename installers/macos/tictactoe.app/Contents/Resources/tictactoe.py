#!/usr/bin/env python3
"""TicTacToe — play tic-tac-toe against a simple computer."""
import random

def check_winner(board):
    wins = [(0,1,2),(3,4,5),(6,7,8),(0,3,6),(1,4,7),(2,5,8),(0,4,8),(2,4,6)]
    for a, b, c in wins:
        if board[a] != ' ' and board[a] == board[b] == board[c]:
            return board[a]
    return 'draw' if ' ' not in board else None

def announce(w):
    if w == 'X': return "You win!"
    if w == 'O': return "Computer wins!"
    return "Draw!"

def render(board):
    for i in (0, 3, 6):
        print(" " + " | ".join(board[i:i+3]) + " ")
    print()

def computer_move(board):
    empty = [i for i, c in enumerate(board) if c == ' ']
    return random.choice(empty) if empty else -1

def play():
    board = [' '] * 9
    print("You are X. Enter a cell 1-9.")
    while True:
        render(board)
        move = int(input("Your move (1-9): ")) - 1
        if board[move] != ' ':
            print("Taken!")
            continue
        board[move] = 'X'
        w = check_winner(board)
        if w:
            render(board)
            print(announce(w))
            return
        cm = computer_move(board)
        if cm < 0:
            print("Draw!")
            return
        board[cm] = 'O'
        w = check_winner(board)
        if w:
            render(board)
            print(announce(w))
            return

if __name__ == "__main__":
    play()
