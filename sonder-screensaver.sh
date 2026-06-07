#!/bin/bash
# SondeR Screensaver — by VerisondeR
# All files live in ~/.local/share/sonder-screensaver/

INSTALL_DIR="$HOME/.local/share/sonder-screensaver"
TEXT_FILE="$INSTALL_DIR/Yourtext.txt"
TTE_BIN="$(which tte 2>/dev/null || echo "$HOME/.local/bin/tte")"

if [[ ! -f "$TEXT_FILE" ]]; then
  echo "Error: $TEXT_FILE not found. Run install.sh first."
  exit 1
fi

if [[ ! -x "$TTE_BIN" ]]; then
  echo "Error: tte not found. Run install.sh first."
  exit 1
fi

# Hide cursor (Hyprland native)
hyprctl keyword cursor:invisible true 2>/dev/null

# Hide cursor (X11 fallback)
unclutter -idle 0 -root & UNCLUTTER_PID=$!

WINIT_UNIX_BACKEND=x11 alacritty \
  -o "window.startup_mode='Fullscreen'" \
  -o "colors.primary.background='#000000'" \
  -e bash -c "
  TEXT_FILE='$TEXT_FILE'
  TTE_BIN='$TTE_BIN'
  tput civis
  stty -echo
  sleep 0.8
  cleanup() { tput cnorm; stty echo; exit 0; }
  trap cleanup EXIT
  while true; do
    C=\$(tput cols)
    L=\$(tput lines)
    \"\$TTE_BIN\" --input-file \"\$TEXT_FILE\" \
        --canvas-width \$C \
        --canvas-height \$L \
        --anchor-canvas c \
        --anchor-text c \
        --random-effect &
    TTE_PID=\$!
    while kill -0 \$TTE_PID 2>/dev/null; do
      if read -s -n 1 -t 0.1; then
        kill \$TTE_PID
        cleanup
      fi
    done
  done
"

# Restore cursor on exit
hyprctl keyword cursor:invisible false 2>/dev/null
kill $UNCLUTTER_PID 2>/dev/null
