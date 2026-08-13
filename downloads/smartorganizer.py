#!/usr/bin/env python3
"""
SmartOrganizer v1.0.0 — Organize any folder by file type, safely.
==========================================================
A production-quality file organizer. Scans a directory, groups files
into category folders (images, documents, audio, video, code, archives),
with a --dry-run preview and an --undo feature so nothing is ever lost.

Usage:
    python3 smartorganizer.py /path/to/folder          # organize
    python3 smartorganizer.py /path/to/folder --dry-run # preview only
    python3 smartorganizer.py --undo /path/to/folder    # undo last run
"""

import argparse
import json
import os
import shutil
import sys
from collections import defaultdict
from pathlib import Path

VERSION = "1.0.0"

# File type -> category mapping
CATEGORIES = {
    "Images":    [".jpg", ".jpeg", ".png", ".gif", ".bmp", ".svg", ".webp", ".heic", ".tiff"],
    "Documents": [".pdf", ".doc", ".docx", ".txt", ".md", ".rtf", ".odt", ".pages", ".csv", ".xls", ".xlsx", ".pptx"],
    "Audio":     [".mp3", ".wav", ".flac", ".aac", ".m4a", ".ogg", ".wma"],
    "Video":     [".mp4", ".mov", ".avi", ".mkv", ".wmv", ".flv", ".webm"],
    "Code":      [".py", ".js", ".ts", ".java", ".c", ".cpp", ".h", ".go", ".rs", ".html", ".css", ".json", ".sh", ".ve"],
    "Archives":  [".zip", ".rar", ".7z", ".tar", ".gz", ".bz2", ".xz"],
    "Apps":      [".dmg", ".pkg", ".exe", ".msi", ".deb", ".rpm", ".app"],
}

UNDO_LOG = Path.home() / ".smartorganizer_undo.json"


def categorize(ext: str) -> str:
    """Return the category folder for a file extension, or 'Other'."""
    ext = ext.lower()
    for category, exts in CATEGORIES.items():
        if ext in exts:
            return category
    return "Other"


def scan(directory: Path):
    """Walk the directory and map each file to its target category folder."""
    plan = defaultdict(list)
    for item in directory.iterdir():
        if item.is_file():
            cat = categorize(item.suffix)
            plan[cat].append(item)
    return plan


def organize(directory: Path, dry_run: bool = False):
    """Move files into category folders. Returns the move log for undo."""
    plan = scan(directory)
    move_log = []

    for category, files in sorted(plan.items()):
        if not files:
            continue
        target_dir = directory / category
        if not dry_run:
            target_dir.mkdir(exist_ok=True)

        for src in files:
            dst = target_dir / src.name
            # Never overwrite — append a number if name collision
            if dst.exists() and dst != src:
                stem, suffix = dst.stem, dst.suffix
                counter = 1
                while dst.exists():
                    dst = target_dir / f"{stem}_{counter}{suffix}"
                    counter += 1

            if dry_run:
                print(f"  [dry-run] {src.name} -> {category}/")
            else:
                shutil.move(str(src), str(dst))
                print(f"  {src.name} -> {category}/")
                move_log.append({"from": str(src), "to": str(dst)})

    return move_log


def undo():
    """Reverse the last organize run."""
    if not UNDO_LOG.exists():
        print("No previous run to undo.")
        return

    log = json.loads(UNDO_LOG.read_text())
    for entry in reversed(log):
        src = Path(entry["to"])
        dst = Path(entry["from"])
        if src.exists():
            shutil.move(str(src), str(dst))
            print(f"  restored {src.name} -> {dst.parent.name}/")
    UNDO_LOG.unlink()
    print("Undo complete.")


def main():
    parser = argparse.ArgumentParser(description="Organize files by type, safely.")
    parser.add_argument("folder", nargs="?", help="Folder to organize")
    parser.add_argument("--dry-run", action="store_true", help="Preview without moving")
    parser.add_argument("--undo", action="store_true", help="Undo the last organize run")
    parser.add_argument("--version", action="version", version=f"SmartOrganizer {VERSION}")
    args = parser.parse_args()

    if args.undo:
        undo()
        return

    if not args.folder:
        parser.error("provide a folder to organize, or use --undo")

    directory = Path(args.folder).expanduser().resolve()
    if not directory.is_dir():
        print(f"Error: '{directory}' is not a directory.")
        sys.exit(1)

    print(f"Organizing: {directory}")
    print(f"Mode: {'dry-run (preview)' if args.dry_run else 'live'}")
    print()

    move_log = organize(directory, dry_run=args.dry_run)

    if not args.dry_run and move_log:
        UNDO_LOG.write_text(json.dumps(move_log, indent=2))

    print()
    print(f"Done. {len(move_log)} files organized.")


if __name__ == "__main__":
    main()
