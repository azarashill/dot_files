"-----------------------------------------------------------------------------------"
" Mappings                                                                          |
"-----------------------------------------------------------------------------------"
" コマンド        | ノーマル | 挿入 | コマンドライン | ビジュアル | 選択 | 演算待ち |
" map  / noremap  |    @     |  -   |       -        |     @      |  @   |    @     |
" nmap / nnoremap |    @     |  -   |       -        |     -      |  -   |    -     |
" vmap / vnoremap |    -     |  -   |       -        |     @      |  @   |    -     |
" omap / onoremap |    -     |  -   |       -        |     -      |  -   |    @     |
" xmap / xnoremap |    -     |  -   |       -        |     @      |  -   |    -     |
" smap / snoremap |    -     |  -   |       -        |     -      |  @   |    -     |
" map! / noremap! |    -     |  @   |       @        |     -      |  -   |    -     |
" imap / inoremap |    -     |  @   |       -        |     -      |  -   |    -     |
" cmap / cnoremap |    -     |  -   |       @        |     -      |  -   |    -     |
"-----------------------------------------------------------------------------------"
"
"
"
"
"dein

if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

 call dein#begin(expand('~/.vim/dein'))
"
"call dein#add('Shougo/dein.vim')
"call dein#add('Shougo/unite.vim')
"call dein#add('tomasr/Molokai')
"call dein#add('Shougo/vimproc.vim', {'build': 'make'})
"
"call dein#add('Shougo/neocomplete.vim')
"call dein#add('Shougo/neomru.vim')
"call dein#add('Shougo/neosnippet')
"call dein#add('Shougo/neosnippet')

" (中略)


"call dein#begin(s:dein_dir)
let g:rc_dir = expand('~/.vim/rc')
let s:toml = g:rc_dir . '/dein.toml'
let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

call dein#load_toml(s:toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml,{'lazy': 1})

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim' , {'build': 'make'})
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/neosnippet')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/unite-outline')
call dein#add('osyo-manga/vim-brightest')
call dein#add('junegunn/vim-easy-align')
call dein#add('mattn/emmet-vim')
call dein#add('rking/ag.vim')
call dein#add('kana/vim-submode')
call dein#add('altercation/vim-colors-solarized')
call dein#end()
call dein#save_state()


" dein#end()

"unite

nnoremap [unite] <Nop>
noremap [unite]b :Unite buffer<CR>
nmap <space> [unite]
xmap <space> [unite]
nnoremap [unite]u :Unite -buffer-name=files buffer file_mru bookmark file<CR>
"nnoremap [unite]r :Unite file_rec/async:!<CR>

"nnoremap [unite]R :Unite -buffer-name=register register<CR>
 nnoremap [unite]y :Unite history/yank<CR>
 nnoremap [unite]o :Unite outline<CR>

 " insert modeで開始
 let g:unite_enable_start_insert = 1
 " 大文字小文字を区別しない
 let g:unite_enable_ignore_case = 1
 let g:unite_enable_smart_case = 1

 " grep検索
 nnoremap <silent> [unite]g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

 " カーソル位置の単語をgrep検索
 nnoremap <silent> [unite]cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

 " grep検索結果の再呼出
 nnoremap <silent> [unite]r  :<C-u>UniteResume search-buffer<CR>

 " unite grep に ag(The Silver Searcher) を使う
 if executable('ag')
   let g:unite_source_grep_command = 'ag'
   let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
   let g:unite_source_grep_recursive_opt = ''
 endif


 function! g:GetVisualWord() abort
   let word = getline("'<")[getpos("'<")[2] - 1:getpos("'>")[2] - 1]
   return word
 endfunction

 function! g:GetVisualWordEscape() abort
   let word = substitute(GetVisualWord(), '\\', '\\\\', 'g')
   let word = substitute(word, '[.?*+^$|()[\]]', '\\\0', 'g')
   return word
 endfunction

 xnoremap <silent> [unite]g :Unite grep:::`GetVisualWordEscape()`<CR>


 "vimfiler
nnoremap <silent> <space>f :VimFiler -split -simple -explorer -winwidth=30 -toggle  -find<CR>


".vimrc編集ショートカット
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>sv :<C-u>source $MYVIMRC<CR>

syntax enable

set number
set ruler
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
set incsearch
set hlsearch
set nowrap
set showmatch
set whichwrap=h,l
set nowrapscan
set ignorecase
set smartcase
set wrapscan
set hidden
set history=2000
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set helplang=en
set t_Co=256
set autoread
set noswapfile
set nobackup

set showmode
set title
set showcmd
set laststatus=2
set cursorline
set wrap
set display=uhex
set nf=hex
set splitbelow
set splitright

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
set backspace=start,eol,indent

set background=dark
colorscheme desert

nnoremap ;  :
nnoremap :  ;
vnoremap ;  :
vnoremap :  ;
nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j

nnoremap * *zz
nnoremap n nzz
nnoremap N Nzz
inoremap jj <ESC>

function! s:search_forward_p()
  return exists('v:searchforward') ? v:searchforward : 1
endfunction

nnoremap <silent> <ESC><ESC> :noh<cr>

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=underline ctermbg=red guibg=red
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", '\ +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", '\ +$')

" 行頭のTAB文字を可視化
highlight TabString ctermbg=red guibg=red
au BufWinEnter * let w:m2 = matchadd("TabString", '^\t+')
au WinEnter * let w:m2 = matchadd("TabString", '^\t+')

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

" ファイル読み込み時の文字コード検索順
set termencoding=utf-8
set enc=utf-8
set fencs=utf-8,sjis,utf-16,ucs-bom,euc-jp,cp932,iso-2022-jp,ucs-2le,ucs-2,utf-8
set ffs=unix,mac,dos
"set clipboard+=unnamed
set clipboard+=autoselect

if $TMUX == ''
  set clipboard+=unnamed
endif



"set clipboard+=unnamed
" vimmer養成ギプス
"map <Up> <Nop>
"map <Down> <Nop>
"map <Left> <Nop>
"map <Right> <Nop>
"inoremap <Up> <Nop>
"inoremap <Down> <Nop>
"inoremap <Left> <Nop>
"inoremap <Right> <Nop>

filetype plugin indent on
