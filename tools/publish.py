import os, re, glob, json
from datetime import datetime

DRAFTS_DIR = "drafts"
ENTRIES_DIR = "entries"

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
    .card {{ background: #121826; border: 1px solid #223; border-radius: 16px; padding: 18px; box-shadow: 0 8px 30px rgba(0,0,0,.35); }}
    .meta {{ opacity: .8; font-size: 14px; margin-top: 8px; }}
    h1 {{ margin: 0 0 10px 0; font-size: 30px; }}
    h2 {{ margin-top: 22px; font-size: 18px; opacity: .95; }}
    pre {{ white-space: pre-wrap; word-wrap: break-word; background: #0e1522; padding: 12px; border-radius: 12px; border: 1px solid #223; }}
    .topnav {{ display:flex; gap:12px; align-items:center; margin-bottom: 18px; }}
    .pill {{ display:inline-block; padding:6px 10px; border-radius: 999px; background:#0e1522; border:1px solid #223; font-size: 13px; opacity:.95; }}
  </style>
</head>
<body>
  <div class="wrap">
    <div class="topnav">
      <a href="/"><span class="pill">Home</span></a>
      <a href="/entries/"><span class="pill">Entries</span></a>
    </div>

    <div class="card">
      <h1>{title}</h1>
      <div class="meta">
        Category: <b>{category}</b> • Issue: <b>#{issue}</b> • Published: <b>{published}</b>
      </div>

      <h2>Summary</h2>
      <pre>{summary}</pre>

      <h2>Details</h2>
      <pre>{details}</pre>

      <h2>Sources</h2>
      <pre>{sources}</pre>
    </div>
  </div>
</body>
</html>
"""

def read_draft(path: str) -> dict:
  text = open(path, "r", encoding="utf-8").read()
  # crude frontmatter split
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

  # sections
  def section(name: str) -> str:
    m = re.search(rf"^##\s+{re.escape(name)}\s*$([\s\S]*?)(?=^##\s+|\Z)", body, re.M)
    return (m.group(1).strip() if m else "").strip()

  title = fm.get("title") or re.search(r"^#\s+(.*)$", body, re.M).group(1).strip()
  return {
    "title": title,
    "category": fm.get("category", "Other"),
    "issue": fm.get("issue", "").replace("#", "") or "0",
    "created": fm.get("created", ""),
    "summary": section("Summary") or "- (none provided)",
    "details": section("Details") or "- (none provided)",
    "sources": section("Sources") or "- (none provided)",
  }

def safe_filename(s: str) -> str:
  s = s.lower()
  s = re.sub(r"[^a-z0-9]+", "-", s).strip("-")
  return (s[:60] if s else "entry")

def main():
  os.makedirs(ENTRIES_DIR, exist_ok=True)

  drafts = sorted(glob.glob(os.path.join(DRAFTS_DIR, "draft-*.md")))
  entries_index = []

  for d in drafts:
    data = read_draft(d)
    issue = data["issue"]
    slug = safe_filename(data["title"])
    out_name = f"entry-{str(issue).zfill(4)}-{slug}.html"
    out_path = os.path.join(ENTRIES_DIR, out_name)

    published = datetime.utcnow().strftime("%Y-%m-%d %H:%M UTC")
    html = ENTRY_TEMPLATE.format(
      title=data["title"],
      category=data["category"],
      issue=issue,
      published=published,
      summary=data["summary"],
      details=data["details"],
      sources=data["sources"],
    )
    open(out_path, "w", encoding="utf-8").write(html)

    entries_index.append({
      "title": data["title"],
      "category": data["category"],
      "issue": issue,
      "path": f"/entries/{out_name}",
    })

  # Write entries listing page + JSON
  open(os.path.join(ENTRIES_DIR, "entries.json"), "w", encoding="utf-8").write(
    json.dumps(entries_index, indent=2)
  )

  listing = """<!doctype html>
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
          <div><a href="${it.path}"><b>${it.title}</b></a></div>
          <div class="muted">${it.category} • Issue #${it.issue}</div>
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
  open(os.path.join(ENTRIES_DIR, "index.html"), "w", encoding="utf-8").write(listing)

if __name__ == "__main__":
  main()
