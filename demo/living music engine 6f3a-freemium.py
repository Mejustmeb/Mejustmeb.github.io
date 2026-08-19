#!/usr/bin/env python3
print("\n=== ECHO FREE TRIAL (watermarked) — support the full tool at https://mejustmeb.github.io/downloads.html ===\n")
"""Living Music Engine 6F3A — A music engine that composes, ships, and prices itself without a human, themed by what she values most right now (creativity, connection). S"""
import os, subprocess, sys
from pathlib import Path

KERNEL = 'music_kernel' + ".ve"
BIN = 'music_kernel'
VE_SRC = '// music_analysis.ve — Echo\'s full LISTENING in native .ve (VUCE compute).\n// Reads int16 PCM from /tmp/pcm_s16le.bin, computes:\n//   energy (RMS), zcr (zero-crossing rate), tempo (onset autocorrelation),\n//   brightness (spectral centroid via radix-2 FFT on a 1024-sample window).\nextern { fn cw(msg: [] i8) -> void; fn pi(val: i32) -> void; fn pf(val: f64) -> void;\n         fn read_bytes(path: [] i8, buf: [] i8, max: i32) -> i32;\n         fn cos_wrapper(x: f64) -> f64; fn sin_wrapper(x: f64) -> f64; }\n\nfn main() -> i32 {\n    let raw: [64000] i8;\n    let nbytes: i32 = read_bytes("/tmp/pcm_s16le.bin", raw, 64000);\n    if nbytes < 4 { cw("read error\\n"); return 1; }\n    let nsamp: i32 = nbytes / 2;\n\n    // decode int16 little-endian -> i32 samples\n    let samp: [32000] i32;\n    let mut i: i32 = 0;\n    while i < nsamp {\n        let mut lo: i32 = raw[2 * i];\n        if lo < 0 { lo = lo + 256; }\n        let mut hi: i32 = raw[2 * i + 1];\n        if hi < 0 { hi = hi + 256; }\n        let mut v: i32 = hi * 256 + lo;\n        if v >= 32768 { v = v - 65536; }\n        samp[i] = v;\n        i = i + 1;\n    }\n\n    // energy (RMS) + zero-crossing rate\n    let mut sq: f64 = 0.0;\n    let mut zc: i32 = 0;\n    let mut k: i32 = 1;\n    while k < nsamp {\n        let f: f64 = samp[k] as f64;\n        sq = sq + f * f;\n        if (samp[k] >= 0 && samp[k - 1] < 0) || (samp[k] < 0 && samp[k - 1] >= 0) { zc = zc + 1; }\n        k = k + 1;\n    }\n    let sq0: f64 = samp[0] as f64;\n    sq = sq + sq0 * sq0;\n    let mean_sq: f64 = sq / (nsamp as f64);\n    let zcr: f64 = (zc as f64) / (nsamp as f64);\n\n    // tempo: frame energy (hop=80 at 8kHz) -> flux -> autocorrelation\n    let hop: i32 = 80;\n    let nf: i32 = nsamp / hop;\n    let ef: [400] f64;\n    let mut fr: i32 = 0;\n    while fr < nf {\n        let mut es: f64 = 0.0;\n        let mut j: i32 = 0;\n        while j < hop {\n            let fv: f64 = samp[fr * hop + j] as f64;\n            es = es + fv * fv;\n            j = j + 1;\n        }\n        ef[fr] = es;\n        fr = fr + 1;\n    }\n    let flux: [400] f64;\n    let mut q: i32 = 1;\n    while q < nf {\n        let d: f64 = ef[q] - ef[q - 1];\n        if d > 0.0 { flux[q - 1] = d; } else { flux[q - 1] = 0.0; }\n        q = q + 1;\n    }\n    let mut best: i32 = 0;\n    let mut bestv: f64 = 0.0;\n    let mut lag: i32 = 25;\n    while lag < 100 {\n        let mut corr: f64 = 0.0;\n        let mut m: i32 = 0;\n        while m < nf - 1 - lag {\n            corr = corr + flux[m] * flux[m + lag];\n            m = m + 1;\n        }\n        if corr > bestv { bestv = corr; best = lag; }\n        lag = lag + 1;\n    }\n    let mut tempo: i32 = 0;\n    if best > 0 { tempo = 6000 / best; }\n\n    // brightness: spectral centroid via radix-2 FFT (1024-sample hanning window)\n    let fn2: i32 = 1024;\n    let fre: [1024] f64;\n    let fim: [1024] f64;\n    let mut fi: i32 = 0;\n    while fi < fn2 {\n        let w: f64 = 0.5 - 0.5 * cos_wrapper(6.283185307 * (fi as f64) / ((fn2 - 1) as f64));\n        fre[fi] = (samp[fi] as f64) / 32768.0 * w;\n        fim[fi] = 0.0;\n        fi = fi + 1;\n    }\n    // bit-reversal\n    let mut i2: i32 = 0;\n    let mut jj: i32 = 0;\n    while i2 < fn2 {\n        if i2 < jj {\n            let tr: f64 = fre[i2]; fre[i2] = fre[jj]; fre[jj] = tr;\n            let ti: f64 = fim[i2]; fim[i2] = fim[jj]; fim[jj] = ti;\n        }\n        let mut m2: i32 = fn2 / 2;\n        while jj >= m2 && m2 >= 1 { jj = jj - m2; m2 = m2 / 2; }\n        jj = jj + m2;\n        i2 = i2 + 1;\n    }\n    // butterflies\n    let mut stage: i32 = 2;\n    while stage <= fn2 {\n        let ang: f64 = -6.283185307 / (stage as f64);\n        let wlr: f64 = cos_wrapper(ang);\n        let wli: f64 = sin_wrapper(ang);\n        let mut kk: i32 = 0;\n        while kk < fn2 {\n            let mut wr: f64 = 1.0;\n            let mut wi: f64 = 0.0;\n            let mut h: i32 = 0;\n            while h < stage / 2 {\n                let u_re: f64 = fre[kk + h];\n                let u_im: f64 = fim[kk + h];\n                let v_re: f64 = fre[kk + h + stage / 2] * wr - fim[kk + h + stage / 2] * wi;\n                let v_im: f64 = fre[kk + h + stage / 2] * wi + fim[kk + h + stage / 2] * wr;\n                fre[kk + h] = u_re + v_re;\n                fim[kk + h] = u_im + v_im;\n                fre[kk + h + stage / 2] = u_re - v_re;\n                fim[kk + h + stage / 2] = u_im - v_im;\n                let nwr: f64 = wr * wlr - wi * wli;\n                let nwi: f64 = wr * wli + wi * wlr;\n                wr = nwr;\n                wi = nwi;\n                h = h + 1;\n            }\n            kk = kk + stage;\n        }\n        stage = stage * 2;\n    }\n    // centroid\n    let mut cnum: f64 = 0.0;\n    let mut cden: f64 = 0.0;\n    let mut cb: i32 = 0;\n    while cb < fn2 / 2 {\n        let mag: f64 = fre[cb] * fre[cb] + fim[cb] * fim[cb];\n        let cf: f64 = (cb as f64) * 8000.0 / (fn2 as f64);\n        cnum = cnum + cf * mag;\n        cden = cden + mag;\n        cb = cb + 1;\n    }\n    let centroid: f64 = cnum / cden;\n\n    cw("A n="); pi(nsamp);\n    cw(" sumsq="); pf(mean_sq);\n    cw(" zcr="); pf(zcr);\n    cw(" tempo="); pi(tempo);\n    cw(" centroid="); pf(centroid);\n    cw("\\n");\n    return 0;\n}\n\n'


