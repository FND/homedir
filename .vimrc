set nocompatible " use Vim rather than Vi settings

set backspace=indent,eol,start " allow backspacing over everything in insert mode

set confirm
set nobackup

set nowrap
set ruler
set number

set hlsearch
syntax on

set spell spelllang=en_us
autocmd FileType html,xhtml,css,javascript,python,sh set nospell

set incsearch
set autoindent
set scrolloff=3
set wildmode=list:longest,full

set noexpandtab
set tabstop=4
set shiftwidth=4
set smarttab

set directory=/tmp/

filetype plugin on
set omnifunc=syntaxcomplete#Complete

set tabpagemax=50

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
set textwidth=80
set colorcolumn=+0 " requires Vim 7.3
highlight ColorColumn ctermbg=0

" strip trailing whitespace
"autocmd BufWritePre,FileWritePre * call StripTrailingWhitespace()

" retrieve remote files' source (rather than rendered markup)
" (cf. http://vimperator.org/trac/ticket/25)
let g:netrw_http_cmd = "wget -q -O"

" plain-text settings
autocmd FileType text set expandtab
autocmd FileType plaintext set expandtab
"autocmd FileType plaintext set formatoptions=toanl
autocmd FileType plaintext set formatoptions=tnl
set formatlistpat=^\\s*[0-9*]\\+[\\]:.)}\\t\ ]\\s*

" Markdown settings
autocmd FileType mkd set makeprg=markdown\ %

" e-mail settings
autocmd FileType mail set expandtab
autocmd FileType mail set textwidth=72
autocmd FileType mail iabbrev Gruss Gruß

" Git settings
autocmd FileType gitcommit set textwidth=72

" web-specific settings
autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd FileType html,xhtml,css,javascript set makeprg=jslint-reporter\ %
autocmd FileType html,xhtml,css,javascript set errorformat=%f:%l:%c:%m
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html syn keyword htmlTagName contained section header footer nav aside hgroup article figure
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css syn keyword cssTagName section header footer nav aside hgroup article figure
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript set noexpandtab
autocmd FileType javascript set tabstop=4
autocmd FileType javascript iabbrev fn function() {<CR>}
autocmd FileType javascript iabbrev log console.log();<Left><Left>
autocmd FileType javascript iabbrev JSX try {<CR>} catch(exc) { console.log("error", exc); }<Up>

" Python-specific settings
autocmd FileType python set makeprg=pep8\ %
autocmd FileType python set errorformat=%f:%l:%c:\ %m
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set expandtab
autocmd FileType python set tabstop=4

" Ruby-specific settings
autocmd FileType ruby,eruby set expandtab
autocmd FileType ruby,eruby set tabstop=2
autocmd FileType ruby,eruby set shiftwidth=2

" custom commands
command Ftxt set filetype=plaintext
command Fm set filetype=mail
command Fmkd set filetype=mkd
command Fhtml set filetype=html
command Fxml set filetype=xml
command Fjs set filetype=javascript
command Fpy set filetype=python
command Frb set filetype=ruby
command Fsh set filetype=sh
command Len set spell | set spelllang=en_us
command Lde set spell | set spelllang=de |
	\iabbrev ae ä| iabbrev oe ö| iabbrev ue ü|
	\iabbrev sz ß
command Qnoise set nospell wrap | match
command Lint exec "write | make | cope"
command Clip call CopyToClipboard()
command -range=% -nargs=0 Tab2Space execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', ".&ts."), 'g')"
command -range=% -nargs=0 Space2Tab execute "<line1>,<line2>s/^\\( \\{".&ts."\\}\\)\\+/\\=substitute(submatch(0), ' \\{".&ts."\\}', '\\t', 'g')"
" Markdown link references (argument: [i|r])
command -nargs=1 Formd % !formd -<args>

" on-demand plugins

function! LoadPlugin(name)
	let l:pluginpath = globpath(&rtp, "dplugins/" . a:name . ".vim")
	exec "source " . l:pluginpath
endfunction

command Rails call LoadPlugin("rails") | call LoadPlugin("autoload/rails") |
	\tabdo edit
command DrawIt call LoadPlugin("cecutil") | call LoadPlugin("DrawItPlugin") |
	\call LoadPlugin("autoload/DrawIt")
command TwitVim let twitvim_enable_python = 1 | set textwidth=140 |
	\set wrap | call LoadPlugin("twitvim")

" custom mappings
let mapleader = ","
noremap gb gT
noremap W 1z=
noremap <c-Y> "+y
noremap <c-P> "+p
nmap zz :close<CR>
nmap <F5> :call StripTrailingWhitespace()<CR>
nmap <Leader>s :nohlsearch<CR>
nmap <Leader>l :Lint<CR>
nmap <Leader>e :NERDTreeFind<CR>
nmap <Leader>q :Qnoise<CR>

" custom abbreviations
iabbrev DBG XXX: DEBUG

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
