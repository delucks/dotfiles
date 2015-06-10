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

![](http://i.imgur.com/e4AFBMI.gif)

You have two options to install these dotfiles, Ansible or a Makefile. I personally prefer
Ansible (and you should too) because there is great tolerance for failures, and support
for other operations than just cloning git repos.

### Ansible

First, you'll need to install Ansible. This can be done with a simple `{{ package manager }} install
ansible` usually, but if you can't find it in your repositories, the git repo is [here](https://github.com/ansible/ansible/). 

After installing it, clone my repository to ~/dotfiles (a convention).
`git clone https://github.com/delucks/dotfiles ~/dotfiles`

Then, cd to ~/dotfiles/playbooks and run `ansible-playbook bootstrap.yml`. For more
information on what it does, look at the file itself. It's pretty self-explanatory and well commented.

### make

A good option for most would be `make all`, which will attempt to symlink my dotfiles into the right locations.
To remove, run `make remove-all`. Most of the other options are for my use, but `make dev-install` (`make dev-remove` to uninstall)
may be of use to people looking to get off the ground with my shell, editor, and IRC configs.
Be warned that the default `make all` will clone a bunch of my git repos into different places around your $HOME. You'll probably want to read the Makefile before deciding which target you want.

Screenshots
-----------

##### zsh prompt

![](http://cluster.lug.udel.edu/~jluck/zsh.png)

##### tmux statusline

![](http://cluster.lug.udel.edu/~jluck/tmux.png)

##### weechat

![](http://cluster.lug.udel.edu/~jluck/weechat.png)

##### vim with some python

![](http://cluster.lug.udel.edu/~jluck/vim.png)
