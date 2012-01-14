import os
import readline
import rlcompleter
import atexit


# history
_history = os.path.expanduser("~/.python_history")
if not os.path.exists(_history):
    open(_history, "w").close()
readline.set_history_length(100)
readline.read_history_file(_history)
atexit.register(readline.write_history_file, _history) # TODO: limit size

# auto-completion
readline.parse_and_bind("tab: complete")
