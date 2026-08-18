dotfiles
========

Configuration for various pieces of software plus some useful scripts. On Linux, I use sway for a window manager and kitty as a terminal emulator, on Mac Aqua and iTerm2. Everywhere, I run tmux for multiplexing, bash as shell and vim as editor.

Software requirements:
- jq
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- pyenv
- sway
- [kitty](https://github.com/kovidgoyal/kitty)

Setup
-----

This repo uses [`chezmoi`](https://www.chezmoi.io/) to manage its installation. First, install chezmoi, then run `chezmoi init https://github.com/delucks/dotfiles.git`.

Next, edit the file `~/.config/chezmoi/chezmoi.toml` which should've been templated with contents similar the following:

```
[data]
	laptop = false
	wifi_interface = "wlp3s0"
	wired_interface = "enp4s0"
	cpu_thermal_path = "/sys/devices/virtual/thermal/thermal_zone1/temp"
	colors = "default"
```

These variables will be interpolated into the templates in this repo to customize the current machine. After this file is created, run `chezmoi -v apply` to set up the configurations. If you're planning on using [`pywal`](https://github.com/dylanaraps/pywal) to manage colorschemes, set `colors` to "wal", install pywal, and generate a scheme based on your chosen background first.
