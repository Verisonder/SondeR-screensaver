#!/bin/bash
set -e
INSTALL_DIR="$HOME/.local/share/sonder-screensaver"
BIN_LINK="$HOME/.local/bin/sonder-screensaver"

echo ""
echo "  SondeR Screensaver — Installer"
echo "  ================================"
echo ""
echo "[1/5] Checking dependencies..."

if ! command -v unclutter &>/dev/null; then
  if command -v dnf &>/dev/null;     then sudo dnf install -y unclutter
  elif command -v apt &>/dev/null;   then sudo apt install -y unclutter
  elif command -v pacman &>/dev/null; then sudo pacman -S --noconfirm unclutter
  fi
else
  echo "  ✓ unclutter"
fi

if ! command -v alacritty &>/dev/null; then
  if command -v dnf &>/dev/null;     then sudo dnf install -y alacritty
  elif command -v apt &>/dev/null;   then sudo apt install -y alacritty
  elif command -v pacman &>/dev/null; then sudo pacman -Sy --noconfirm alacritty
  else echo "  [!] Install alacritty manually: https://alacritty.org"; exit 1
  fi
else
  echo "  ✓ alacritty"
fi

if ! command -v xdotool &>/dev/null; then
  if command -v dnf &>/dev/null;     then sudo dnf install -y xdotool
  elif command -v apt &>/dev/null;   then sudo apt install -y xdotool
  elif command -v pacman &>/dev/null; then sudo pacman -S --noconfirm xdotool
  else echo "  [!] Install xdotool manually."; exit 1
  fi
else
  echo "  ✓ xdotool"
fi

if ! command -v pip3 &>/dev/null && ! command -v pip &>/dev/null; then
  echo "  → Installing pip3..."
  if command -v dnf &>/dev/null;     then sudo dnf install -y python3-pip
  elif command -v apt &>/dev/null;   then sudo apt install -y python3-pip
  elif command -v pacman &>/dev/null; then sudo pacman -S --noconfirm python-pip
  else echo "  [!] Install pip manually."; exit 1
  fi
fi

if ! command -v tte &>/dev/null; then
  echo "  → Installing tte..."
  PIP_OPTS="--user terminaltexteffects --break-system-packages"
  if command -v pip3 &>/dev/null; then
    pip3 install $PIP_OPTS
  else
    pip install $PIP_OPTS
  fi
else
  echo "  ✓ tte"
fi

echo "[2/5] Installing files..."
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ ! -f "$REPO_DIR/sonder-screensaver.sh" ] || [ ! -f "$REPO_DIR/Yourtext.txt" ]; then
  echo "  [!] Missing source components in execution directory."
  exit 1
fi

mkdir -p "$INSTALL_DIR" "$HOME/.local/bin"
cp "$REPO_DIR/sonder-screensaver.sh" "$INSTALL_DIR/"
cp "$REPO_DIR/Yourtext.txt"          "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/sonder-screensaver.sh"
echo "  ✓ Files installed"

echo "[3/5] Creating launcher..."
ln -sf "$INSTALL_DIR/sonder-screensaver.sh" "$BIN_LINK"
echo "  ✓ Launcher created"

echo "[4/5] Adding ~/.local/bin to PATH..."
SHELL_RC="$HOME/.bashrc"
if [[ "$SHELL" == *zsh* ]]; then SHELL_RC="$HOME/.zshrc"; fi
if ! grep -q 'local/bin' "$SHELL_RC" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
  echo "  ✓ Added to $SHELL_RC"
else
  echo "  ✓ PATH already set"
fi
export PATH="$HOME/.local/bin:$PATH"

echo "[5/5] Done!"
echo ""
echo "  ✓ Run with: sonder-screensaver"
echo "  Customize:  nano $INSTALL_DIR/Yourtext.txt"
echo ""
echo "  NOTE: Open a new terminal or run: source ~/.bashrc"
echo ""
