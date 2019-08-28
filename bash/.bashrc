#HISTORY
HISTSIZE=-1 HISTFILESIZE=-1
HISTIGNORE='ls:bg:fg:history'
HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# AUTOCOMPLETE / COMPLETION
_ssh()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config ~/.ssh/config.d/* 2>/dev/null | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# EXPORT
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export GOPATH=$HOME/Projects/go
export PATH="$HOME/.bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export PATH=$PATH:/snap/bin
#export PATH="$HOME/.yarn/bin:$PATH"
export EDITOR=vim

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export WORKON_HOME=~/.venvs

# EXIT if not interactive
if [ -z "$PS1" ]; then
   return
fi

# OPTIONS

shopt -s checkwinsize
shopt -s cmdhist
shopt -s autocd

# PROMPT
PROMPT_COMMAND='COLOR=$(context-color)'
PS1='\[\e[1m\]\u\[$COLOR\]@\[\e[0m\]\[\e[1;32m\]\W\[\e[0m\]: '

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

# Alias
alias v="vim"
alias d="docker"
alias k="kubectl"
if command -v nvim >/dev/null 2>&1; then
    alias vim="nvim"
fi
alias grep='grep --color=no'
alias gtop='gotop'
alias less='less -R'
alias ls='ls --color=always'
alias suod='echo NO NO NO && sleep 10'
alias e='emacsclient -cn'
alias wiki='echo "Just use org-mode 4Head"'
## alias msfconsole="msfconsole --quiet -x \"db_connect postgres@msf\""
alias shrug="echo -n \¯\\\_\(\ツ\)\_\/\¯ | xclip -sel clipboard"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias todo="ag --color-line-number '1;36' --color-path '1;36' --ignore-case --print-long-lines --silent '(?:<!-- *)?(?:#|//|/\*+|<!--|--) *(TODO|FIXME|FIX|BUG|UGLY|HACK|NOTE|IDEA|REVIEW|DEBUG|OPTIMIZE)(?:\([^(]+\))?:?(?!\w)(?: *-->| *\*/|(?= *(?:[^:]//|/\*+|<!--|@|--))|((?: +[^\n@]*?)(?= *(?:[^:]//|/\*+|<!--|@|--))|(?: +[^@\n]+)?))'"

## ignore snap devices
alias df="df -x squashfs"
alias lsblk="lsblk | grep -v loop"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# functions

function localMigrate {
    home=$(sudo su $1 -l -c "pwd")
    sudo su $1 -c "cd $home; mkdir -p $home/.local/bin $home/.terminfo/${TERM:0:1}"
    sudo cp -r ~/.terminfo/${TERM:0:1}/* $home/.terminfo/${TERM:0:1}/
    sudo cp {~,$home}/.local/bin/context-color
    sudo cp ~/.{bashrc,tmux.conf} $home
}

function peek {
    tmux split-window -p 33 "$EDITOR" "$@"
}

#function RGBcolor {
#    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
#}

#custom functions
if [ -d $HOME/Projects/scripts/functions ]; then
    for f in $HOME/Projects/scripts/functions/*; do
        source $f
    done
fi


## Docker functions - crez Duniel
dip() {
        # docker - get IP address for container
        local c_id="$(docker ps -q -f name=$1)"
        if [ ! -z "$c_id" ]; then
                local c_ip="$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1)"
                echo "$c_ip"
        fi
}

dua() {
    # docker - update all images
    local images=$(docker images | tail -n +2 | awk '{print $1}')
    for i in $images; do
        docker pull $i | cat
    done
        unset images
}

drm () {
    # docker - remove all dead containers
    docker rm "$(docker ps -qaf status=exited)"
}

dri() {
    # docker - remove all images
    docker rmi -f $(docker images -q)
}

dka() {
    # docker - kill all containers
    docker kill $(docker ps -q)
}

dps() {
    docker ps -a
}

dra() {
    # docker - delete all stopped containers
    docker rm $(docker ps -a -q)
}

drd() {
    # docker - remove dangling images
    docker rmi $(docker images -f "dangling=true" -q)
    #docker rmi "$(docker images -qaf dangling=true)"
}

dbd() {
    # docker - build from Dockerfile in $CWD
    docker build -t "$1"
}

dki() {
    # docker - run container and enter interactively
    docker run -tiP "$1" /bin/sh
}

# MAC OS X

[ -x /usr/bin/keychain ] && [ `id -u` -ne 0 ] && eval `keychain -q -Q --eval id_rsa`
