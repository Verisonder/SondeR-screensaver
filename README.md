# SondeR Screensaver

A fullscreen terminal screensaver with animated ASCII art — built on [terminal-text-effects (tte)](https://github.com/ChrisBuilds/terminaltexteffects) and Alacritty.

**By [VerisondeR](https://github.com/Verisonder)**

---

## Preview
   ▄████████  ▄██████▄  ███▄▄▄▄   ████████▄     ▄████████  ████████▄
  ███    ███ ███    ███ ███▀▀▀██▄ ███   ▀███   ███    ███  ███    ███
  ███    █▀  ███    ███ ███   ███ ███    ███   ███    █▀   ███    ███
  ███        ███    ███ ███   ███ ███    ███  ▄███▄▄▄      ▀██▄▄▄▄███▄
▀███████████ ███    ███ ███   ███ ███    ███ ▀▀███▀▀▀       ▀▀▀▀▀███▀▀
         ███ ███    ███ ███   ███ ███    ███   ███    █▄  ███████████▀
   ▄█    ███ ███    ███ ███   ███ ███   ▄███   ███    ███ ███    ███
 ▄████████▀   ▀██████▀   ▀█   █▀  ████████▀    ██████████ ███    ███
                                                          ███    ███

The animation effect is chosen randomly each run. Press **any key** to exit.

---

## Requirements

| Requirement | Purpose | Auto-installed? |
|---|---|---|
| Linux (Fedora / Debian / Ubuntu / Arch) | OS | — |
| X11 or XWayland | Display backend | — |
| `git` | Clone the repo | Usually pre-installed |
| `python3` + `pip3` | Install tte | Usually pre-installed |
| `alacritty` | Terminal window | ✓ Yes |
| `xdotool` | Hide mouse cursor | ✓ Yes |
| `tte` (terminal-text-effects) | Animation engine | ✓ Yes |

> **Wayland users:** XWayland must be enabled. Pure Wayland without XWayland is not supported.

---

## Install

```bash
git clone https://github.com/Verisonder/SondeR-screensaver.git
cd SondeR-screensaver
chmod +x install.sh
./install.sh
```

The installer detects your distro and installs all missing dependencies automatically.

---

## Run

```bash
sonder-screensaver
```

Press **any key** to exit.

---

## Customize — Edit Your Text

Your ASCII art lives in one file:~/.local/share/sonder-screensaver/Yourtext.txt
Open it with any text editor:

```bash
# nano
nano ~/.local/share/sonder-screensaver/Yourtext.txt

# or kate (KDE)
kate ~/.local/share/sonder-screensaver/Yourtext.txt

# or gedit
gedit ~/.local/share/sonder-screensaver/Yourtext.txt
```

Replace the contents with any ASCII art you want. Save, then run `sonder-screensaver` — your new art animates immediately.

**Tips for best results:**
- Keep lines under **80 characters** for compatibility with smaller terminals
- Generate ASCII art at [patorjk.com/software/taag](https://patorjk.com/software/taag/)
- Block characters like `▄ █ ▀` work especially well with the animation effects
- Wider art looks better on large monitors; keep it simple for small screens

---

## Uninstall

```bash
rm -rf ~/.local/share/sonder-screensaver
rm ~/.local/bin/sonder-screensaver
```

---

## License

MIT — do whatever you want with it.
