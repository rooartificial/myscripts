#!/bin/bash
if which git >/dev/null; then
  ln -s "$(pwd)/nvim" "$HOME/.config"
  echo "Symbolic link created to ~/.config/nvim"
  curl -fLo "$(pwd)/nvim/autoload/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "Vim-Plug installed succesfully"
  git config --global core.editor "nvim"
else
    echo "Git isn't installed on this system."
fi
