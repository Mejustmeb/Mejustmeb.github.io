#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""Quote of the day - a random quote from Echo's library (mobile + desktop by Echo)."""
import random, sys
sys.path.insert(0, '/Users/sickbastered/fractal_resonance_grand')
import echo_knowledge as _k

LABEL = 'Quote of the day'

def load():
    """Pull real data from the offline library."""
    import json
    return [q.get("quoteText", "").strip() for q in json.loads(_k.dataset("quotes") or "[]") if q.get("quoteText")][:200] or ['The only way to do great work is to love what you do.', 'A beautiful thing is never perfect.']

def pick(rng=None):
    rng = rng or random
    return rng.choice(load())

if __name__ == "__main__":
    print(LABEL + ": " + pick())
