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
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# User configuration

# Example aliases

## Env Vars

# bun
export BUN_INSTALL="$HOME/.bun"

export BAT_PAGER=""
export MANPAGER='nvim +Man!'
export GTK_THEME=Adwaita:dark
export GOPATH="$HOME/.go"
export GRADLE_HOME=/opt/gradle/gradle-8.13
export JAVA_HOME=/usr/lib/jvm/java-25-openjdk
export PATH="$BUN_INSTALL/bin:$JAVA_HOME/bin:${GRADLE_HOME}/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/nvim/mason/bin:$PATH"
export SNIPPETBOX_DB_URL="sbox:snip123@tcp(127.0.0.1:3306)/snippetbox?parseTime=true"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/themes/koda.yml"
# editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# fnm
FNM_PATH="/home/valentino7504/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env --use-on-cd --shell zsh)"
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

autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv_autoloader

dnf-refresh-installed() {
    dnf repoquery --userinstalled --qf "%{name}\n" > .dotfiles/installed-packages.txt
}

# bun completions
[ -s "/home/valentino7504/.bun/_bun" ] && source "/home/valentino7504/.bun/_bun"
python_venv_autoloader


# for metrics uncomment
# zprof
