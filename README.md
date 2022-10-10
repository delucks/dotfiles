dotfiles
========

Configuration for various pieces of software plus some useful scripts. On Linux, I use i3 for a window manager and kitty as a terminal emulator, on Mac Aqua and iTerm2. Everywhere, I run tmux for multiplexing, bash as shell and vim as editor.

Software recommendations/requirements:
- stow (only required for setup)
- jq
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- vim and emacs (gasp)
- pyenv (with python 3.8+)
- i3
- xterm
- [kitty](https://github.com/kovidgoyal/kitty)
- [rofi](https://github.com/davatorium/rofi)
- [dunst](https://github.com/dunst-project/dunst)
- dzen2 (for `x11/bin/dvol`)

Setup
-----

This repo uses [`chezmoi`](https://www.chezmoi.io/) to manage its installation. First, install chezmoi, then run `chezmoi init https://github.com/delucks/dotfiles.git`.

Next, create a file `~/.config/chezmoi/chezmoi.toml` with the following contents, editing as necessary:

```
[data]
	laptop = false
	wifi_interface = "wlp3s0"
	wired_interface = "enp4s0"
	cpu_thermal_path = "/sys/devices/virtual/thermal/thermal_zone1/temp"
	uses_wal = false
```

These variables will be interpolated into the templates in this repo to customize the current machine. After this file is created, run `chezmoi -v apply` to set up the configurations. If you're planning on using [`pywal`](https://github.com/dylanaraps/pywal) to manage colorschemes, set "uses_wal", install pywal, and generate a scheme based on your chosen background first.


X11
---

I use either i3 or herbstluftwm depending on the graphical capacity of the machine. The i3 session configured here is started and managed using systemd user units, including all the software that makes up the "desktop environment" of sorts. This includes a companion daemon for i3, `i3-buddy`, which implements detection of xrandr changes, a Quake terminal, and other features. The `i3-buddy` companion daemon requires the following python packages in user scope and a python version greater than 3.8 (I use 3.10).

```
i3ipc
dbussy
xcffib
systemd-python
```

If you're using the `temperatured` script to set OpenRGB color, you'll also need:

```
py3nvml
openrgb-python
```

You can install all these requirements with `python -m pip install --local i3ipc dbussy xcffib systemd-python py3nvml openrgb-python`.

Scripts
-------

Some useful scripts are included in this repository. If you're using my dotfiles, they will be symlinked into `$HOME/bin`. My favorites:

- `bin/fileset.py`: compare the contents of two files as if each were a set delinated by newlines.
- `bin/backlight`: adjust the monitor brightness of your Linux laptop
- `bin/license`: retrieve one of a number of common open-source licenses
- `bin/gh-install`: install a binary from the latest release of a project on Github
- `bin/block`: Blur-LOCK your Linux desktop
- `bin/rofi-man`: Open manual pages in a new terminal using rofi.
- `bin/rofi-tmux`: Open an existing tmux session in a new terminal using rofi.
