export SHELL="/bin/bash"
alias tmux="tmux -S ~/.tmux-session"
export SCREENDIR=$HOME/.screen

#source ~/.git-prompt.sh

EDITOR='emacs'
VISUAL=$EDITOR
alias e='emacs -nw'
alias gitlp='git log --oneline --decorate --graph --all'
alias gitll='git log --oneline --decorate'
alias githistfile='git log --follow -p --'
alias githist='git log --pretty=format:"%h | %s%d [%an]" --graph --date=short'
alias gitcp='git cherry-pick'

alias rcolor='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias lst1='ls -R | grep ":$" | sed -e '"'"'s/:$//'"'"' -e '"'"'s/[^-][^\/]*\//--/g'"'"' -e '"'"'s/^/   /'"'"' -e '"'"'s/-/|/'"'"
alias dirsize='du -ch'
alias editcron='crontab -e'
alias untar="tar xvzf"
alias tabit="sed 's/^ *//' | sed -e 's/  */\t/1'"
alias sorted="sort | uniq -c | sort -nr | tabit"
alias rmcolors='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
# Git
alias gitu='git pull'
alias gitc='git commit -a -m '
alias gitp='git push'
alias gitm=gitc
alias gita='git commit -a --amend'
alias gitl='git log --name-status'
alias gitreset='git reset --hard ; git clean -dfx' # - Use with extreme caution
# Json
alias pretty_json='python2.7 -mjson.tool'

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTFILESIZE=1000000
export HISTSIZE=1000000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# some more ls aliases
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -l --color'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi


bind '"\e[A": history-search-backward'


bind '"\e[B": history-search-forward'

alias cd3='cd ../../..'
