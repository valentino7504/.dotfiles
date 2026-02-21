# for metrics uncomment
# zmodload zsh/zprof

typeset -U path PATH
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 15
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
plugins=(git asdf zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# User configuration

# Example aliases

## Env Vars

# bun

export BAT_PAGER=""
export MANPAGER='nvim +Man!'
export GTK_THEME=Adwaita:dark
. ~/.asdf/plugins/java/set-java-home.zsh
export PATH="$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin:$PATH"
export SNIPPETBOX_DB_URL="sbox:snip123@tcp(127.0.0.1:3306)/snippetbox?parseTime=true"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/themes/koda.yml"
# editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

## My Aliases
alias "sudonvim"='sudo /usr/bin/nvim'
alias ohmyzsh="mate ~/.oh-my-zsh"
alias syscat="/bin/cat"
alias cat="bat"
alias ls='eza --icons --color=auto --group-directories-first'
alias ll='eza --icons --color=auto -alh --group-directories-first'
alias tree='eza --tree --icons --color=auto'
alias lg="lazygit"
alias dnf-refresh-installed="dnf repoquery --userinstalled --qf "%{name}\n" > .dotfiles/installed-packages.txt"
alias "asdf-plugin-refresh"="asdf plugin list --urls > .asdf-plugins"


eval "$(zoxide init zsh)"

# MY CUSTOM FUNCTIONS
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# create C project
mkc() {
    local name=$1
    local author_name=$(git config user.name)
    local current_date=$(date +%Y-%m-%d)
    local template_dir="$HOME/.config/template-files"

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
    cp "$template_dir/gitignore/c" ./.gitignore
    cp "$template_dir/makefiles/MakefileC.tmplt" ./Makefile
    sed -e "s/{{PROJECT_NAME}}/$name/g" \
        -e "s/{{AUTHOR}}/${author_name:-"User"}/g" \
        -e "s/{{DATE}}/$current_date/g" \
        "$template_dir/code/c/main.c.tmplt" > src/main.c

    # create compile_commands.json
    if command -v bear >/dev/null 2>&1; then
        bear -- make all >/dev/null 2>&1
    else
        make all >/dev/null 2>&1
    fi

    # create .clang-format and gdbinit
    cp ~/.config/template-files/code/c/.clang-format ./.clang-format
    cp ~/.config/template-files/code/c/.gdbinit ./.gdbinit


    echo "C project '$name' initialized in."
    echo "Directories: src/ (source), build/ (objects), bin/ (binary)"
    echo "Commands: 'make', 'make run', 'make memcheck', 'make debug', 'make compile_commands', 'make clean'"
}


python_venv_autoloader() {
    # If a venv is currently active
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Check if we are still inside the project that owns this venv
        # ${VIRTUAL_ENV%/*} is a fast shell way to get the parent folder
        local project_root="${VIRTUAL_ENV%/*}"

        if [[ "$PWD" != "$project_root"* ]]; then
            deactivate
        fi
    fi

    # If no venv is active, check if we just entered a project with one
    if [[ -z "$VIRTUAL_ENV" && -d "./.venv" ]]; then
        source ./.venv/bin/activate
    fi
}

venv_init() {
    [[ -d ./.venv ]] && return
    # Get the name of the current directory to use as the prompt
    local project_name="${PWD:t}"
    echo "Creating .venv for $project_name..."
    if python3 -m venv .venv --prompt "$project_name"; then
        python_venv_autoloader
    else
        echo "Creation failed."
        return 1
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv_autoloader

# bun completions
python_venv_autoloader

# for metrics uncomment
# zprof
