# Ed's Dotfiles

This repo contains my configuration files (dotfiles) along with an installation script
to set up my development environment using symbolic links.

## Repository Structure

```
.
├── zsh
  └── .zshrc
├── git
│ └── .gitconfig
├── vim
│ └── .vimrc
└── .config
  ├── nvim
  │ └── ... (Neovim config files)
  └── ghostty
    └── ... (Ghostty config files)
  └── yazi
    └── ... (Yazi config files)
```

## Installation

### Prerequisites or Stuff I Use

- At the moment my daily driver is Fedora
- Zsh
- Neovim
- Ghostty
- bear for C
- yazi for files
- Git and lazygit

Note: Running the install script will create symbolic links in your home directory. Make sure you
don't have conflicting files, or backup your current configurations before running the script. Idk
if this install script still works though lol.
