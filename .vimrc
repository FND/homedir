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

" HTML-specific settings
autocmd FileType html set makeprg=python\ ~/Scripts/JSLint/wrapper.py\ %
autocmd FileType html set errorformat=%f:%l:%c:%m
autocmd FileType xhtml set makeprg=python\ ~/Scripts/JSLint/wrapper.py\ %
autocmd FileType xhtml set errorformat=%f:%l:%c:%m

" JavaScript-specific settings
autocmd FileType javascript set makeprg=python\ ~/Scripts/JSLint/wrapper.py\ %
autocmd FileType javascript set errorformat=%f:%l:%c:%m

" Python-specific settings
autocmd FileType python set makeprg=python\ ~/Scripts/pep8.py\ %
autocmd FileType python set errorformat=%f:%l:%c:\ %m
