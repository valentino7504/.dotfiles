#!/bin/bash

read -e -p "Enter folder path to open in Neovim: " DIR

# Expand ~ to $HOME
DIR="${DIR/#\~/$HOME}"

if [ -d "$DIR" ]; then
    cd "$DIR" && nvim
    exec bash
else
    echo "Invalid directory: $DIR"
    exit 1
fi
