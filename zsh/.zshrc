# ----------------------------------------
# ZSH / Oh My Zsh
# ----------------------------------------

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
git
)

source $ZSH/oh-my-zsh.sh

# ----------------------------------------
# PATH setup (clean order)
# ----------------------------------------

export VOLTA_HOME="$HOME/.volta"
export PNPM_HOME="$HOME/Library/pnpm"

export PATH="/opt/homebrew/bin:$VOLTA_HOME/bin:$PNPM_HOME:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# ----------------------------------------
# PYENV (only if installed)
# ----------------------------------------

if command -v pyenv >/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/shims:$PATH"
    eval "$(pyenv init -)"
fi

# ----------------------------------------
# TERRAFORM COMPLETION
# ----------------------------------------

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# ----------------------------------------
# ZSH Productivity Tools
# ----------------------------------------

# Smart cd

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Autosuggestions

if [ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Syntax Highlighting

if [ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ----------------------------------------
# Useful aliases
# ----------------------------------------

alias ls="eza --icons"
alias ll="eza -lah --icons"
alias tree="eza --tree"
alias cat="bat"

# ----------------------------------------
# History helper
# ----------------------------------------

hgrep() {
  history | rg "^ *[0-9]* *$1"
}

# ----------------------------------------
# Starship
# ----------------------------------------

eval "$(starship init zsh)"
