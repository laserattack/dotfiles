# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# start X session
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] && command -v startx >/dev/null 2>&1; then
    exec startx
fi

HISTSIZE=50000
HISTFILESIZE=10000000

PS1='\[\e[34m\]\w\n\[\e[32m\]→ \[\e[0m\]'

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
alias fzfh='history | fzf'
alias fzfp='ps aux | fzf'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

enc() {
    local usage="Usage: enc <filename>"
    local input="$1"
    if [ "$#" -ne 1 ]; then
        echo "$usage"
        return 1
    fi
    if [ -d "$input" ]; then
        archname="${input%/}.tar.gz"
        tar czf "$archname" -C "$(dirname "$input")" "$(basename "$input")"
        input=$archname
    fi
    openssl enc -aes-256-cbc -salt -pbkdf2 -in "$1" -out "$1".enc
}

dec() {
    local usage="Usage: dec <filename.enc>"
    if [ "$#" -ne 1 ] || [[ "$1" != *.enc ]]; then
        echo "$usage"
        return 1
    fi
    openssl enc -aes-256-cbc -d -salt -pbkdf2 -in "$1" -out "${1%.enc}"
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

radio() {
    local usage="Usage: radio [jazz|lofi|relax|classic|black|kfai]"
    local url

    if [ "$#" -ne 1 ]; then
        echo "$usage"
        return 1
    fi

    case "$1" in
        jazz)      url="https://stream.srg-ssr.ch/srgssr/rsj/mp3/128";;
        lofi)      url="https://live.hunter.fm/lofi_low";;
        relax)     url="https://pub0201.101.ru/stream/trust/mp3/128/24?";;
        classic)   url="https://stream.srg-ssr.ch/srgssr/rsc_de/mp3/128";;
        black)     url="https://moshhead-blackmetal.stream.laut.fm/moshhead-blackmetal";;
        kfai)      url="https://kfai.broadcasttool.stream/kfai-1";;
        *)
            echo "$usage"
            return 1
            ;;
    esac

    mpv --really-quiet "$url"
}

sfx() {
    local file="$HOME/Music/Sounds/$1"
    for ext in ogg mp3 wav; do
        if [[ -f "$file.$ext" ]]; then
            mpv --really-quiet --no-video "$file.$ext"
            return
        fi
    done
}

timer() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: timer <seconds>"
        return
    fi
    sleep "$1"
    sfx good
    notify-send -t 5000 "timer complete" "$1 seconds elapsed"
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

tempe() {
    cd "$(mktemp -d)"
    chmod -R 0700 .
    if [[ $# -eq 1 ]]; then
        \mkdir -p "$1"
        cd "$1"
        chmod -R 0700 .
    fi
}

tempec() {
    rm -rf /tmp/tmp.*
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
