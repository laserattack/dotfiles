# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=10000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# МОИ КАСТОМНЫЕ НАСТРОЕЧКИ

# Чтобы интерпретатор был доступен через lj
alias lj="luajit"
# ljsp запускает целевой скрипт через скрипт /usr/local/bin/sp.lua, 
# который добавляет папку ./lua_modules в пути в которых интерпретатор ищет зависимости
# запуск любого lua скрипта, зависимости которого установлены в ./lua_modules (папка в одной папке с целевым скриптом)
# теперь будет выглядеть так ljsp <имя целевого скрипта> 
alias ljsp="luajit /usr/local/bin/sp.lua"
# lrit <имя модуля> устанавливает зависимость в папку ./lua_modules (создастся автоматически) в текущей директории
alias lrit="luarocks install --tree ./deps"
# вызов fastfetch
alias ff="fastfetch"

# быстрый коммит
gacp() {
    if [ "$#" -eq 1 ]; then
        git add . && git commit -m "$1" && git push
    else
        git add . && git commit -m "quick update" && git push
    fi
}

# минимальный клон
alias gcl='git clone --depth 1 --no-tags --single-branch'

# показать все директории .git в текущей директории + ее поддиректориях
alias show_git_dirs='find . -type d -name ".git"'
# удалить все директории .git в текущей директории + ее поддиректориях
alias rm_git_dirs='find . -type d -name ".git" -exec rm -rf {} +'
# если не сделать такой clear то могут быть артефакты при прокрутке терминала вверх
alias clear='tput reset'

alias gs='git status'

alias fzfh='history | fzf'
alias fzfp='ps aux | fzf'
alias fzfn='file=$(find . -type f | fzf) && n "$file"'
# Почему то выдает ошибку синтаксическую если нормальной функцией оформляю
# тут fzfg без аргументов ищет с превью по именам коммитов в текущем репозитории
# а fzfg <TEXT> предварительно сортирует по тем коммитам где есть TEXT
alias fzfg='_fzfg() {
    if [ $# -eq 0 ]; then 
        git log --oneline | fzf --preview "git show --color=always {1}";
    else
        git log -S "$*" --oneline | fzf --preview "git show --color=always {1}";
    fi;
}; _fzfg'

wd() {
    docker run -it --rm \
        --volume="$(pwd):/t" \
        --workdir="/t" \
        --entrypoint bash \
        suchja/wine \
        -c "wine \"\$@\"" -- "$@"
}

# значок стрелочки вместо username@hostname
# PS1='\[\e[34m\]\w\n\[\e[32m\]→ \[\e[0m\]\$ '
PS1='\[\e[34m\]\w\n\[\e[32m\]→ \[\e[0m\]'

# Заставляет bash сохранять историю команд немедленно после выполнения каждой команды
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

alias nvimd="$HOME/projects/nvim-docker/nvimd.sh"
