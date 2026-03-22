# python-env

A lightweight, reproducible Python environment template powered by [uv](https://github.com/astral-sh/uv) — a fast Python package and project manager written in Rust.

## Requirements

- [uv](https://docs.astral.sh/uv/getting-started/installation/) — installed automatically by `setup.sh` if not present
- `curl` — required only for auto-installing uv
- `make` — optional, for Makefile targets


## Quick Start

```bash
# Bootstrap the full environment in one step
./setup.sh
```

This will:
1. Install `uv` if not already available
2. Read the Python version from `.python-version`
3. Create a `.venv` virtual environment
4. Install dependencies from `requirements-dev.txt` (preferred) or `requirements.txt`

Then activate the environment:

```bash
source .venv/bin/activate
# or using the global helper (see Global Shell Helpers below)
py-activate
```

## Python Version

The Python version is pinned in `.python-version`:

```
3.13.5
```

Change this file to switch versions. `uv` will automatically download and use the specified version.

## Managing Dependencies

### Install production dependencies

```bash
make install
# or
uv pip install -r requirements.txt
```

### Install development dependencies

```bash
make install-dev
# or
uv pip install -r requirements-dev.txt
```

### Add a new package

```bash
uv pip install <package>
```

Then pin it:

```bash
make freeze        # writes requirements.freeze.txt
# or manually add to requirements.txt
```

### Upgrade all dependencies

```bash
make update
# or
uv pip install --upgrade -r requirements.txt
```

### Check for dependency conflicts

```bash
make check
# or
uv pip check
```

## Makefile Targets

| Target          | Description                              |
|-----------------|------------------------------------------|
| `make install`  | Install production dependencies          |
| `make install-dev` | Install development dependencies     |
| `make update`   | Upgrade all production dependencies      |
| `make freeze`   | Freeze current env to `requirements.freeze.txt` |
| `make check`    | Check for dependency conflicts           |
| `make clean`    | Remove `__pycache__`, build artifacts, test caches |
| `make help`     | Show available targets                   |

## Global Shell Helpers

Add these to your `~/.zshrc` (or `~/.bashrc`) for convenient activation from any project:

```bash
py-activate() { source "$(pwd)/.venv/bin/activate"; }
py-deactivate() { deactivate; }
```

Then reload your shell:

```bash
source ~/.zshrc
```

Usage:

```bash
py-activate    # activates .venv in the current directory
py-deactivate  # deactivates the current venv
```

## Why uv?

- **Fast** — dependency resolution and installs are 10–100x faster than pip
- **No separate venv step** — `uv` manages virtual environments natively
- **Drop-in pip replacement** — `uv pip install` works like `pip install`
- **Automatic Python management** — downloads and pins Python versions without pyenv
