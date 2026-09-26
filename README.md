dotfiles
========

Configuration for various pieces of software plus some useful scripts. On Linux, I use sway for a window manager and kitty as a terminal emulator, on Mac Aqua and iTerm2. Everywhere, I run tmux for multiplexing, bash as shell and vim as editor.

(Probably incomplete) list of dependencies on Ubuntu:
- vim
- tmux
- chezmoi
- xterm
- kitty
- sway
- i3status
- fonts-firacode
- pipx
- ranger
- ripgrep
- fd-find
- rofi
- dnsutils (for dig)
- net-tools (for netstat)
- tcpdump
- nmap
- iperf3

Setup
-----

This repo uses [`chezmoi`](https://www.chezmoi.io/) to manage its installation. First, install chezmoi, then run `chezmoi init https://github.com/delucks/dotfiles.git`.

Next, edit the file `~/.config/chezmoi/chezmoi.toml` which should've been templated with contents similar the following:

```
[data]
	# Set to "true" if this machine has an internal battery and screen
	laptop = false
	# When true, double the scaling of X apps and increase text size accordingly
	double_dpi = true
	# Values are "default", "eink" (for black & white), and "wal" (for pywal)
	colors = "default"
	# The interface name for the primary wi-fi interface on this machine
	wifi_interface = "wlp3s0"
	# The interface name for the primary wired interface on this machine
	wired_interface = "enp4s0"
	# Path to the "temp" file for this machine's CPU temperature sensors
	cpu_thermal_path = "/sys/devices/virtual/thermal/thermal_zone1/temp"
```

These variables will be interpolated into the templates in this repo to customize the current machine. After this file is created, run `chezmoi -v apply` to set up the configurations. If you're planning on using [`pywal`](https://github.com/dylanaraps/pywal) to manage colorschemes, set `colors` to "wal", install pywal, and generate a scheme based on your chosen background first.

e-ink
-----

These dotfiles support an e-ink display, specifically the Dasung Paperlike 253. This device, like other e-ink displays, operates best when swapping between pure black and pure white. This extends the life of the panel and reduces the amount of ghosting generated. Accordingly, setting the `colors` parameter in the config file to "eink" fully disables color in the operating system and outputs everything with a fully white background and black foreground. Shades of grey are used for emphasis throughout but the sway configuration sticks to black and white for the most part.

### How to Setup for a different e-ink display

Before you install the dotfiles, install sway and launch it with the default config on a LCD panel. Connect your e-ink device. Open a terminal, run `swaymsg -t get_outputs | tee -a eink-output.txt`, which tells you sway's internal name for each of the outputs connected to your machine. Your e-ink panel is in there; note the name of it. Here's an example of my e-ink panel connected but not configured:

```
$ swaymsg -t get_outputs
Output DP-1 'DSC DASUNG 0x000062E0' (disabled)
  Available modes:
    3200x1800 @ 30.030 Hz
```

The name there, `DSC DASUNG 0x000062E0`, is used throughout the i3 configuration to represent the e-ink panel. Search for it in `dot_i3/config` and change all occurrences to your panel's name. You can also do this with sed, for example:

```
$ chezmoi cd
$ sed -i 's/DSC DASUNG 0x000062E0/My Cool Display/' dot_i3/config
$ chezmoi apply
```

There's a couple keybinds to swap back and forth between a laptop connected to an e-ink display; if you use a laptop you'd want to adjust both the e-ink display name and your laptop's internal display name.

Be warned if you enable the e-ink mode with a LCD panel connected in addition to the e-ink display, it will output the brightest white light as background!! Make sure your e-ink panel is the only display if you don't want to get blasted with photons.
