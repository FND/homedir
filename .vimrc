set nocompatible " use Vim rather than Vi settings

set backspace=indent,eol,start " allow backspacing over everything in insert mode

set nobackup

set nowrap
set ruler
set number

set hlsearch
syntax on

set spell spelllang=en_us
autocmd FileType html,xhtml,javascript,python,sh set nospell

set incsearch
set autoindent

set tabstop=4
set shiftwidth=4

set directory=/tmp/

filetype plugin on
set omnifunc=syntaxcomplete#Complete

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

" highlight long lines
match ErrorMsg '\%>80v.\+'

" strip trailing whitespace
"autocmd BufWritePre,FileWritePre * call StripTrailingWhitespace()
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
autocmd FileType html,xhtml,javascript set makeprg=python\ ~/Scripts/jslint-cli/wrapper_spidermonkey.py\ %
autocmd FileType html,xhtml,javascript set errorformat=%f:%l:%c:%m
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Python-specific settings
autocmd FileType python set makeprg=python\ ~/Scripts/pep8.py\ %
autocmd FileType python set errorformat=%f:%l:%c:\ %m
autocmd FileType python set omnifunc=pythoncomplete#Complete

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
nmap <F5> :call StripTrailingWhitespace()<CR>

" custom abbreviations
iabbrev DBG XXX: DEBUG

" make SuperTab use omni-completion
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
