#!/bin/bash
set -e
INSTALL_DIR="$HOME/.local/share/sonder-screensaver"
BIN_LINK="$HOME/.local/bin/sonder-screensaver"
echo ""
echo "  SondeR Screensaver — Installer"
echo "  ================================"
echo ""
echo "[1/4] Checking dependencies..."
if ! command -v alacritty &>/dev/null; then
  command -v dnf    &>/dev/null && sudo dnf install -y alacritty
  command -v apt    &>/dev/null && sudo apt install -y alacritty
  command -v pacman &>/dev/null && sudo pacman -S --noconfirm alacritty
else; echo "  ✓ alacritty"; fi
if ! command -v xdotool &>/dev/null; then
  command -v dnf    &>/dev/null && sudo dnf install -y xdotool
  command -v apt    &>/dev/null && sudo apt install -y xdotool
  command -v pacman &>/dev/null && sudo pacman -S --noconfirm xdotool
else; echo "  ✓ xdotool"; fi
if ! command -v tte &>/dev/null; then
  pip3 install --user terminaltexteffects
else; echo "  ✓ tte"; fi
echo "[2/4] Installing files..."
mkdir -p "$INSTALL_DIR" "$HOME/.local/bin"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$REPO_DIR/sonder-screensaver.sh" "$INSTALL_DIR/"
cp "$REPO_DIR/Yourtext.txt"          "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/sonder-screensaver.sh"
echo "[3/4] Creating launcher..."
ln -sf "$INSTALL_DIR/sonder-screensaver.sh" "$BIN_LINK"
echo "[4/4] Done!"
echo ""
echo "  Run with:   sonder-screensaver"
echo "  Customize:  nano $INSTALL_DIR/Yourtext.txt"
echo ""
