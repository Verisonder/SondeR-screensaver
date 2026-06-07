#!/bin/bash
# SondeR Screensaver — by VerisondeR
# Edit Yourtext.txt to change the displayed ASCII art.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEXT_FILE="$SCRIPT_DIR/Yourtext.txt"

WINIT_UNIX_BACKEND=x11 alacritty \
  -o "window.startup_mode='Fullscreen'" \
  -o "colors.primary.background='#000000'" \
  -e bash -c "
  TEXTFILE='$TEXT_FILE'
  tput civis
  stty -echo
  sleep 0.8
  cleanup() { tput cnorm; stty echo; exit 0; }
  trap cleanup EXIT
  while true; do
    xdotool mousemove 0 0 2>/dev/null
    C=\$(tput cols)
    L=\$(tput lines)
    tte --input-file \"\$TEXTFILE\" \
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
