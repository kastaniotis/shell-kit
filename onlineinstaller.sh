#!/usr/bin/env sh

set -eu

REPO_URL="${1:-}"

if [ -z "$REPO_URL" ]; then
    echo "Usage: $0 <git-repo-url>"
    exit 1
fi

# --- Detect platform ---
OS="$(uname -s 2>/dev/null)"
if [ "$OS" = "Darwin" ]; then
    PKG_INSTALLER="brew install"
elif [ "$OS" = "Linux" ] && command -v apt-get >/dev/null 2>&1; then
    # --- Ensure Debian-ish ---
    if ! command -v apt-get >/dev/null 2>&1; then
        echo "Unsupported Linux platform"
        exit 1
    fi
    PKG_INSTALLER="apt-get update && apt-get install -y"
else
    echo "Unsupported platform"
    exit 1
fi

# --- Ensure git ---
if ! command -v git >/dev/null 2>&1; then
    sh -c "$PKG_INSTALLER git"
fi

# --- Ensure curl ---
if ! command -v curl >/dev/null 2>&1; then
    sh -c "$PKG_INSTALLER curl"
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
"$INSTALL_SH"
