#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

declare -A FILES=(
    ["bash/.bashrc"]="$HOME/.bashrc"
    ["git/.gitconfig"]="$HOME/.gitconfig"
    ["vim/.vimrc"]="$HOME/.vimrc"
    [".config/nvim"]="$HOME/.config/nvim"
    [".config/ghostty"]="$HOME/.config/ghostty"
)


for file in "${!FILES[@]}"; do
    SOURCE="$DOTFILES_DIR/$file"
    TARGET="${FILES[$file]}"

    echo "Creating symlink: $TARGET → $SOURCE"
    ln -s "$SOURCE" "$TARGET"
done

echo "Dotfiles setup complete!"
