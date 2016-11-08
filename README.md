dotfiles
========

All of my configurations for various pieces of software.

Methodology
-----------

The rule I use when making configs is "Don't make more magic than there needs to be". My configuration is long, but it does not touch (most) defaults that you'll find on any stock \*nix machine.

Software
--------

- `common/`
  - ack
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
  - metasploit
  - ncmpcpp
  - ranger
- `shells/`
  - bash
  - zsh
- `x11/`
  - compton
  - dunst
  - dwb
  - herbstluftwm
  - i3
  - i3blocks
  - openbox
  - qtile
  - redshift
  - xinit
  - xmobar
  - Associated scripts (more on this below)

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

I have spent *far* too long configuring x11.

If you're intending on installing the x11 set of configurations, run `./configure-x11.sh` first. There are a number of color definitions and user-specific paths that need to get templated before you `stow x11`.

The configurations for most of the window managers are simple, vim-keybound ones with sane defaults for terminals and menus. There is one exception to this- I have written a number of scripts (all in the `x11/bin` directory) that make my computing life with Linux much nicer. A lot of them revolve around the excellent `dvol` program from the suckless community, which is most likely in your package manager.
