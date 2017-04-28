set nocompatible

" Vundle plugin management
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'Gundo'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vimwiki/vimwiki'
call vundle#end()

" Vimwiki configuration
let g:vimwiki_list = [{
		\ 'path': '~/Documents/vwiki/',
		\ 'syntax': 'markdown',
		\ 'ext': '.md'}]

set nobackup
set directory=/tmp/
set tabpagemax=50

set backspace=indent,eol,start " allow backspacing over everything in insert mode

"set ruler
set number
syntax on
filetype plugin on

set scrolloff=3
"set confirm
set wildmode=list:longest,full
set autoindent

set hlsearch
set incsearch

set noexpandtab
set tabstop=4
set shiftwidth=4
set smarttab
"set spell spelllang=en_us
"set omnifunc=syntaxcomplete#Complete

" appearance
if has("gui_running")
	set guifont=Menlo:h14
	colorscheme solarized
	set background=dark
endif
" distinguish search highlighting from markers like "TODO","XXX" etc.
highlight Search cterm=bold ctermfg=gray ctermbg=blue
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
set colorcolumn=+1 " requires Vim 7.3
highlight ColorColumn ctermbg=DarkGray guibg=DarkGray

" syntax checking
let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_mode_map = { "mode": "passive" }
highlight SignColumn ctermbg=Black

" retrieve remote files' source (rather than rendered markup)
" (cf. http://vimperator.org/trac/ticket/25)
let g:netrw_http_cmd = "wget -q -O"

" custom commands
command SaneTabs set noexpandtab | set tabstop=4 | set shiftwidth=4
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
command Lint exec "write | SyntasticCheck"
command Clip call CopyToClipboard()
command -range=% -nargs=0 Tab2Space execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', ".&ts."), 'g')"
command -range=% -nargs=0 Space2Tab execute "<line1>,<line2>s/^\\( \\{".&ts."\\}\\)\\+/\\=substitute(submatch(0), ' \\{".&ts."\\}', '\\t', 'g')"
" Markdown link references (argument: [i|r])
command -nargs=1 Formd % !formd -<args>
command PathogenActivate runtime bundle/vim-pathogen/autoload/pathogen.vim |
	\call pathogen#infect()

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
nmap <Leader>h :GundoToggle<CR>
" temporarily activate spell checking
nmap <Leader>c :Lde\|exec "normal z="\|set nospell<CR>
" ctrlp: open tab by default
let g:ctrlp_prompt_mappings = {
	\ 'AcceptSelection("e")': ["<c-t>"],
	\ 'AcceptSelection("t")': ["<cr>"]
\ }

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

" adapted from http://stackoverflow.com/a/26140622

function! GetVisual()
	try
		let v_save = @v
		normal! gv"vy
		return @v
	finally
		let @v = v_save
	endtry
endfunction

fun! CenterMe()
	let v = GetVisual()
	let lre = '^\zs\s*\ze\S'
	let rre = '\s*$'
	let sp= matchstr(v, lre)
	let sp .= matchstr(v, rre)
	let ln=len(sp)
	let v = substitute(v, lre, sp[:ln/2-1], '')
	let v = substitute(v, rre, sp[ln/2:], '')
	let ve_save = &virtualedit
	let v_save = @v
	let &virtualedit = 'all'
	call setreg('v', v, visualmode())
	normal! gvx"vP
	let @v = v_save
	let &virtualedit = ve_save
endf

function! ComponentLayout(directory)
	exec 'tabnew ' . a:directory . '/element.js'
	exec 'vsplit ' . a:directory . '/template.jsx'
	exec 'split ' . a:directory . '/index.js'
	vertical resize -10
endfunction
