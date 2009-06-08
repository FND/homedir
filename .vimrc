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

set tabstop=4
set shiftwidth=4

set directory=/tmp/

" custom status line
set laststatus=2
set statusline=%f%m%r%h%w " file name and flags
set statusline+=\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"} " encoding
set statusline+=[%{&ff}]\ [%Y] " file type
set statusline+=%= " right align
set statusline+=[%02l,%02v]\ [%p%%] " cursor position

" display whitespace characters
set list
set listchars=tab:⋯\ ,trail:·

" strip trailing whitespace
autocmd BufWritePre,FileWritePre * call StripTrailingWhitespace()
function! StripTrailingWhitespace()
	normal mz
	normal Hmy
	exec '%s/\s*$//g'
	normal 'yz<cr>
	normal `z
endfunction

" retrieve remote files' source (rather than rendered markup)
" (cf. http://vimperator.org/trac/ticket/25)
let g:netrw_http_cmd = "wget -q -O"

" (X)HTML- & JavaScript-specific settings
autocmd FileType html,xhtml,javascript set makeprg=python\ ~/Scripts/JSLint/wrapper.py\ %
autocmd FileType html,xhtml,javascript set errorformat=%f:%l:%c:%m

" Python-specific settings
autocmd FileType python set makeprg=python\ ~/Scripts/pep8.py\ %
autocmd FileType python set errorformat=%f:%l:%c:\ %m

" custom commands
command Clip call CopyToClipboard()
function! CopyToClipboard()
	normal mz
	normal Hmy
	normal ggVG"+y
	normal 'yz<cr>
	normal `z
endfunction

" custom mappings
noremap gb gT
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TlistToggle<CR>
