# zmodload zsh/zprof # uncomment for metrics (at the very top)

# ==============================================================================
# 1. CORE ZSH SETTINGS & PATHS
# ==============================================================================
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
typeset -U path PATH
path=(
    "$ASDF_DATA_DIR/shims"
    "$HOME/.local/bin"
    "$HOME/.local/share/nvim/mason/bin"
    $path
)

autoload -U colors && colors
setopt PROMPT_SUBST
setopt SHARE_HISTORY
setopt EXTENDED_GLOB      # Required for the optimized compinit check below
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
bindkey -v

# ==============================================================================
# 2. COMPLETION SYSTEM (Optimized compinit)
# ==============================================================================
# Add asdf completions to fpath BEFORE compinit runs
fpath=($ASDF_DATA_DIR/completions $fpath)

ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
autoload -Uz compinit

if [[ -n "$ZSH_COMPDUMP"(#qN.m-1) ]]; then
    compinit -u -C -d "$ZSH_COMPDUMP"
else
    compinit -u -d "$ZSH_COMPDUMP"
fi
# Background compilation for next startup
{
    if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
        zcompile "$ZSH_COMPDUMP"
    fi
} &!
# Case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}'

# ==============================================================================
# 3. THE ROBBYRUSSELL THEME
# ==============================================================================
function git_prompt_info() {
    local branch=$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)
    [[ -z $branch ]] && return

    local dirty=""
    if [[ -n $(git status -s 2> /dev/null) ]]; then
        dirty="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
    else
        dirty="%{$fg[blue]%})%{$reset_color%}"
    fi
    echo "%{$fg_bold[blue]%}git:(%{$fg[red]%}${branch}${dirty}"
}

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} "
PROMPT+='$(git_prompt_info) '

# ==============================================================================
# 4. TOOLS & ENVIRONMENT
# ==============================================================================
# Source ASDF Java helper if it exists
[[ -f "$ASDF_DATA_DIR/plugins/java/set-java-home.zsh" ]] && . "$ASDF_DATA_DIR/plugins/java/set-java-home.zsh"

export BAT_PAGER=""
export MANPAGER='nvim +Man!'
export GTK_THEME=Adwaita:dark
export SNIPPETBOX_DB_URL="sbox:snip123@tcp(127.0.0.1:3306)/snippetbox?parseTime=true"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/themes/koda.yml"
export EDITOR=$([[ -n $SSH_CONNECTION ]] && echo 'vim' || echo 'nvim')

# Zoxide (Initialize after paths are set)
eval "$(zoxide init zsh)"

# ==============================================================================
# 5. ALIASES
# ==============================================================================
alias snvim='sudo -E nvim'
alias syscat="/bin/cat"
alias cat="bat"
alias ls='eza --icons --color=auto --group-directories-first'
alias ll='eza --icons --color=auto -alh --group-directories-first'
alias tree='eza --tree --icons --color=auto'
alias lg="lazygit"
alias dnf-refresh-installed='dnf repoquery --userinstalled --qf "%{name}\n" > .dotfiles/installed-packages.txt'
alias asdf-plugin-refresh='asdf plugin list --urls > .asdf-plugins'

# ==============================================================================
# 6. EXTERNAL PLUGINS
# ==============================================================================
# Source autosuggestions (Must be sourced after compinit)
[[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==============================================================================
# 7. CUSTOM FUNCTIONS (Yazi, C Project, Venv)
# ==============================================================================
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

mkc() {
    local name=$1
    local author_name=$(git config user.name)
    local current_date=$(date +%Y-%m-%d)
    local template_dir="$HOME/.config/template-files"

    if [[ -z "$name" ]]; then echo "Usage: mkc <project_name>"; return 1; fi
    if [[ -d "$name" ]]; then echo "Error: Directory '$name' already exists."; return 1; fi

    mkdir -p "$name/src" "$name/build" "$name/bin" && cd "$name" || return
    git init -q
    cp "$template_dir/gitignore/c" ./.gitignore
    cp "$template_dir/makefiles/MakefileC.tmplt" ./Makefile
    sed -e "s/{{PROJECT_NAME}}/$name/g" \
        -e "s/{{AUTHOR}}/${author_name:-"User"}/g" \
        -e "s/{{DATE}}/$current_date/g" \
        "$template_dir/code/c/main.c.tmplt" > src/main.c

    command -v bear >/dev/null 2>&1 && bear -- make all >/dev/null 2>&1 || make all >/dev/null 2>&1

    cp ~/.config/template-files/code/c/.clang-format ./.clang-format
    cp ~/.config/template-files/code/c/.gdbinit ./.gdbinit
    echo "C project '$name' initialized."
}

python_venv_autoloader() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        if [[ "$PWD" != "${VIRTUAL_ENV%/*}"* ]]; then
            deactivate
        fi
    fi
    if [[ -z "$VIRTUAL_ENV" && -d "./.venv" ]]; then
        source ./.venv/bin/activate
    fi
}

venv_init() {
    [[ -d ./.venv ]] && return
    local project_name="${PWD:t}"
    echo "Creating .venv for $project_name..."
    python3 -m venv .venv --prompt "$project_name" && python_venv_autoloader || return 1
}

autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv_autoloader
python_venv_autoloader

# zprof # uncomment for metrics (at the very bottom)
