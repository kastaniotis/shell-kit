#!/usr/bin/env sh

set -eu

REPO_URL="${1:-}"

if [ -z "$REPO_URL" ]; then
    echo "Usage: $0 <git-repo-url>"
    exit 1
fi

# --- Create temp dir ---
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

# --- Clone repo ---
git clone "$REPO_URL" "$TMPDIR/repo"

# --- Find install script ---
INSTALL_SH="$TMPDIR/repo/install.sh"

if [ ! -x "$INSTALL_SH" ]; then
    if [ -f "$INSTALL_SH" ]; then
        chmod +x "$INSTALL_SH"
    else
        echo "install.sh not found in repo"
        exit 1
    fi
fi

# --- Run it ---
cd "$TMPDIR/repo"
"$INSTALL_SH"
cd ~