dotfiles
========

All of my configurations for various pieces of software on my machines.

This repository was created with the goal of automating new installations
and streamlining the process of setting up my usual suite of software.
To that end, I'm using the Ansible framework to install software sets that I find
useful for certain purposes. Feel free to browse the playbooks/ directory for more
information.

I hope the information in here can help kickstart others!

Setup
-----

You have two options to install these dotfiles, Ansible or bash. I personally prefer
Ansible (and you should too) because there is great tolerance for failures, and support
for cloning a ton of git repos that I didn't feel like setting up in my bash script.

### Ansible

First, you'll need to install Ansible. This can be done with a simple `{{ package manager }} install
ansible` usually, but if you can't find it in your repositories, the git repo is [here](https://github.com/ansible/ansible/). 

After installing it, clone my repository to ~/dotfiles (a convention).
`git clone https://github.com/delucks/dotfiles ~/dotfiles`

Then, cd to ~/dotfiles/playbooks and run `ansible-playbook general.yml`. For more
information on what it does, look at the file itself. It's pretty self-explanatory and well commented.

### Bash

Run ./setup.sh, with either -l for a headless install or -x for an xorg install.
For more information, see ./setup.sh -h. This script is being less actively maintained than the
Ansible setup version, so I'd heavily encourage you to use that. If for some reason you're opposed to
the python dependency for Ansible, you probably know how to set up my dotfiles by yourself anyway.