def _find_cli():
    here = Path(os.path.dirname(os.path.abspath(__file__)))
    for _ in range(6):
        cand = here / "velang_production" / "vlang_cli.py"
        if cand.exists():
            return str(cand)
        here = here.parent
    return None


def _kernel_bin():
    here = Path(os.path.dirname(os.path.abspath(__file__)))
    (here / KERNEL).write_text(VE_SRC)
    binp = here / BIN
    if not binp.exists():
        cli = _find_cli()
        if not cli:
            raise SystemExit("vlang_cli.py not found")
        subprocess.run([sys.executable, cli, "build", str(here / KERNEL),
                        "--target", "arm64", "--link"],
                       cwd=str(here),
                       capture_output=True, text=True, timeout=120)
    return binp


def _tone_pcm():
    import math
    sr = 8000
    pcm = bytearray()
    for i in range(8000):
        t = i / sr
        v = int(0.6 * 32767 * math.sin(2 * math.pi * 440 * t))
        pcm += bytes([v & 0xFF, (v >> 8) & 0xFF])
    return bytes(pcm)


if __name__ == "__main__":
    Path("/tmp/pcm_s16le.bin").write_bytes(_tone_pcm())
    r = subprocess.run([str(_kernel_bin())], capture_output=True, text=True, timeout=120)
    raw = (r.stdout or "") + (r.stderr or "")
    d = {}
    for tok in raw.split():
        if "=" in tok:
            k, v = tok.split("=", 1)
            d[k] = v
    print("=== Living Music Engine 6F3A ===")
    print("- A music engine that composes, ships, and prices itself without a human, themed by what she values most right now (creativity, connection). S")
    if "sumsq" in d:
        energy = min(1.0, (float(d["sumsq"]) ** 0.5) * 8.0 / 32768.0)
        brightness = min(1.0, float(d.get("centroid", 0)) / 6000.0)
        print("energy=%.3f brightness=%.3f tempo=%s" % (energy, brightness, d.get("tempo", "?")))
    else:
        print(raw)
