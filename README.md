# Ed's Dotfiles

This repo contains my configuration files (dotfiles) along with an installation script
to set up my development environment using symbolic links.

## Repository Structure

```
.
├── bash
  └── .bashrc
├── git
│ └── .gitconfig
├── vim
│ └── .vimrc
└── .config
  ├── nvim
  │ └── ... (Neovim config files)
  └── ghostty
    └── ... (Ghostty config files)
```

## Installation

### Prerequisites

- A Unix-like OS (preferably Debian based lol)
- Git
- Bash
- Neovim and Ghostty if you need 'em

Note: Running the install script will create symbolic links in your home directory. Make sure you
don't have conflicting files, or backup your current configurations before running the script.
