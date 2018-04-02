set nocompatible
syntax on

" 256色。ターミナルの$TERMを適切に設定すれば不要らしいが一応やっておく
set term=xterm-256color
" デフォルトのエンコーディング
set encoding=utf-8
" 一時ファイルを作って欲しくない
set noundofile
set nobackup
set noswapfile

set ruler
set number

" タブをスペースに
set expandtab
" 
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

" 閉じカッコ入力時に一瞬強調する
set showmatch

" 検索時の大文字小文字の区別
set ignorecase
set smartcase

" 検索の最後から頭に戻らない
set nowrapscan

" インクリメンタルサーチしない
set noincsearch

" yank -> クリップボードへのコピー
set clipboard=unnamed,autoselect

set backspace=indent,eol,start
set autoindent
set smartindent
set visualbell
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" 表示行で移動
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/wombat256.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim', {'on': 'VimFilerExplorer'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'vim-syntastic/syntastic'
Plug 'zig-lang/zig.vim'
Plug 'Valloric/YouCompleteMe'
call plug#end()

" recommended settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" neco-ghcのオムニ補完用設定
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" YouCompleteMeの設定 (ghc-mod連携)
let g:ycm_semantic_triggers = {'haskell' : ['.']}
" Haskell用のsyntastic設定
let g:syntastic_haskell_checkers = ["hdevtools", "hlint"]

" カラースキーム
try
  colorscheme wombat256mod
catch
endtry

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

let g:syntastic_ocaml_checkers = ['merlin']

filetype plugin indent on
