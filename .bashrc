# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# start X session
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] && command -v startx >/dev/null 2>&1; then
    exec startx
fi

HISTSIZE=50000
HISTFILESIZE=10000000

#PS1='\[\e[34m\]\w\n\[\e[32m\]-> \[\e[0m\]'
PS1='\[\e[34m\]\w\n\[\e[32m\][\u@\h]-> \[\e[0m\]'

# Forces bash to save the command history immediately
# after each command is executed
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

alias ls='ls --color=auto'
# alias clear='tput reset'

alias gcl='git clone --depth 1 --no-tags --single-branch'
alias gs='git status'
gg() { git log -p -G"$1"; }
grcd() { local d; d=$(gitrew "$@" 2>/dev/null) && cd "$d" 2>/dev/null; }

alias fzfh='history | fzf'
alias fzfp='ps aux | fzf'
fzfv() { f=$(rg --files "${1:-.}" 2>/dev/null | fzf) && nvim "$f"; }

alias cp='cp -iv'
alias ln='ln -i'
alias mv='mv -iv'
alias rm='rm -iv'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

. $HOME/.local/bin/z.sh

# mountpoints
export SSD="/run/media/serr/KINGSTON"
export HDD="/run/media/serr/KESU"

backupthis () {
    cp -riv $1 ${1}-$(date +%Y%m%d%H%M).backup;
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

cacheclean() {
    sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
}

bb() {
    for cmd in "$@"; do
        setsid "$cmd" &>/dev/null
    done
}

hoy() {
    echo "$(date '+%Y-%m-%d')"
}

copy() {
    if hash pbcopy 2>/dev/null; then
        exec pbcopy
    elif hash xclip 2>/dev/null; then
        exec xclip -selection clipboard
    elif hash putclip 2>/dev/null; then
        exec putclip
    else
        rm -f /tmp/clipboard 2> /dev/null
        if [ $# -eq 0 ]; then
            cat > /tmp/clipboard
        else
            cat "$1" > /tmp/clipboard
        fi
    fi
}

prettypath() {
    echo "$PATH" | sed 's/:/\
    /g'
}

running() {
    process_list="$(ps -eo 'pid command')"
    if [[ $# != 0 ]]; then
        process_list="$(echo "$process_list" | grep -Fi "$@")"
    fi

    echo "$process_list" |
        grep -Fv "${BASH_SOURCE[0]}" |
        grep -Fv grep |
        GREP_COLORS='mt=00;35' grep -E --colour=auto '^\s*[[:digit:]]+'
}

uppered() {
    tr '[:lower:]' '[:upper:]'
}

lowered() {
    tr '[:upper:]' '[:lower:]'
}

# example: cat some_big_file | line 10
line() {
    head -n "$1" | tail -n 1
}

trash() {
    gio trash "$@"
}

mkcd() {
    \mkdir -p "$1"
    cd "$1"
}

cpwd() {
    pwd | tr -d '\n' | copy
}

gacp() {
    if [ "$#" -eq 1 ]; then
        git add . && git commit -m "$1" && git push
    else
        git add . && git commit -m "quick update" && git push
    fi
}

gcf() {
    if [ $# -lt 2 ]; then
        echo "Usage: gcf <repository-url> <folder-path>"
        echo "Example: gcf https://github.com/github/codeql.git java/ql/src/Security/CWE"
        return 1
    fi

    local repo_url="$1"
    local folder_path="$2"
    local repo_name=$(basename "$repo_url" .git)

    (
        git clone -n --depth=1 --filter=tree:0 "$repo_url" "$repo_name"
        cd "$repo_name"
        git sparse-checkout set --no-cone "$folder_path"
        git checkout
    )
}
. "$HOME/.cargo/env"
