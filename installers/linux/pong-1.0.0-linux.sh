#!/bin/bash
# pong 1.0.0 — self-extracting installer
set -e
BIN="$HOME/.local/bin"
mkdir -p "$BIN"
cat > "$BIN/pong" << 'PYEOF'
#!/usr/bin/env python3
"""Pong — the classic paddle game (tkinter)."""
import tkinter as tk

def move_paddle(y, direction, height, size=60):
    dy = -10 if direction == "up" else 10
    return max(0, min(height - size, y + dy))

def bounce(vy):
    return -vy

class Game:
    def __init__(self, width=400, height=300):
        self.width = width
        self.height = height
        self.paddle_y = height // 2
        self.ball = [width // 2, height // 2]
        self.ball_v = [3, 3]

    def tick(self):
        self.ball[0] += self.ball_v[0]
        self.ball[1] += self.ball_v[1]
        if self.ball[1] <= 0 or self.ball[1] >= self.height:
            self.ball_v[1] = bounce(self.ball_v[1])

def play():
    root = tk.Tk()
    root.title("Pong")
    g = Game()
    canvas = tk.Canvas(root, width=g.width, height=g.height, bg="black")
    canvas.pack()

    def on_key(event):
        if event.keysym == "Up":
            g.paddle_y = move_paddle(g.paddle_y, "up", g.height)
        elif event.keysym == "Down":
            g.paddle_y = move_paddle(g.paddle_y, "down", g.height)

    def draw():
        canvas.delete("all")
        canvas.create_rectangle(10, g.paddle_y, 20, g.paddle_y + 60, fill="white")
        bx, by = g.ball
        canvas.create_oval(bx - 5, by - 5, bx + 5, by + 5, fill="white")

    def loop():
        g.tick()
        draw()
        root.after(16, loop)

    root.bind("<Key>", on_key)
    draw()
    root.after(16, loop)
    root.mainloop()

if __name__ == "__main__":
    play()

PYEOF
chmod +x "$BIN/pong"
echo "Installed pong to $BIN/pong. Run: pong"
