let g:python_host_prog='/usr/bin/python3'

set nocompatible
filetype off

call plug#begin("~/.config/nvim/bundle")
" Plugin List
Plug 'bigeagle/molokai' " colorscheme
Plug 'Yggdroot/indentLine' " A vim plugin to display the indention levels with thin vertical lines
" Plug 'Valloric/MatchTagAlways' " A Vim plugin that always highlights the enclosing html/xml tags
Plug 'scrooloose/nerdtree' " A tree explorer plugin for vim.
Plug 'itchyny/lightline.vim' " A light and configurable statusline/tabline plugin for Vim

Plug 'majutsushi/tagbar'
Plug 'jrosiek/vim-mark'
Plug 'kien/rainbow_parentheses.vim'
" 
Plug 'mattn/emmet-vim'
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'zaiste/tmux.vim'
Plug 'lepture/vim-jinja'
Plug 'cespare/vim-toml'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'KeitaNakamura/tex-conceal.vim'
" Plug 'jiangmiao/auto-pairs'
Plug 'rhysd/vim-grammarous'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json', {'do': 'npm install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'npm install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'npm install --frozen-lockfile'}
Plug 'scrooloose/nerdcommenter'


call plug#end()

" UI
if !exists("g:vimrc_loaded")
	if has("nvim")
		set termguicolors
	endif
	let g:molokai_original = 1
	colorscheme molokai
endif " exists(...)

set so=10
set number
syntax on
filetype on
filetype plugin on
filetype indent on

set list lcs=tab:\¦\   

if has("autocmd")  " go back to where you exited
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

set completeopt=longest,menu " preview

if has('mouse')
    set mouse=a
    set selectmode=mouse,key
    set nomousehide
endif
" 
set autoindent
set modeline
set cursorline
set cursorcolumn

set shiftwidth=4
set tabstop=4
set softtabstop=4

set showmatch
set matchtime=0
set nobackup
set nowritebackup
set directory=/tmp/.swapfiles//

if has('nvim')
   set ttimeout
   set ttimeoutlen=0
endif
" 
"在insert模式下能用删除键进行删除
set backspace=indent,eol,start

set fenc=utf-8
set fencs=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc" -jp
set enc=utf-8                                       " 
                                                    " 
"按缩进或手动折叠                                   " 
augroup vimrc                                       " 
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
set foldcolumn=0 "设置折叠区域的宽度
set foldlevelstart=200
set foldlevel=200  " disable auto folding
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <Space> zf

set smartcase
set ignorecase
set nohlsearch
set incsearch
set autochdir

vmap j gj
vmap k gk
nmap j gj
nmap k gk
" 
nmap T :tabnew<cr>

