#!/usr/bin/env bash
# Portable Python environment setup script using uv

set -euo pipefail

# -------- Helpers --------
log() { echo -e "\033[1;34m[INFO]\033[0m $*"; }
err() { echo -e "\033[1;31m[ERROR]\033[0m $*"; }

install_uv() {
    log "uv not found. Installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
}

get_python_version() {
    if [[ -f ".python-version" ]]; then
        cat .python-version
    else
        echo "3.14.3"
    fi
}

# -------- Main --------
log "Setting up Python environment..."

if ! command -v uv >/dev/null 2>&1; then
    install_uv
fi

PYTHON_VERSION=$(get_python_version)
log "Using Python $PYTHON_VERSION"

uv python install "$PYTHON_VERSION"
uv venv --python "$PYTHON_VERSION"

if [[ -f "requirements-dev.txt" ]]; then
    uv pip install -r requirements-dev.txt
elif [[ -f "requirements.txt" ]]; then
    uv pip install -r requirements.txt
else
    log "No requirements file found. Venv created only."
fi

log "Environment setup complete!"
echo
echo "To activate: source .venv/bin/activate"
echo "To deactivate: deactivate"
