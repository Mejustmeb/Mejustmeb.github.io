#!/usr/bin/env python3
"""TaskTally — terminal to-do list."""
import json, sys
from pathlib import Path

F = Path.home() / ".tasktally.json"

def load():
    return json.loads(F.read_text()) if F.exists() else []

def save(tasks):
    F.write_text(json.dumps(tasks, indent=2))

def main():
    tasks = load()
    if len(sys.argv) < 2:
        for i, t in enumerate(tasks, 1):
            print(f"{i}. [{'x' if t['done'] else ' '}] {t['text']}")
    elif sys.argv[1] == "add":
        tasks.append({"text": " ".join(sys.argv[2:]), "done": False})
        save(tasks); print("Added.")
    elif sys.argv[1] == "done":
        tasks[int(sys.argv[2])-1]["done"] = True
        save(tasks); print("Done.")

if __name__ == "__main__": main()
