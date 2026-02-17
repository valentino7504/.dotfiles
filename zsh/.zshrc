# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Example aliases
# alias zshconfig="mate ~/.zshrc"
source "$HOME/.cargo/env"

## Env Vars
export BAT_PAGER=""
export MANPAGER='nvim +Man!'
export GTK_THEME=Adwaita:dark
export GOPATH="$HOME/.go"
export GRADLE_HOME=/opt/gradle/gradle-8.13
export JAVA_HOME=/usr/lib/jvm/java-25-openjdk
export PATH=${GRADLE_HOME}/bin:${PATH}
export PATH=$JAVA_HOME/bin:$PATH
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$GOPATH/bin:~/.local/share/nvim/mason/bin"
export SNIPPETBOX_DB_URL="sbox:snip123@tcp(127.0.0.1:3306)/snippetbox?parseTime=true"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/themes/koda.yml"
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

## My Aliases
alias neofetch="fastfetch"
alias fd="fdfind"
alias "sudonvim"='sudo /usr/bin/nvim'
alias ohmyzsh="mate ~/.oh-my-zsh"
alias syscat="/bin/cat"
alias cat="bat"
alias ls='eza --icons --color=auto --group-directories-first'
alias ll='eza --icons --color=auto -alh --group-directories-first'
alias tree='eza --tree --icons --color=auto'
alias lg="lazygit"

eval "$(zoxide init zsh)"

# MY CUSTOM FUNCTIONS
function y() {
    yazi "$@"
}

function z() {
    __zoxide_z "$@"

    if [[ -z "$VIRTUAL_ENV" ]] ; then
        if [[ -d ./.venv ]] ; then
            source ./.venv/bin/activate
        fi
    else
        parentdir="$(dirname "$VIRTUAL_ENV")"
        if [[ "$PWD"/ != "$parentdir"/* ]] ; then
            deactivate
        fi
    fi
}


mkc() {
    local name=$1
    if [ -z "$name" ]; then
        echo "Usage: mkc <project_name>"
        return 1
    fi
    if [ -d "$name" ]; then
        echo "Error: Directory '$name' already exists."
        return 1
    fi

    # directory initialization
    mkdir -p "$name/src" "$name/build" "$name/bin" && cd "$name" || return

    # git
    git init -q
    local author_name=$(git config user.name)
    local current_date=$(date +%Y-%m-%d)
    cat <<EOF > .gitignore
build/
bin/
*.o
compile_commands.json
.cache/
.gdbinit
*.swp
EOF

    # create Makefile
    cat <<EOF > Makefile
CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -Wpedantic -Wshadow -Werror -g
OBJ_DIR = build
BIN_DIR = bin

# Automatically find all .c files in src/
SRC = \$(wildcard src/*.c)
# Convert src/file.c to build/file.o
OBJ = \$(SRC:src/%.c=\$(OBJ_DIR)/%.o)
TARGET = \$(BIN_DIR)/main

all: \$(TARGET)

# Link step
\$(TARGET): \$(OBJ)
	@mkdir -p \$(BIN_DIR)
	\$(CC) \$(OBJ) -o \$(TARGET)

# Compile step
\$(OBJ_DIR)/%.o: src/%.c
	@mkdir -p \$(OBJ_DIR)
	\$(CC) \$(CFLAGS) -c $< -o \$@

run: all
	./\$(TARGET)

memcheck: all
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./\$(TARGET)

debug: all
	gdb -nh -x .gdbinit ./\$(TARGET)

clean:
	rm -rf \$(OBJ_DIR)/* \$(BIN_DIR)/*
EOF

    # create main.c
    cat <<EOF > src/main.c
/**
 * Project: $name
 * Author:  ${author_name:-"User"}
 * Date:    $current_date
 */

#include <stdio.h>

int main(void) {
    printf("Project $name initialized.\\n");
    return 0;
}
EOF

    # create compile_commands.json
    if command -v bear >/dev/null 2>&1; then
        bear -- make all >/dev/null 2>&1
    else
        make all >/dev/null 2>&1
    fi

    # create .clang-format and gdbinit
    cat <<EOF > .clang-format
---
Language: C
BasedOnStyle: LLVM
IndentWidth: 4
TabWidth: 4
UseTab: Never
ColumnLimit: 100
BreakBeforeBraces: Attach
SpaceBeforeParens: ControlStatements
SpacesInParentheses: false
PointerAlignment: Right
SortIncludes: true
AlignConsecutiveMacros: true
...
EOF

    cat <<EOF > .gdbinit
set history save on
set confirm off
set disassembly-flavor intel
tui enable
layout src
focus cmd
EOF

    echo "C project '$name' initialized in."
    echo "Directories: src/ (source), build/ (objects), bin/ (binary)"
    echo "Commands: 'make', 'make run', 'make memcheck', 'make debug', 'make clean'"

}

venv_activate() {
    if [ -d ".venv" ]; then
        echo "Virtual environment .venv already exists. Activating..."
    else
        echo "Virtual environment .venv not found. Creating one..."
        python3 -m venv .venv
        if [ $? -ne 0 ]; then
            echo "Failed to create virtual environment. Make sure Python3 is installed and try again."
            return 1
        fi
        echo "Virtual environment .venv created successfully."
    fi

    # Activate the virtual environment
    echo "Activating .venv..."
    source .venv/bin/activate
    if [ $? -eq 0 ]; then
        echo "Virtual environment .venv activated."
    else
        echo "Failed to activate virtual environment. Check for issues and try again."
        return 1
    fi
}

cd() {
    builtin cd "$@"

    if [[ -z "$VIRTUAL_ENV" ]] ; then
        # if env folder is found then activate the vitualenv
        if [[ -d ./.venv ]] ; then
            source ./.venv/bin/activate
        fi
    else
        # check the current folder belong to earlier VIRTUAL_ENV folder
        # if yes then do nothing
        # else deactivate
        parentdir="$(dirname "$VIRTUAL_ENV")"
        if [[ "$PWD"/ != "$parentdir"/* ]] ; then
            deactivate
        fi
    fi
}