au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap  <buffer>  {<CR> {<CR>}<Esc>O

au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()

function ScriptHeader()
    if &filetype == 'python'
        let header = "#!/usr/bin/env python3"
        let cfg = "# vim: ts=4 sw=4 sts=4 expandtab"
    elseif &filetype == 'sh'
        let header = "#!/bin/bash"
    endif
    let line = getline(1)
    if line == header
        return
    endif
    normal m'
    call append(0,header)
    if &filetype == 'python'
        call append(2, cfg)
    endif
    normal ''
endfunction
" 
" --- Plugin Configs ---------
let g:tagbar_width = 30
nmap tb :TagbarToggle<cr>

let g:localvimrc_ask=0
let g:localvimrc_sandbox=0

autocmd Filetype json let g:indentLine_enabled = 0
let g:vim_json_syntax_conceal = 0
let g:indentLine_noConcealCursor=""
let g:indentLine_setConceal = 0
let g:indentLine_setColors = 0

" " - Lightline -------------------
set noshowmode
set laststatus=2
let g:lightline = {
	\   'active': {
	\     'left':[ [ 'mode', 'paste' ],
	\              [ 'cocstatus', 'readonly', 'filename', 'modified' ]
	\     ]
	\   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
	\ 'component_function': {
	\   'cocstatus': 'coc#status',
	\ },
	\ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
	\}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
	\}
" 
" " ----------------------------
" 
" Completion and echodoc
set shortmess+=c
set updatetime=300
set signcolumn=yes
set completeopt=noinsert,menuone,noselect

let g:coc_auto_copen=1

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <leader><space> coc#refresh()

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"


"nmap <silent> <leader>g <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> <leader>d <Plug>(coc-declaration)
nmap <silent> <leader>g <Plug>(coc-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>u <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)

nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <c-p> :CocList<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
autocmd CursorHold * silent call CocActionAsync('highlight')

highlight CocErrorSign ctermfg=215 guifg=#ffaf5f
highlight default CocHighlightText guibg=#767676 ctermbg=243 cterm=underline

" ----------------------------

" - NerdTree -----------------
nmap nt :NERDTreeToggle<cr>
let NERDTreeShowBookmarks=0
let NERDTreeMouseMode=2

let NERDTreeWinSize=25
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeMinimalUI=0
let NERDTreeDirArrows=1
" ----------------------------
" 
" - python and jedi ----------
let python_highlight_all = 1
autocmd BufWritePre *.py :%s/\s\+$//e
au FileType python setlocal cc=80
" ----------------------------

" - rainbow_parentheses ------
let g:rbpt_colorpairs = [
	\ [158, '#00ceb3'],
	\ [081, '#00a3ff'],
	\ [214, '#ff8d00'],
	\ [123, '#3fffc9'],
	\ [045, '#29b9ec'],
	\ [190, '#bfec29'],
	\ [208, '#ffad00'],
	\ [117, '#48bde0'],
	\ ]

let g:rbpt_max = 8
let g:rbpt_loadcmd_toggle = 0
" 
" - vimtex ------
if has('unix')
if has('mac')
let g:vimtex_view_method = "skim"
let g:vimtex_view_general_viewer
\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
        " This adds a callback hook that updates Skim after compilation
let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
if !a:status | return | endif
let l:out = b:vimtex.out()
let l:tex = expand('%:p')
let l:cmd = [g:vimtex_view_general_viewer, '-r']
if !empty(system('pgrep Skim'))
call extend(l:cmd, ['-g'])
endif
if has('nvim')
call jobstart(l:cmd + [line('.'), l:out, l:tex])
elseif has('job')
call job_start(l:cmd + [line('.'), l:out, l:tex])
else
call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
endif
endfunction
else
let g:latex_view_general_viewer = "zathura"
let g:vimtex_view_method = "zathura"
endif
elseif has('win32')
endif
let g:tex_flavor = "latex"
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode = 2
if has('nvim')
let g:vimtex_compiler_progname = 'nvr'
endif

let g:vimtex_quickfix_latexlog = {
\ 'default' : 1,
\ 'fix_paths' : 0,
\ 'general' : 1,
\ 'references' : 1,
\ 'overfull' : 1,
\ 'underfull' : 1,
\ 'font' : 1,
\ 'packages' : {
\   'default' : 1,
\   'natbib' : 1,
\   'biblatex' : 1,
\   'babel' : 1,
\   'hyperref' : 1,
\   'scrreprt' : 1,
\   'fixltx2e' : 1,
\   'titlesec' : 1,
\ },
\}

let g:tex_conceal= 'abdmg'
let g:polyglot_disabled = ['latex']
set conceallevel=1
set concealcursor="inc"
hi Conceal guifg=cyan
hi clear Special
hi Special guifg=cyan


setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" 
" 
" 
" - ultisnips ------
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetsDir = expand('~/.config/nvim/bundle/vim-snippets/UltiSnips')
let g:UltiSnipsEditSplit = "horizontal"

" ---grammarous
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
endfunction

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax c,cpp,go,h,java,python,javascript,scala,coffee RainbowParenthesesLoadSquare
au Syntax c,cpp,go,h,java,python,javascript,scala,coffee,scss  RainbowParenthesesLoadBraces
" ----------------------------

" Load local config if exists
if filereadable(expand("~/.config/nvim/local.vim"))
	source ~/.vim/config/local.vim
endif

" cmap W w !sudo tee > /dev/null %
:command WQ wq
:command Wq wq
:command W w
:command Q q
