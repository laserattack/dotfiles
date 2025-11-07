# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=50000
HISTFILESIZE=10000000

# Forces bash to save the command history immediately 
# after each command is executed
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

alias ls='ls --color=auto'
alias clear='tput reset'
alias gcl='git clone --depth 1 --no-tags --single-branch'
gacp() {
    if [ "$#" -eq 1 ]; then
        git add . && git commit -m "$1" && git push
    else
        git add . && git commit -m "quick update" && git push
    fi
}
gcf() {
    if [ $# -lt 2 ]; then
        echo "Usage: gcf <repository-url> <folder-path> [branch]"
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
alias gs='git status'
alias ff="fastfetch"
alias fzfh='history | fzf'
alias fzfp='ps aux | fzf'
alias fzfn='file=$(find . -type f | fzf) && n "$file"'
alias fzfg='_fzfg() {
    if [ $# -eq 0 ]; then 
        git log --oneline | fzf --ansi --preview "git show --color=always {1}";
    else
        git log -S "$*" --oneline | fzf --ansi --preview "git show --color=always {1}";
    fi;
}; _fzfg'

PS1='\[\e[34m\]\w\n\[\e[32m\]→ \[\e[0m\]'
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export PATH="$HOME/software:$PATH"
export PATH="$HOME/software/nvim-linux-x86_64/bin:$PATH"
export PATH="$HOME/software/xkb-switch/build:$PATH"
export PATH="$HOME/software/go/bin:$PATH"
