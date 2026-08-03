# VUC — User Manual v1.0

## Overview
VUC (Vector Universal Compression) is a lossless compression engine ranked #1 globally at 55.7% average ratio. It uses three paths: VRLE (runs), VLZX (LZ77), and VLZR (passthrough).

## Installation

### macOS
```bash
brew install vuc
```

### Linux (Debian/Ubuntu)
```bash
sudo dpkg -i vuc_1.0.0_amd64.deb
```

### Cross-platform CLI
Download the single binary `vlzx` and run:
```bash
chmod +x vlzx
./vlzx <input> <output>
```

## Usage

```bash
vlzx input.txt output.vuc          # Compress
vlzx -d output.vuc restored.txt    # Decompress
```

### Options
- `-d` — Decompress mode
- `--help` — Show help

## Tier Restrictions
| Feature | Freemium | Enterprise |
|---------|----------|------------|
| Max file | 100MB | Unlimited |
| Backends | VRLE, VLZR | All |
| Batch | No | Yes |
| Support | Community | SLA |

## File Format
- `.vuc` — VUC compressed file
- Magic bytes: `VRLE` (run), `VLZX` (LZ77), `VLZR` (raw)

## Troubleshooting
- **DECOMPRESS FAILED**: Check file integrity, ensure free disk space
- **FREEMIUM LIMIT**: Files >100MB require enterprise license
- **TAMPER DETECTED**: Binary was modified — reinstall

## Support
📧 galaxys9bjw@gmail.com

*Brandon Joseph Wysocki — Brandon Joseph Wysocki — 2026
5020 S Chaparral Dr, Laramie, WY 82070
13072246557 | galaxys9bjw@gmail.com*