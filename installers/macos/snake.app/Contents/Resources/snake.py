#!/usr/bin/env python3
"""Snake — the classic snake game (tkinter)."""
import random
import tkinter as tk

DIRS = {"Up": (0, -1), "Down": (0, 1), "Left": (-1, 0), "Right": (1, 0)}

def step(snake, direction):
    dx, dy = DIRS[direction]
    hx, hy = snake[0]
    return [(hx + dx, hy + dy)] + snake[:-1]

def hits_self(snake):
    return snake[0] in snake[1:]

def hits_wall(head, width, height):
    x, y = head
    return x < 0 or y < 0 or x >= width or y >= height

class Game:
    def __init__(self, width=20, height=20):
        self.width = width
        self.height = height
        self.snake = [(width // 2, height // 2)]
        self.direction = "Right"
        self.food = self._place_food()
        self.score = 0
        self.over = False

    def _place_food(self):
        while True:
            f = (random.randint(0, self.width - 1), random.randint(0, self.height - 1))
            if f not in self.snake:
                return f

    def tick(self):
        if self.over:
            return
        self.snake = step(self.snake, self.direction)
        head = self.snake[0]
        if hits_wall(head, self.width, self.height) or hits_self(self.snake):
            self.over = True
            return
        if head == self.food:
            self.snake.append(self.snake[-1])
            self.score += 1
            self.food = self._place_food()

def play():
    root = tk.Tk()
    root.title("Snake")
    g = Game()
    canvas = tk.Canvas(root, width=400, height=400, bg="black")
    canvas.pack()

    def on_key(event):
        if event.keysym in DIRS:
            g.direction = event.keysym

    def draw():
        canvas.delete("all")
        cs = 400 // g.width
        for x, y in g.snake:
            canvas.create_rectangle(x * cs, y * cs, (x + 1) * cs, (y + 1) * cs, fill="green")
        fx, fy = g.food
        canvas.create_rectangle(fx * cs, fy * cs, (fx + 1) * cs, (fy + 1) * cs, fill="red")
        canvas.create_text(200, 10, text="Score: %d" % g.score, fill="white")

    def loop():
        if not g.over:
            g.tick()
            draw()
            root.after(100, loop)
        else:
            canvas.create_text(200, 200, text="Game Over", fill="white", font=("Arial", 30))

    root.bind("<Key>", on_key)
    draw()
    root.after(100, loop)
    root.mainloop()

if __name__ == "__main__":
    play()
