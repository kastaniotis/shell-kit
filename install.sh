#!/usr/bin/env sh
set -eu

PREFIX="$HOME/.local"
BIN_DIR="$PREFIX/bin"
LIB_DIR="$PREFIX/lib"

# Ensure ~/.local/bin exists
mkdir -p "$BIN_DIR"
mkdir -p "$LIB_DIR"

# Snippet to append
SNIPPET='export PATH="$HOME/.local/bin:$PATH"'

# Always add to .profile
append "$HOME/.profile" "$SNIPPET" "Added by shell-kit Installer"

# If macOS → also add to .zshrc
if [ "$(uname)" = "Darwin" ]; then
    append "$HOME/.zshrc"
fi

# Install executables
for f in ./src/*; do
    [ -f "$f" ] || continue
    echo "Installing $f → $BIN_DIR/"
    install -m 755 "$f" "$BIN_DIR/"
done

# Install libraries (source-only)
for f in ./lib/*; do
    [ -f "$f" ] || continue
    echo "Installing library $f → $LIB_DIR/"
    install -m 644 "$f" "$LIB_DIR/"
done

ui show:success "Shell-kit Installed. Please Restart your shell."
