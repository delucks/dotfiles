dotfiles
========

All of my configurations for various pieces of software.

This repository was created with the goal of automating new installations and streamlining the process of setting up my usual suite of software.

I choose aliases by the rule "don't make more magic than there needs to be". My configuration is long, but it does not touch (most) defaults that you'll find on any stock \*nix machine.

Setup
-----

![](http://i.imgur.com/e4AFBMI.gif)

You have two options to install these dotfiles, Ansible or `make`.

You can install them manually by symlinking the dotfiles in this directory to their respective locations under `$HOME`. This is recommended if you want fine-grained control over where they go, or want to cherrypick certain configurations.

### make

A good option for most would be `make all`, which will attempt to symlink my dotfiles into the right locations.
To remove, run `make remove-all`. Most of the other options are for my use, but `make dev-install` (`make dev-remove` to uninstall)
may be of use to people looking to get off the ground with my shell, editor, and IRC configs.
Be warned that the default `make all` will clone a bunch of my git repos into different places around your $HOME. You'll probably want to read the Makefile before deciding which target you want.

### Ansible

First, you'll need to install Ansible. This can be done with a simple `{{ package manager }} install
ansible` usually, but if you can't find it in your repositories, the git repo is [here](https://github.com/ansible/ansible/). 

After installing it, clone my repository to ~/dotfiles (a convention).
`git clone https://github.com/delucks/dotfiles ~/dotfiles`

Then, cd to ~/dotfiles/playbooks and run `ansible-playbook bootstrap.yml`. For more
information on what it does, look at the file itself. It's pretty self-explanatory and well commented.
evaluate tmux control mode
