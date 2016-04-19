dotfiles
========

All of my configurations for various pieces of software.

This repository was created with the goal of automating new installations and streamlining the process of setting up my usual suite of software.

I choose aliases by the rule "don't make more magic than there needs to be". My configuration is long, but it does not touch (most) defaults that you'll find on any stock \*nix machine.

Setup
-----

These dotfiles are organized expecting an installation of GNU Stow, which I have access to on all machines I usually provision these on. I am intending on writing a shell script to install the basic ones and bootstrap this whole repo, that is currently TODO.

You can install any one of the sets of configs that are in this repo with a command like this (run from the checkout directory, will symlink to the parent directory which is usually $HOME):

```
$ stow shells
$ stow vim
```

Stow won't clobber your files if they already exist. I have the configs separated out into sets because I use each for certain purposes, and mixing them together for the purpose of the machine I'm working on is handy.

You can install them manually by symlinking the dotfiles in this directory to their respective locations under `$HOME`. This is recommended if you want fine-grained control over where they go, or want to cherrypick certain configurations.

I used to have a Makefile and an Ansible based setup option, but I decided both were not very maintainable and required way too many dependencies. The best bikeshedding is done for fun.
