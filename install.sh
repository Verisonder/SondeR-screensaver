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
  if command -v dnf &>/dev/null;    then sudo dnf install -y alacritty
  elif command -v apt &>/dev/null;  then sudo apt install -y alacritty
  elif command -v pacman &>/dev/null; then sudo pacman -S --noconfirm alacritty
  else echo "  [!] Install alacritty manually: https://alacritty.org"; exit 1
  fi
else
  echo "  ✓ alacritty"
fi

if ! command -v xdotool &>/dev/null; then
  if command -v dnf &>/dev/null;    then sudo dnf install -y xdotool
  elif command -v apt &>/dev/null;  then sudo apt install -y xdotool
  elif command -v pacman &>/dev/null; then sudo pacman -S --noconfirm xdotool
  else echo "  [!] Install xdotool manually."; exit 1
  fi
else
  echo "  ✓ xdotool"
fi

if ! command -v tte &>/dev/null; then
  if command -v pip3 &>/dev/null;   then pip3 install --user terminaltexteffects
  elif command -v pip &>/dev/null;  then pip install --user terminaltexteffects
  else
    echo "  [!] pip not found. Install it first:"
    echo "      Fedora:  sudo dnf install python3-pip"
    echo "      Debian:  sudo apt install python3-pip"
    echo "      Arch:    sudo pacman -S python-pip"
    exit 1
  fi
else
  echo "  ✓ tte"
fi

echo "[2/4] Installing files..."
mkdir -p "$INSTALL_DIR" "$HOME/.local/bin"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$REPO_DIR/sonder-screensaver.sh" "$INSTALL_DIR/"
cp "$REPO_DIR/Yourtext.txt"          "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/sonder-screensaver.sh"
echo "  ✓ Files installed"

echo "[3/4] Creating launcher..."
ln -sf "$INSTALL_DIR/sonder-screensaver.sh" "$BIN_LINK"
echo "  ✓ Launcher created"

echo "[4/4] Checking PATH..."
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo ""
  echo "  [!] Add this to your ~/.bashrc or ~/.zshrc:"
  echo "        export PATH=\"\$HOME/.local/bin:\$PATH\""
  echo "      Then run: source ~/.bashrc"
else
  echo "  ✓ PATH OK"
fi

echo ""
echo "  ✓ Done! Run with: sonder-screensaver"
echo "  Customize:        nano $INSTALL_DIR/Yourtext.txt"
echo ""
