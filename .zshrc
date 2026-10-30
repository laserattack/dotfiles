# --- Basic ---
HISTSIZE=50000
SAVEHIST=50000
setopt INC_APPEND_HISTORY  # save history immediately, not on exit

# Enable color support in zsh
autoload -U colors && colors

# Set the prompt:
# %F{blue} - blue color
# %~ - current directory
# %F{green} - green color
# %n - username
# %m - hostname
# %# - # symbol for root or % for regular user

PROMPT='%F{blue}%~%f
%F{green}[%n@%m]-> %f'

# Path to local binaries
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# --- Aliases ---
alias gcl='git clone --depth 1 --no-tags --single-branch'
alias gs='git status'
alias valgall='valgrind --leak-check=full --show-leak-kinds=all'
alias cp='cp -iv'
alias ln='ln -i'
alias mv='mv -iv'
alias rm='rm -iv'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# --- Functions ---
tmux3() {
  tmux new-session -d -s main -n launcher
  tmux new-window -t main -n home
  tmux new-window -t main -n work
  tmux select-window -t main:launcher
  tmux attach -t main
}

pyvenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "Already in virtual environment '$VIRTUAL_ENV'. Deactivating..."
        deactivate
        return
    fi
    if [ -d ".venv" ]; then
        echo "Virtual environment '.venv' already exists. Activating..."
    else
        python3 -m venv .venv
        echo "Virtual environment created!"
    fi
    source .venv/bin/activate
}

mkcd() {
    \mkdir -p "$1"
    cd "$1"
}

gacp() {
    if [ "$#" -eq 1 ]; then
        git add . && git commit -m "$1" && git push
    else
        git add . && git commit -m "quick update" && git push
    fi
}
