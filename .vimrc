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

" retrieve remote files' source (rather than rendered markup)
" (cf. http://vimperator.org/trac/ticket/25)
let g:netrw_http_cmd = "wget -q -O"

" plain-text settings
autocmd FileType plaintext set textwidth=80
autocmd FileType plaintext set expandtab
"autocmd FileType plaintext set formatoptions=toanl
autocmd FileType plaintext set formatoptions=tnl
set formatlistpat=^\\s*[0-9*]\\+[\\]:.)}\\t\ ]\\s*

" e-mail settings
autocmd FileType mail set textwidth=72
autocmd FileType mail set expandtab
autocmd FileType mail match ErrorMsg '\%>72v.\+'

" web-specific settings
autocmd FileType html,xhtml,javascript set makeprg=jslint-cli\ %
autocmd FileType html,xhtml,javascript set errorformat=%f:%l:%c:%m
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Python-specific settings
autocmd FileType python set makeprg=pep8\ %
autocmd FileType python set errorformat=%f:%l:%c:\ %m
autocmd FileType python set omnifunc=pythoncomplete#Complete

" custom commands
command Ftxt set filetype=plaintext
command Fm set filetype=mail
command Fhtml set filetype=html
command Fxml set filetype=xml
command Fjs set filetype=javascript
command Fpy set filetype=python
command Fsh set filetype=sh
command Lde set spelllang=de
command Len set spelllang=en_us
command Lint exec "write | make | cope"
command Clip call CopyToClipboard()
command TwitVim source ~/.vim/plugin/twitvim.vim.disabled | match ErrorMsg '\%>140v.\+' | set wrap

" custom mappings
noremap gb gT
nmap zz :close<CR>
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TlistToggle<CR>
nmap <F5> :call StripTrailingWhitespace()<CR>

" custom abbreviations
iabbrev DBG XXX: DEBUG

" make SuperTab use omni-completion
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" custom functions

function! StripTrailingWhitespace()
	if !&binary && &filetype != 'diff'
		normal mz
		normal Hmy
		%s/\s\+$//e
		normal 'yz<Enter>
		normal `z
	endif
endfunction

function! CopyToClipboard()
	normal mz
	normal Hmy
	normal ggVG"+y
	normal 'yz<cr>
	normal `z
endfunction
