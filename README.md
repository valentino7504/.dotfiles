# Ed's Dotfiles

This repo contains my configuration files (dotfiles) managed with GNU Stow.
Each application's configuration is isolated into its own directory.
The repo also contains the names of my currently installed packages and things I use.

## Repository Structure

The repo is organized by application and each folder mimics the structure of the $HOME directory.

```
.
├── asciinema                     # Links to ~/.config/asciinema
├── ghostty                       # Links to ~/.config/ghostty
├── git                           # Links to ~/.gitconfig
├── ideavim                       # Links to ~/.ideavimrc
├── lazygit                       # Links to ~/.config/lazygit
├── nvim                          # Links to ~/.config/nvim
├── template_files                # Links to ~/.config/template-files
├── vim                           # Links to ~/.vimrc
├── yazi                          # Links to ~/.config/yazi
├── zsh                           # Links to ~/.zshrc
├── .stow-local-ignore
├── install.sh
├── installed-packages.txt
└── README.md
```

---

## Installation

### 1. Prerequisites

This setup requires **GNU Stow**. If you are on Fedora, install it via:

```zsh
sudo dnf install stow
```

### 2. Deploying Configurations

Clone this repo and run the appropriate `stow` command.

##### Deploy all packages:

I have created a quick script to initialize your `.stowrc` and install all packages.  
This has its benefits as you can use `stow` without any of the flags for the other parts of the
installation and future maintenance of dotfiles.

```zsh
cd ~/.dotfiles
./install.sh
```

##### Deploy a specific package (e.g., Neovim):

If you ran install.sh and are using the same `.stowrc`, you can use

```zsh
stow nvim
```

Otherwise, you must manually type the flags.

```zsh
stow -v -R -t ~ nvim
```

**Command Breakdown:**

| Flag   | Description                                                                                              |
| ------ | -------------------------------------------------------------------------------------------------------- |
| `-v`   | Verbose output — shows exactly where symlinks are created                                                |
| `-R`   | Restow — prunes dead links and refreshes existing ones (safest option; essential after adding new files) |
| `-t ~` | Sets the target to your home directory                                                                   |

---

## Maintenance

### Adding New Configurations

1. Create a folder named after the app.
2. Mirror the home directory structure inside it (e.g., `myapp/.config/myapp/config.conf`).
3. Run `stow -R -t ~ myapp` if you skipped `install.sh` and are not using the same `.stowrc`, otherwise just use `stow myapp`

### Removing Configurations

To delete the symlinks and "uninstall" a configuration from the home directory without deleting the actual files in this repo:

```zsh
stow -D -t ~ nvim
```

Of course, if you are using the same `.stowrc` you can ignore the `-t ~`.

---

## Stuff I Use

| Tool                                                                 | What is it?              |
| -------------------------------------------------------------------- | ------------------------ |
| [Fedora](https://fedoraproject.org/)                                 | Daily driver OS          |
| [Zsh](https://www.zsh.org/) with [Oh My Zsh](https://ohmyz.sh)       | Shell                    |
| [Neovim](https://neovim.io/)                                         | Editor                   |
| [Ghostty](https://ghostty.org/)                                      | Terminal                 |
| [Yazi](https://github.com/sxyazi/yazi)                               | File manager             |
| [Lazygit](https://github.com/jesseduffield/lazygit)                  | TUI for Git              |
| [Keyd](https://github.com/rvaiya/keyd)                               | Key remapping            |
| [Shell Color Scripts](https://gitlab.com/dwt1/shell-color-scripts)   | Terminal colorscripts    |
| [IntelliJ](https://www.jetbrains.com/idea) through JetBrains Toolbox | Java IDE                 |
| [Fast Node Manager (FNM)](https://github.com/Schniz/fnm)             | Node version management  |
| [Zoxide](https://github.com/ajeetdsouza/zoxide)                      | A smarter cd             |
| [Bat](https://github.com/sharkdp/bat)                                | cat(1) with wings        |
| [Fastfetch](https://github.com/fastfetch-cli/fastfetch)              | System information tool  |
| [Bun](https://bun.com)                                               | An all in one JS toolkit |
| [Bum](https://github.com/owenizedd/bum)                              | Bun version manager      |

---

> [!WARNING]
> Stow will fail if there is already a "real" file (not a symlink) where it's trying to link. Move or delete existing config files in your `$HOME` before stowing for the first time.
