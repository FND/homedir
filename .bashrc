# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# basic settings
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:ignorespace
HISTTIMEFORMAT="%F %T "

# append to the history file (rather than overwriting it)
shopt -s histappend

# check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

#
# FND
#

# set environment variables
export EDITOR="vim"
set -o vi

# custom shell prompt
#PS1='${debian_chroot:+($debian_chroot)}\w$ '
# shorten path
PROMPT_COMMAND='DIR=`pwd | sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:5}…${DIR:${#DIR}-20}; else CurDir=$DIR; fi'
#PS1="\$CurDir\$ "
# display current Git branch
parse_git_branch() {
	local branch=$(git branch 2> /dev/null | grep "^\* [^(]" | cut -c 3-)
	[ $branch ] && echo "[$branch]"
}
PS1="\$CurDir\$(parse_git_branch)\$ "

# custom aliases
source ~/.alias

# todotxt auto-completion
source ~/Dev/todo.txt-cli/todo_completion
complete -F _todo t # required for alias

# MotD on first terminal (usually persistent, e.g. Tilda)
if [ `tty` = "/dev/pts/0" ]; then
	todo.sh listpri
	ssh-add ~/.ssh/id_rsa
fi

# command bookmarks
if [ -f "$HOME/.shellmarks" ]; then
	set -o history
	set -o histexpand
	while read line; do
		history -s "$line"
	done < "$HOME/.shellmarks"
fi
