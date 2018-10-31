HISTFILESIZE=100000000
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
    sudo cp ~/.{vimrc,bashrc,tmux.conf} $home
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

PATH="~/.local/bin:~/.gem/ruby/2.5.0/bin:$PATH"
PATH="$HOME/.config/composer/vendor/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
#custom functions
if [ -d $HOME/Projects/scripts/functions ]; then
    for f in $HOME/Projects/scripts/functions/*; do
        source $f
    done
fi

export GOPATH=$HOME/Projects/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export PATH=$PATH:/snap/bin
export EDITOR=vim
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'

export WORKON_HOME=~/.venvs
 #System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

shopt -s checkwinsize
shopt -s cmdhist
shopt -s autocd
#PS1="\[\033[36m\]\u\[\033[1;31m\]@\[\033[0;32m\]\h\[\033[m\]:\[\033[33m\]\w\[\033[m\]> "
PROMPT_COMMAND='COLOR=$(context-color)'
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
alias wiki='nvim +VimwikiIndex'
alias msfconsole="msfconsole --quiet -x \"db_connect postgres@msf\""
alias shrug="echo -n \¯\\\_\(\ツ\)\_\/\¯ | xclip -sel clipboard"

complete -F _ssh ssh
