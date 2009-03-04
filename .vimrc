set nocompatible " use Vim rather than Vi settings

set backspace=indent,eol,start " allow backspacing over everything in insert mode

set nobackup

set nowrap
set ruler
set number

set hlsearch
syntax on

set incsearch
set autoindent

" word completion
map! ^P ^[a. ^[hbmmi?\<^[2h"zdt.@z^Mywmx`mP xi
map! ^N ^[a. ^[hbmmi/\<^[2h"zdt.@z^Mywmx`mP xi

" strip trailing whitespace -- TODO: restore cursor position
autocmd BufWritePre,FileWritePre * %s/\s*$//g

" (X)HTML- & JavaScript-specific settings
autocmd FileType html,xhtml,javascript set makeprg=python\ ~/Scripts/JSLint/wrapper.py\ %
autocmd FileType html,xhtml,javascript set errorformat=%f:%l:%c:%m

" Python-specific settings
autocmd FileType python set makeprg=python\ ~/Scripts/pep8.py\ %
autocmd FileType python set errorformat=%f:%l:%c:\ %m
