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

A bootstrap script is provided, which will clone this repo or unpack a zip of its contents. Otherwise just `git clone` the thing.

```
$ curl -O https://raw.githubusercontent.com/delucks/dotfiles/master/setup.sh
$ ./setup.sh
```

These dotfiles are organized into GNU Stow "packages" which correspond with different categories of items to install- this allows you to use shell configs without X11, for example. Stow overlays each package onto _$HOME_ or the parent directory using symlinks. Stow won't clobber your dotfiles if they already exist. You'll need to install `stow` from your local package manager.

Using `stow`, you can install any of the packages with a command like this (run from the checkout directory):

```
$ stow shells
$ stow x11
```

You can install them manually by symlinking the dotfiles in this directory to their respective locations under _$HOME_ (e.g. `ln -s ~/dotfiles/x11/.i3/ ~/.i3`). This is recommended if you want fine-grained control over where they go, or want to cherrypick certain configurations.

X11
---

I use either i3 or Openbox depending on the graphical capacity of the machine. The i3 session configured here is started and managed using systemd user units, including all the software that makes up the "desktop environment" of sorts. This includes a companion daemon for i3, `i3-buddy`, which implements detection of xrandr changes, a Quake terminal, and other features. The `i3-buddy` companion daemon requires the following python packages in user scope and a python version greater than 3.8.

```
i3ipc
dbussy
xcffib
systemd-python
```

Scripts
-------

Some useful scripts are included in this repository. If you're using my dotfiles, they will be symlinked into `$HOME/bin`. My favorites:

- `common/bin/fileset.py`: compare the contents of two files as if each were a set delinated by newlines.
- `common/bin/backlight`: adjust the monitor brightness of your Linux laptop
- `common/bin/license`: retrieve one of a number of common open-source licenses
- `common/bin/gh-install`: install a binary from the latest release of a project on Github
- `x11/bin/block`: Blur-LOCK your Linux desktop
- `x11/bin/rofi-man`: Open manual pages in a new terminal using rofi.
- `x11/bin/rofi-tmux`: Open an existing tmux session in a new terminal using rofi.
