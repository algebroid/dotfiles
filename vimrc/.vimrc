set nocompatible
syntax on

" 256色。ターミナルの$TERMを適切に設定すれば不要らしいが一応やっておく
set term=xterm-256color
" デフォルトのエンコーディング
set encoding=utf-8
" 一時ファイルを作って欲しくない
set noundofile
set number
set nobackup

set ruler

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
set visualbell
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/wombat256.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim', {'on': 'VimFiler'}
call plug#end()

try
  colorscheme wombat256mod
catch
endtry
