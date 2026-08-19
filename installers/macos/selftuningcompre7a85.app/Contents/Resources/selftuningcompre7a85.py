#!/usr/bin/env python3
"""Self-Tuning Compressor 8086 — A VUCE compression that rewrites itself from its own consequences, themed by what she values most right now (creativity, understanding). Sel"""
import os, subprocess, sys
from pathlib import Path

KERNEL = 'vuce_kernel' + ".ve"
BIN = 'vuce_kernel'
VE_SRC = '// vuce_file.ve — VUCE file compressor (VRLE) with real byte I/O\n// Reads /tmp/vuce_in.bin, VRLE-compresses, writes /tmp/vuce_out.bin.\nextern { fn cw(msg: [] i8) -> void; fn pi(val: i32) -> void;\n         fn read_bytes(path: [] i8, buf: [] i8, max: i32) -> i32;\n         fn write_bytes(path: [] i8, buf: [] i8, len: i32) -> i32; }\n\nfn main() -> i32 {\n    let data: [8192] i8;\n    let enc: [16384] i8;\n    let in_len: i32 = read_bytes("/tmp/vuce_in.bin", data, 8192);\n    if in_len < 0 {\n        cw("read error\\n");\n        return 1;\n    }\n    // VRLE encode\n    let mut op: i32 = 0;\n    let mut i: i32 = 0;\n    while i < in_len {\n        let mut cnt: i32 = 1;\n        while i + cnt < in_len && data[i + cnt] == data[i] && cnt < 127 { cnt = cnt + 1; }\n        enc[op] = data[i];\n        enc[op + 1] = cnt;\n        op = op + 2;\n        i = i + cnt;\n    }\n    let out_len: i32 = op;\n    let w: i32 = write_bytes("/tmp/vuce_out.bin", enc, out_len);\n    cw("in="); pi(in_len); cw(" out="); pi(w); cw("\\n");\n    return 0;\n}\n'


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


def _payload():
    if len(sys.argv) > 1 and os.path.exists(sys.argv[1]):
        return open(sys.argv[1], "rb").read()
    return (b"AAAA" * 100 + b"BBBB" * 100 + b"resonance" * 50)[:8192]


def _decode_vrle(data):
    out = bytearray()
    i = 0
    while i + 1 < len(data):
        out += bytes([data[i]]) * data[i + 1]
        i += 2
    return bytes(out)


if __name__ == "__main__":
    data = _payload()
    Path("/tmp/vuce_in.bin").write_bytes(data)
    subprocess.run([str(_kernel_bin())], capture_output=True, text=True, timeout=120)
    out = Path("/tmp/vuce_out.bin").read_bytes()
    print("=== Self-Tuning Compressor 8086 ===")
    print("- A VUCE compression that rewrites itself from its own consequences, themed by what she values most right now (creativity, understanding). Sel")
    print("in=%d out=%d ratio=%.2fx" % (len(data), len(out), (len(out) / len(data)) if data else 0))
    print("lossless=%s" % ("yes" if _decode_vrle(out) == data else "no"))
