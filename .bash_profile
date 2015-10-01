# add ~/bin to PATH
if [ -d "$HOME/bin" ] ; then
       PATH="$HOME/bin:$PATH"
fi

# create temporary directories
mkdir -p /tmp/trash
mkdir -p /tmp/dev

# locale settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# history settings
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:ignorespace
HISTTIMEFORMAT="%F %T "

# append to the history file (rather than overwriting it)
shopt -s histappend

# check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# use vi as default editor and shell editing mode
export EDITOR="vim"
set -o vi

# Python shell settings
export PYTHONSTARTUP="$HOME/.pythonrc.py"

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

# auto-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# todotxt auto-completion
source ~/Dev/todo.txt-cli/todo_completion
complete -F _todo t # required for alias

# MotD on first terminal (usually persistent, e.g. Tilda)
if [ `tty` = "/dev/ttys001" ]; then
	todo.sh listpri
fi

# command bookmarks
if [ -f "$HOME/.shellmarks" ]; then
	set -o history
	set -o histexpand
	while read line; do
		history -s "$line"
	done < "$HOME/.shellmarks"
fi
