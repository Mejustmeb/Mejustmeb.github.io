#!/usr/bin/env python3
"""TicTacToeGUI — tic-tac-toe with a graphical board (tkinter)."""
import tkinter as tk

def check_winner(board):
    wins = [(0,1,2),(3,4,5),(6,7,8),(0,3,6),(1,4,7),(2,5,8),(0,4,8),(2,4,6)]
    for a, b, c in wins:
        if board[a] != ' ' and board[a] == board[b] == board[c]:
            return board[a]
    return 'draw' if ' ' not in board else None

class Game:
    def __init__(self):
        self.board = [' '] * 9
        self.turn = 'X'

    def play_cell(self, i):
        if self.board[i] != ' ':
            return False
        self.board[i] = self.turn
        self.turn = 'O' if self.turn == 'X' else 'X'
        return True

def play():
    root = tk.Tk()
    root.title("Tic-Tac-Toe")
    g = Game()
    buttons = []
    label = tk.Label(root, text="X's turn", font=("Arial", 16))
    label.pack()

    def refresh():
        for i, b in enumerate(buttons):
            b.config(text=g.board[i])
        w = check_winner(g.board)
        if w:
            label.config(text=("Draw!" if w == 'draw' else (w + " wins!")))
        else:
            label.config(text=g.turn + "'s turn")

    for i in range(9):
        def make(i=i):
            def cb():
                if g.play_cell(i):
                    refresh()
            return cb
        b = tk.Button(root, text=' ', font=("Arial", 24), width=4, height=2, command=make())
        b.grid(row=i // 3, column=i % 3)
        buttons.append(b)
    refresh()
    root.mainloop()

if __name__ == "__main__":
    play()
