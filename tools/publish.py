import os
import re
import glob
import json
from datetime import datetime

DRAFTS_DIR = "drafts"
ENTRIES_DIR = "entries"


def pick_hero_image(sources_text: str) -> str:
  if not sources_text:
    return ""

  # 1) Markdown image: ![alt](url)
  m = re.search(r"!\[[^\]]*\]\((https?://[^\s)]+)\)", sources_text, re.I)
  if m:
    return m.group(1).strip()

  # 2) Plain URL ending in an image extension
  m = re.search(r"(https?://[^\s]+?\.(?:png|jpg|jpeg|webp|gif))(?:\?[^\s]*)?", sources_text, re.I)
  if m:
    return m.group(1).strip()

  return ""


def norm(s: str) -> str:
  s = (s or "").lower()
  s = re.sub(r"[^a-z0-9]+", " ", s)
  s = re.sub(r"\s+", " ", s).strip()
  return s


def is_probable_duplicate(a_title: str, b_title: str) -> bool:
  a = set(norm(a_title).split())
  b = set(norm(b_title).split())
  if not a or not b:
    return False
  overlap = len(a & b) / max(1, min(len(a), len(b)))
  return overlap >= 0.75


def safe_filename(s: str) -> str:
  s = (s or "").lower()
  s = re.sub(r"[^a-z0-9]+", "-", s).strip("-")
  return (s[:60] if s else "entry")


ENTRY_TEMPLATE = """<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>{title}</title>
  <style>
    body {{ font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif; margin: 0; background: #0b0f14; color: #e6edf3; }}
    .wrap {{ max-width: 980px; margin: 0 auto; padding: 24px; }}
    a {{ color: #7aa2ff; text-decoration: none; }}
    a:hover {{ text-decoration: underline; }}

    .topnav {{ display:flex; gap:12px; align-items:center; margin-bottom: 18px; flex-wrap: wrap; }}
    .pill {{ display:inline-block; padding:6px 10px; border-radius: 999px; background:#0e1522; border:1px solid #223; font-size: 13px; opacity:.95; }}

    .card {{ background: #121826; border: 1px solid #223; border-radius: 18px; padding: 18px; box-shadow: 0 8px 30px rgba(0,0,0,.35); }}
    h1 {{ margin: 0 0 10px 0; font-size: 30px; }}
    .meta {{ opacity: .8; font-size: 14px; margin-top: 6px; }}

    .hero {{
      margin-top: 14px;
      height: 220px;
      border-radius: 16px;
      border: 1px solid #223;
      background: {hero_bg};
      overflow: hidden;
      position: relative;
    }}
    .hero img {{
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: {hero_img_display};
    }}
    .hero .badge {{
      position: absolute;
      left: 12px;
      bottom: 12px;
      padding: 6px 10px;
      border-radius: 999px;
      background: rgba(0,0,0,.35);
      border: 1px solid rgba(255,255,255,.10);
      font-size: 12px;
      opacity: .95;
    }}

    details {{
      margin-top: 14px;
      background: #0e1522;
      border: 1px solid #223;
      border-radius: 14px;
      padding: 10px 12px;
    }}
    summary {{
      cursor: pointer;
      font-weight: 800;
      list-style: none;
    }}
    summary::-webkit-details-marker {{ display:none; }}
    .pre {{
      white-space: pre-wrap;
      word-wrap: break-word;
      margin-top: 10px;
      padding: 10px;
      border-radius: 12px;
      border: 1px solid #223;
      background: #0b0f14;
    }}

    .related-wrap {{ margin-top: 18px; }}
    .grid {{ display:grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 12px; margin-top: 10px; }}
    .tile {{ background:#0e1522; border:1px solid #223; border-radius: 16px; padding: 12px; }}
    .tile .tag {{ font-size: 12px; opacity: .8; }}
    .tile .t {{ font-weight: 900; margin-top: 6px; line-height: 1.2; }}
  </style>
</head>
<body>
  <div class="wrap">
    <div class="topnav">
      <a href="/"><span class="pill">Home</span></a>
      <a href="/entries/"><span class="pill">Entries</span></a>
      <span class="pill">{category}</span>
      <span class="pill">Issue #{issue}</span>
    </div>

    <div class="card">
      <h1>{title}</h1>
      <div class="meta">Published: <b>{published}</b></div>

      <div class="hero">
        <img src="{hero_img}" alt="" />
        <div class="badge">Visual slot • auto-ready</div>
      </div>

      <details open>
        <summary>Summary (skim fast)</summary>
        <div class="pre">{summary}</div>
      </details>

      <details>
        <summary>Details (expand)</summary>
        <div class="pre">{details}</div>
      </details>

      <details>
        <summary>Sources (expand)</summary>
        <div class="pre">{sources}</div>
      </details>

      <div class="related-wrap">
        <div class="meta" style="margin-top:6px;"><b>Related tiles</b></div>
        <div id="related" class="grid">
          <div class="meta">Loading…</div>
        </div>
      </div>
    </div>
  </div>

<script>
const CATEGORY = "{category_js}";
const CURRENT_PATH = "{current_path}";

fetch("/entries/entries.json")
  .then(r => r.json())
  .then(items => {{
    const rel = items
      .filter(it => (it.category || "") === CATEGORY && it.path !== CURRENT_PATH)
      .slice(-6)
      .reverse();

    const el = document.getElementById("related");
    if (!rel.length) {{
      el.innerHTML = '<div class="meta">No related entries yet.</div>';
      return;
    }}

    el.innerHTML = rel.map(it => `
      <a class="tile" href="${{it.path}}" style="display:block;">
        <div class="tag">${{it.category}} • #${{it.issue}}</div>
        <div class="t">${{it.title}}</div>
        <div class="tag" style="margin-top:8px;">Open →</div>
      </a>
    `).join("");
  }})
  .catch(() => {{
    document.getElementById("related").innerHTML = '<div class="meta">Failed to load related.</div>';
  }});
</script>
</body>
</html>
"""


