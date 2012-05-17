# add ~/bin to PATH
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# create temporary directories
mkdir -p /tmp/trash
mkdir -p /tmp/dev

# XTerm Unicode workaround (cf. https://bugs.archlinux.org/task/13914)
export LC_CTYPE=en_US.utf8

# Python shell settings
export PYTHONSTARTUP="$HOME/.pythonrc.py"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# touchpad settings
synclient PalmDetect=1
synclient TapButton1=0
synclient TapButton2=1
synclient CoastingSpeed=0
