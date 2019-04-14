HISTSIZE= HISTFILESIZE=
HISTIGNORE='ls:bg:fg:history'
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'
export CLICOLOR=1
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}

function localMigrate {
    home=$(sudo su $1 -l -c "pwd")
    sudo su $1 -c "cd $home; mkdir -p $home/.local/bin $home/.terminfo/${TERM:0:1}"
    sudo cp -r ~/.terminfo/${TERM:0:1}/* $home/.terminfo/${TERM:0:1}/
    sudo cp {~,$home}/.local/bin/context-color
    sudo cp ~/.{bashrc,tmux.conf} $home
}

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

function peek {
    tmux split-window -p 33 "$EDITOR" "$@"
}

PATH="~/.bin:~/.cargo/bin:~/.local/bin:$PATH"
PATH="$HOME/.config/composer/vendor/bin:$PATH"

#custom functions
if [ -d $HOME/Projects/scripts/functions ]; then
    for f in $HOME/Projects/scripts/functions/*; do
        source $f
    done
fi

export GOPATH=$HOME/Projects/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export PATH=$PATH:/snap/bin
export PATH="/home/kb/.yarn/bin:$PATH"
export EDITOR=vim
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'

export WORKON_HOME=~/.venvs
 #System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

shopt -s checkwinsize
shopt -s cmdhist
shopt -s autocd
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
#PS1="\[\033[36m\]\u\[\033[1;31m\]@\[\033[0;32m\]\h\[\033[m\]:\[\033[33m\]\w\[\033[m\]> "
PROMPT_COMMAND='${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r; COLOR=$(context-color)'
PS1='\[\e[1m\]\u\[$COLOR\]@\[\e[0m\]\[\e[1;32m\]\W\[\e[0m\]: '
#PS1='\e[1;33m\e[\e[48;5;236m\h\e[90m\[\e[0m\]\e[1;32m\e[48;5;237m\W\[\e[0m\]'
# Make bash check its window size after a process completes

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

alias v="vim"
if command -v nvim >/dev/null 2>&1; then
    alias vim="nvim"
fi
alias grep='grep --color=always'
alias gtop='gotop'
alias less='less -R'
alias ls='ls --color=always'
alias suod='echo NO NO NO && sleep 10'
alias e='emacsclient -cn'
alias wiki='echo "Just use org-mode 4Head"'
alias msfconsole="msfconsole --quiet -x \"db_connect postgres@msf\""
alias shrug="echo -n \¯\\\_\(\ツ\)\_\/\¯ | xclip -sel clipboard"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#ignore snap devices
alias df="df -x squashfs"
alias lsblk="lsblk | grep -v loop"

complete -F _ssh ssh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source /usr/share/nvm/init-nvm.sh
export http_proxy=''
export https_proxy=''
export ftp_proxy=''
export socks_proxy=''

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
