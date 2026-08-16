#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""Mine3D — a 3D minesweeper on a cube (26-neighbour mine counting)."""
import random

def neighbors(x, y, z, n):
    for dx in (-1, 0, 1):
        for dy in (-1, 0, 1):
            for dz in (-1, 0, 1):
                if dx == dy == dz == 0:
                    continue
                nx, ny, nz = x + dx, y + dy, z + dz
                if 0 <= nx < n and 0 <= ny < n and 0 <= nz < n:
                    yield (nx, ny, nz)

def place_mines(n, k):
    mines = set()
    while len(mines) < k:
        mines.add((random.randint(0, n - 1), random.randint(0, n - 1), random.randint(0, n - 1)))
    return mines

def count_adjacent(coord, mines, n):
    return sum(1 for nb in neighbors(*coord, n=n) if nb in mines)

def build_grid(n, mines):
    g = {}
    for x in range(n):
        for y in range(n):
            for z in range(n):
                g[(x, y, z)] = -1 if (x, y, z) in mines else count_adjacent((x, y, z), mines, n)
    return g

def render(grid, n, revealed):
    lines = []
    for z in range(n - 1, -1, -1):
        lines.append("Layer z=%d" % z)
        for x in range(n):
            row = []
            for y in range(n):
                c = (x, y, z)
                if c in revealed:
                    row.append("X" if grid[c] == -1 else str(grid[c]))
                else:
                    row.append(".")
            lines.append("  " + " ".join(row))
        lines.append("")
    return chr(10).join(lines)

def flood(grid, n, start, revealed):
    stack = [start]
    while stack:
        c = stack.pop()
        if c in revealed:
            continue
        revealed.add(c)
        if grid[c] == 0:
            for nb in neighbors(*c, n=n):
                if nb not in revealed:
                    stack.append(nb)

def play():
    n = 4
    mines = place_mines(n, 6)
    grid = build_grid(n, mines)
    revealed = set()
    total_safe = n ** 3 - len(mines)
    print("Mine3D — a %dx%dx%d cube. Reveal cells (x,y,z). Avoid mines." % (n, n, n))
    while True:
        print()
        print(render(grid, n, revealed))
        inp = input("Reveal x,y,z (or q): ").strip()
        if inp == "q":
            return False
        try:
            x, y, z = map(int, inp.split(","))
        except Exception:
            print("Use x,y,z like 1,2,0")
            continue
        coord = (x, y, z)
        if not (0 <= x < n and 0 <= y < n and 0 <= z < n):
            continue
        if coord in mines:
            print("BOOM! You hit a mine.")
            return False
        flood(grid, n, coord, revealed)
        if len(revealed) == total_safe:
            print("You cleared the cube!")
            return True

if __name__ == "__main__":
    play()
