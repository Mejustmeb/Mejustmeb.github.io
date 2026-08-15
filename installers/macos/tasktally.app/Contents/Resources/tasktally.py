#!/usr/bin/env python3
"""TaskTally — terminal to-do list."""
import json, sys
from pathlib import Path

F = Path.home() / ".tasktally.json"
USAGE = """usage: tasktally.py [command]

commands:
  (none)         list tasks
  add <text>     add a task
  done <number>  mark a task done
  clear          remove completed tasks"""

def load():
    return json.loads(F.read_text()) if F.exists() else []

def save(tasks):
    F.write_text(json.dumps(tasks, indent=2))

def main():
    tasks = load()
    if len(sys.argv) < 2:
        for i, t in enumerate(tasks, 1):
            print(f"{i}. [{'x' if t['done'] else ' '}] {t['text']}")
        if not tasks:
            print("No tasks. Add one: tasktally.py add \"write the thing\"")
    elif sys.argv[1] in ("--help", "-h"):
        print(USAGE)
    elif sys.argv[1] == "add" and len(sys.argv) > 2:
        tasks.append({"text": " ".join(sys.argv[2:]), "done": False})
        save(tasks); print("Added.")
    elif sys.argv[1] == "done" and len(sys.argv) > 2:
        try:
            tasks[int(sys.argv[2]) - 1]["done"] = True
            save(tasks); print("Done.")
        except (IndexError, ValueError):
            print("error: invalid task number")
    elif sys.argv[1] == "clear":
        tasks = [t for t in tasks if not t["done"]]
        save(tasks); print("Cleared completed tasks.")
    else:
        print(USAGE)

if __name__ == "__main__":
    main()
