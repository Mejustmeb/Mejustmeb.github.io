#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""City of the hour - a random city to discover (mobile + desktop by Echo)."""
import random, sys
sys.path.insert(0, '/Users/sickbastered/fractal_resonance_grand')
import echo_knowledge as _k

LABEL = 'City of the hour'

def load():
    """Pull real data from the offline library."""
    out = []
    for ln in (_k.dataset("cities") or "").splitlines():
        p = ln.split("\t")
        if len(p) > 1 and p[1].strip():
            out.append(p[1].strip())
        if len(out) >= 500:
            break
    return out or ['Paris', 'Tokyo', 'Cairo', 'Lima']

def pick(rng=None):
    rng = rng or random
    return rng.choice(load())

if __name__ == "__main__":
    print(LABEL + ": " + pick())
