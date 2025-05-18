#!/usr/bin/env zsh

DIR="~/"

vared -p "Enter folder path to open in Neovim: " DIR

# Expand ~ to $HOME (zsh expands ~ automatically, but let's keep this explicit)
DIR="${DIR/#\~/$HOME}"

if [[ -d "$DIR" ]]; then
  cd "$DIR" || exit
  nvim
  exec zsh
else
  echo "Invalid directory: $DIR"
  exit 1
fi
