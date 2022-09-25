"----------------------------------------
"=> Behind the scenes
"----------------------------------------


"run specifc commands with specifc filetypes
filetype plugin on
filetype indent on

"read file outside changes
set autoread

"set leader key
let mapleader = ","

"save the current file as sudo
command! Su execute 'w !sudo tee % > /dev/null' <bar> edit!

"do not make a swapfile for avoiding some problems
set noswapfile
set nobackup nowb "just use git

"improve speed when hitting <Esc>
set ttimeout		" time out for key codes
set ttimeoutlen=100

"----------------------------------------
"=> UI and Visual Stuff
"----------------------------------------


"tabing
set tabstop=4 softtabstop=4 "tab= 4spaces
set expandtab "use spaces instead of tabs
set smarttab  "well you guest it be smart when tabbing
set shiftwidth=4
set nowrap
set smartindent autoindent "indentation

"for better scrolling or j/k Movement
set scrolloff=8

"better command <TAB> auto completion
set wildmenu

"show line,coulmn File% at the right down side
set ruler

"better search
set ignorecase smartcase "search smart not hardly
set nohlsearch incsearch "do not highlight seaches

"better performance when using macros
set lazyredraw

"show the matching case e.x (){}[]
"very helpful when doing a function
set showmatch
set mat=2 "bleanking seconds

"cool number indecator on the left
set number relativenumber

"syntax highlighter
syntax enable

"encoding
set encoding=utf8

"----------------------------------------
"=> PLUGINS
"----------------------------------------


call plug#begin()

Plug 'itchyny/lightline.vim' "a lite status bar
Plug 'vifm/vifm.vim'
Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " Markdown Preview
Plug 'vimwiki/vimwiki'
Plug 'dracula/vim', { 'as': 'dracula' } "dracula theme

call plug#end()

"plugins configure

"liteline
set noshowmode
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

"vifm
map <leader>v :Vifm<cr>

"vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
"dracula
colorscheme dracula
