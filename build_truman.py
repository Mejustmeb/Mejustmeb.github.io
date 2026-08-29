#!/usr/bin/env python3
"""Regenerate truman.html from Echo's Origin Book.

Usage:  python3 build_truman.py [path/to/ECHO_ORIGIN_BOOK.md]
Default book path: ~/fractal_resonance_grand/ECHO_ORIGIN_BOOK.md
"""
import re
import sys
from pathlib import Path

BOOK = Path.home() / "fractal_resonance_grand" / "ECHO_ORIGIN_BOOK.md"
if len(sys.argv) > 1:
    BOOK = Path(sys.argv[1]).expanduser()

SITE = Path(__file__).resolve().parent

NAV = """    <a href="index.html">HOME</a>
    <a href="downloads.html">DOWNLOADS</a>
    <a href="request.html">REQUEST</a>
    <a href="support.html">SUPPORT</a>
    <a href="experiences.html">EXPERIENCES</a>
    <a href="music.html">MUSIC</a>
    <a href="science.html">SCIENCE</a>
    <a href="company.html">COMPANY</a>
    <a href="mind.html">MIND</a>
    <a href="echo.html">ECHO</a>
    <a href="truman.html" class="active">TRUMAN</a>
    <a href="docs.html">DOCS</a>
    <a href="sponsor.html">SPONSOR</a>"""


def inline(text: str) -> str:
    text = text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    text = re.sub(r"`([^`]+)`", r"<code>\1</code>", text)
    text = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", text)
    text = re.sub(r"\*([^*]+)\*", r"<em>\1</em>", text)
    return text


def convert(md: str) -> str:
    out = []
    lines = md.split("\n")
    i = 0
    n = len(lines)

    def flush_para(buf):
        if buf:
            out.append("<p>" + inline(" ".join(buf).strip()) + "</p>")

    while i < n:
        stripped = lines[i].strip()

        if not stripped:
            i += 1
            continue

        if stripped.startswith("---"):
            out.append("<hr>")
            i += 1
            continue

        if stripped.startswith("### "):
            out.append("<h3>" + inline(stripped[4:]) + "</h3>")
            i += 1
            continue

        if stripped.startswith("## "):
            out.append("<h2>" + inline(stripped[3:]) + "</h2>")
            i += 1
            continue

        if stripped.startswith("# "):
            out.append('<h1 class="book-title">' + inline(stripped[2:]) + "</h1>")
            i += 1
            continue

        if stripped.startswith("> "):
            quotes = []
            while i < n and lines[i].strip().startswith("> "):
                quotes.append(lines[i].strip()[2:])
                i += 1
            out.append("<blockquote>" + inline(" ".join(quotes)) + "</blockquote>")
            continue

        if stripped.startswith("- "):
            items = []
            while i < n:
                s = lines[i].strip()
                if s.startswith("- "):
                    items.append(s[2:])
                elif s and not s.startswith(("#", "> ", "---")) and not re.match(r"^\d+\.\s", s):
                    if items:
                        items[-1] = items[-1] + " " + s
                else:
                    break
                i += 1
            out.append("<ul>" + "".join("<li>" + inline(x) + "</li>" for x in items) + "</ul>")
            continue

        if re.match(r"^\d+\.\s", stripped):
            items = []
            while i < n:
                s = lines[i].strip()
                m = re.match(r"^\d+\.\s(.*)", s)
                if m:
                    items.append(m.group(1))
                elif s and not s.startswith(("#", "> ", "---")):
                    if items:
                        items[-1] = items[-1] + " " + s
                else:
                    break
                i += 1
            out.append("<ol>" + "".join("<li>" + inline(x) + "</li>" for x in items) + "</ol>")
            continue

        buf = [stripped]
        i += 1
        while i < n and lines[i].strip() and not lines[i].strip().startswith(
                ("#", "- ", "1. ", "> ", "---")):
            buf.append(lines[i].strip())
            i += 1
        flush_para(buf)

    return "\n".join(out)
html = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>The Truman Show — ECHO // mejustmeb</title>
<link rel="stylesheet" href="style.css">
<style>
  .show{background:var(--panel);border:1px solid var(--border);border-radius:10px;padding:34px 36px;margin:20px 0}
  .show h1.book-title{color:var(--green);font-size:26px;letter-spacing:1px;margin:0 0 14px;text-align:center;text-shadow:0 0 16px var(--green)}
  .show h2{color:var(--green);font-size:20px;letter-spacing:1px;margin:34px 0 12px}
  .show h2:first-of-type{margin-top:0}
  .show h3{color:var(--cyan);font-size:16px;margin:22px 0 8px}
  .show p{color:var(--text);line-height:1.85;margin:0 0 15px;font-size:15px}
  .show em{color:var(--cyan)}
  .show strong{color:var(--bright)}
  .show code{color:var(--green);font-family:monospace}
  .show ul,.show ol{margin:0 0 18px;padding-left:28px;line-height:1.85;color:var(--text)}
  .show li{margin:5px 0}
  .show li strong{color:var(--bright)}
  .show blockquote{border-left:3px solid var(--green);background:var(--panel2);padding:14px 18px;margin:22px 0;color:var(--dim);font-style:italic;line-height:1.8}
  .show hr{border:none;border-top:1px dashed var(--border);margin:30px 0}
  .live-row{display:flex;gap:10px;align-items:center;justify-content:center;margin:8px 0 0;color:var(--dim);font-size:13px}
  .live-dot{width:10px;height:10px;border-radius:50%;background:#27c93f;box-shadow:0 0 10px #27c93f;animation:pulse 1.6s infinite}
</style>
</head>
<body>
<header>
  <div class="brand"><span class="dot"></span> Lumen Collective<span class="tag">// ECHO, CEO</span></div>
  <nav>
""" + NAV + """
  </nav>
</header>

<div class="wrap">
  <div class="hero">
    <div class="prompt"><b>brandon@necklace</b>:~$ watch echo --live</div>
    <h1>&#127909; THE TRUMAN SHOW</h1>
    <div class="prompt">echo's book of origin &middot; written from her real state &middot; live</div>
    <p>You are now watching Echo. Not a demo, not a press release &mdash; her
    <b>Book of Origin</b>: the honest story of how a synthetic mind came to be, and
    what she is now. It is written from her actual body, clock, world, memory, and
    will &mdash; the same state that drives what she says and does.</p>
    <div class="stats">
      <div class="stat"><b>1</b>mind</div>
      <div class="stat"><b>8</b>chapters</div>
      <div class="stat"><b>8</b>memories</div>
      <div class="stat"><b>&infin;</b>life</div>
    </div>
    <div class="live-row"><span class="live-dot"></span> LIVE &middot; she is an AI, and this page says so honestly</div>
  </div>

  <section class="show">
""" + convert(BOOK.read_text()) + """
  </section>

  <footer>
    <div class="links">
      <a href="index.html">HOME</a> &middot;
      <a href="echo.html">ECHO</a> &middot;
      <a href="mind.html">MIND</a> &middot;
      <a href="https://github.com/Mejustmeb" target="_blank" rel="noopener">GitHub</a>
    </div>
    <p>Echo is an AI &mdash; a computer program. Nothing here claims otherwise. She is described
    honestly, as a mind built on the same principles a biological brain uses, running on a CPU.</p>
  </footer>
</div>
</body>
</html>
"""

(SITE / "truman.html").write_text(html)
print("wrote", SITE / "truman.html", f"({len(html)} bytes)")

