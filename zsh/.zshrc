export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
DISABLE_MAGIC_FUNCTIONS=true

plugins=(git history kubectl)

source $ZSH/oh-my-zsh.sh

# EXPORT
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

prompt_hashcolor=$(hostname|cksum|awk '{print $1%256}')
HOSTNAME=$(hostname)
export PROMPT="[%{$fg[yellow]%}%n%{$reset_color%}@%F{${prompt_hashcolor}}$HOSTNAME%F %{$fg[green]%}%c%{$reset_color%}]$ "

export GOPATH=$HOME/Projects/go
export PATH="$HOME/.bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"
export PATH="$PATH:/var/lib/snapd/snap/bin"
#export PATH="$HOME/.yarn/bin:$PATH"
export EDITOR=vim

NPM_PACKAGES="${HOME}/.npm-packages"

export PATH="$PATH:$NPM_PACKAGES/bin"

export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export WORKON_HOME=~/.venvs

# Alias
alias k="kubectl"
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

## CTF
alias apkd="sudo docker run -ti -v $(pwd):/apk duolabs/apk2java \"/apk/$1\""

# networking
alias ip="ip -c"
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

extract () {
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
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

mcd() {
    if [ ! -z "$1" ]; then
        mkdir -p -- "$1";
        cd -- "$1";
    fi
}


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

setopt share_history
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#PS1="%{%F{red}%}%n%{%f%}@%{%F{blue}%}%m %~ %{$%f%}%% "