def read_draft(path: str) -> dict:
  text = open(path, "r", encoding="utf-8").read()

  fm = {}
  if text.startswith("---"):
    parts = text.split("---", 2)
    if len(parts) >= 3:
      fm_text = parts[1].strip()
      body = parts[2].strip()
      for line in fm_text.splitlines():
        if ":" in line:
          k, v = line.split(":", 1)
          fm[k.strip()] = v.strip().strip('"')
    else:
      body = text
  else:
    body = text

  def section(name: str) -> str:
    m = re.search(rf"^##\s+{re.escape(name)}\s*$([\s\S]*?)(?=^##\s+|\Z)", body, re.M)
    return (m.group(1).strip() if m else "").strip()

  m_title = re.search(r"^#\s+(.*)$", body, re.M)
  title = fm.get("title") or (m_title.group(1).strip() if m_title else "Untitled")

  return {
    "title": title,
    "category": fm.get("category", "Other"),
    "issue": fm.get("issue", "").replace("#", "") or "0",
    "created": fm.get("created", ""),
    "confidence": fm.get("confidence", "medium"),
    "summary": section("Summary") or "- (none provided)",
    "details": section("Details") or "- (none provided)",
    "sources": section("Sources") or "- (none provided)",
  }


def build_entries_listing() -> str:
  return """<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Entries</title>
  <style>
    body { font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif; margin: 0; background: #0b0f14; color: #e6edf3; }
    .wrap { max-width: 980px; margin: 0 auto; padding: 24px; }
    a { color: #7aa2ff; text-decoration: none; }
    a:hover { text-decoration: underline; }
    .card { background: #121826; border: 1px solid #223; border-radius: 16px; padding: 18px; box-shadow: 0 8px 30px rgba(0,0,0,.35); }
    .row { display:flex; justify-content: space-between; gap: 14px; padding: 10px 0; border-bottom: 1px solid #223; }
    .row:last-child { border-bottom: none; }
    .pill { display:inline-block; padding:6px 10px; border-radius: 999px; background:#0e1522; border:1px solid #223; font-size: 13px; opacity:.95; }
    .topnav { display:flex; gap:12px; align-items:center; margin-bottom: 18px; }
    .muted { opacity:.8; font-size: 13px; }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="topnav">
      <a href="/"><span class="pill">Home</span></a>
      <span class="pill">Entries</span>
    </div>

    <div class="card">
      <h1 style="margin:0 0 12px 0;">Entries</h1>
      <div id="list" class="muted">Loading…</div>
    </div>
  </div>

<script>
fetch('./entries.json')
  .then(r => r.json())
  .then(items => {
    const el = document.getElementById('list');
    if (!items.length) { el.textContent = 'No entries yet.'; return; }
    el.className = '';
    el.innerHTML = items.map(it => `
      <div class="row">
        <div>
          <div><a href="${it.dupe_of || it.path}"><b>${it.title}</b></a></div>
          <div class="muted">${it.category} • Issue #${it.issue} • ${it.dupe_of ? "♻️ Duplicate" : (it.confidence || "medium")}</div>
        </div>
        <div class="muted">→</div>
      </div>
    `).join('');
  })
  .catch(() => {
    document.getElementById('list').textContent = 'Failed to load entries.';
  });
</script>
</body>
</html>
"""


def main():
  os.makedirs(ENTRIES_DIR, exist_ok=True)

  drafts = sorted(glob.glob(os.path.join(DRAFTS_DIR, "draft-*.md")))
  entries_index = []
  seen = []  # list of (title, path, issue)

  for d in drafts:
    data = read_draft(d)
    issue = data["issue"]
    slug = safe_filename(data["title"])
    out_name = f"entry-{str(issue).zfill(4)}-{slug}.html"
    out_path = os.path.join(ENTRIES_DIR, out_name)

    dupe_of = ""
    for (t, p, iss) in seen:
      if is_probable_duplicate(data["title"], t):
        dupe_of = p
        break

    published = datetime.utcnow().strftime("%Y-%m-%d %H:%M UTC")

    hero_img = pick_hero_image(data.get("sources", ""))

    html = ENTRY_TEMPLATE.format(
      title=data["title"],
      category=data["category"],
      issue=issue,
      published=published,
      summary=data["summary"],
      details=data["details"],
      sources=data["sources"],
      hero_img=hero_img,
      hero_img_display=("none" if not hero_img else "block"),
      hero_bg=("linear-gradient(135deg, #1b2a55, #1a3a2a)" if not hero_img else "#000"),
      category_js=data["category"].replace('"', '\\"'),
      current_path=f"/entries/{out_name}",
    )

    open(out_path, "w", encoding="utf-8").write(html)

    entries_index.append({
      "title": data["title"],
      "category": data["category"],
      "issue": issue,
      "path": f"/entries/{out_name}",
      "confidence": data.get("confidence", "medium"),
      "dupe_of": dupe_of,
    })

    seen.append((data["title"], f"/entries/{out_name}", issue))

  open(os.path.join(ENTRIES_DIR, "entries.json"), "w", encoding="utf-8").write(
    json.dumps(entries_index, indent=2)
  )

  open(os.path.join(ENTRIES_DIR, "index.html"), "w", encoding="utf-8").write(
    build_entries_listing()
  )


if __name__ == "__main__":
  main()
