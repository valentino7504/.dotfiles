#!/bin/bash

echo "--dir=$HOME/.dotfiles" > ~/.stowrc
echo "--target=$HOME" >> ~/.stowrc
echo "--verbose" >> ~/.stowrc
echo "--restow" >> ~/.stowrc
cd ~/.dotfiles && stow */
