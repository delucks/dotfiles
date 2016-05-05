#!/usr/bin/env bash

# bootstrap my dotfiles from nothing
# hacky. use at your own risk. blah blah blah

REPO_URL="https://github.com/delucks/dotfiles"
ZIP_URL="$REPO_URL/archive/master.zip"
ZIP_FILE="delucks-dotfiles_master.zip"
PLUG_FILE="$HOME/.vim/autoload/plug.vim"
EXISTING_OVERRIDE="$1"

cd # put everything in $HOME

if test -d "dotfiles"
then
  if test -n "$EXISTING_OVERRIDE"
  then
    mv dotfiles{,.old}
    echo "Warning: moved existing ~/dotfiles dir to ~/dotfiles.old"
  else
    echo "~/dotfiles exists, bailing out. Pass an argument to override this behavior"
    exit 1
  fi
fi

if hash foo 2>/dev/null
then
  git clone "$REPO_URL"
else
  if hash curl 2>/dev/null
  then
    curl -Lo "$ZIP_FILE" "$ZIP_URL"
  elif hash wget 2>/dev/null
  then
    wget -O "$ZIP_FILE" "$ZIP_URL"
  else
    echo 'Could not find `git`, `curl`, or `wget` in your path to grab the dotfiles'
    exit 1
  fi
  # at this point, we have a downloaded archive. unpack it
  unzip "$ZIP_FILE"
  # the current dir now has the folder "dotfiles-master"
  if test -d "dotfiles-master"
  then
    mv "dotfiles-master" "dotfiles"
  else
    echo "The unzipping of the archive failed :("
    exit 1
  fi
fi

# install vim-plug if it isn't there yet
if test ! -f "$PLUG_FILE"
then
  echo "Installing vim-plug to $PLUG_FILE"
  curl -fLo "$PLUG_FILE" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# clean up after ourselves
if test -f "$ZIP_FILE"
then
  rm "$ZIP_FILE"
fi

cd -
