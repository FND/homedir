# add ~/bin to PATH
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# create temporary directories
mkdir -p /tmp/trash
mkdir -p /tmp/dev

# Python shell settings
export PYTHONSTARTUP="$HOME/.pythonrc.py"

[[ -f ~/.bashrc ]] && . ~/.bashrc
