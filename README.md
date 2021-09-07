dotfiles
========

Configuration for various pieces of software plus some useful scripts. On Linux, I use i3 for a window manager and kitty as a terminal emulator, on Mac Aqua and iTerm2. Everywhere, I run tmux for multiplexing, bash as shell and vim as editor.

To use all the scripts and dotfiles in here, I'd recommend installing the following:

- ripgrep
- dzen2
- i3
- jq
- rofi
- kitty
- vim

Methodology
-----------

The rule I use when making configs is "Don't make more magic than there needs to be". My configuration is long, but it does not touch (most) defaults that you'll find on any stock \*nix machine.

Software
--------

- `common/`
  - git
  - tmux
- `ipython/`
- `irc/`
  - irssi
  - weechat
- `misc/`
  - abcde
  - gdb
  - input
  - ranger
- `shells/`
  - bash
- `x11/`
  - dunst
  - dwb
  - herbstluftwm
  - i3
  - i3bar
  - openbox

Scripts
-------

I've included a couple of scripts in this repository that are so useful to me that I want them on every box I configure. If you're using my dotfiles, they will be symlinked into `$HOME/bin`. My favorites:

- `common/bin/fileset.py`: compare the contents of two files as if each were a set. Super useful to find out if the lines you're about to add to a file are already in there without having to make an obscure `diff` invocation.
- `common/bin/backlight`: adjust the monitor brightness of your Linux laptop
- `common/bin/license`: retrieve one of a number of common open-source licenses
- `common/bin/gh-install`: install a binary from the latest release of a project on Github
- `x11/bin/block`: Blur-LOCK your Linux desktop

Setup
-----

To bootstrap these dotfiles (will clone the git repo or download a zip of the contents):

```
$ curl -O https://raw.githubusercontent.com/delucks/dotfiles/master/setup.sh
$ ./setup.sh
```

This script is being actively tested. Let me know if you run into any issues!

These dotfiles are organized expecting an installation of GNU Stow, which I have access to on all machines I usually provision these on.

You can install any one of the sets of configs that are in this repo with a command like this (run from the checkout directory, will symlink to the parent directory which is usually $HOME):

```
$ stow shells
$ stow vim
```

Stow won't clobber your files if they already exist. I have the configs separated out into sets because I use each for certain purposes, and mixing them together for the purpose of the machine I'm working on is handy.

You can install them manually by symlinking the dotfiles in this directory to their respective locations under `$HOME`. This is recommended if you want fine-grained control over where they go, or want to cherrypick certain configurations.

I used to have a Makefile and an Ansible based setup option, but I decided both were not very maintainable and required way too many dependencies. The best bikeshedding is done for fun.

X11
---

If you want to use my x11 configurations, first run `stow x11`. Once this is is done, symlink a colorscheme from `~/.config/colors/` to `~/.colors`.
