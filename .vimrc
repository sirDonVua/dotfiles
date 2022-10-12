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


" => installing vim-plug

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))

  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

"

call plug#begin()

Plug 'mhinz/vim-startify' "startpage
Plug 'itchyny/lightline.vim' "a lite status bar
Plug 'vifm/vifm.vim' "vi file manger
Plug 'jreybert/vimagit' "git client
Plug 'vimwiki/vimwiki'
Plug 'christoomey/vim-system-copy' "access to system clipboard
Plug 'dracula/vim', { 'as': 'dracula' } "dracula theme

call plug#end()

"=> plugins configure

"startify
map <leader>h :Startify<cr>

"liteline
set noshowmode
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

"vifm
map <leader>v :Vifm<cr>

"vimagit
map <leader>m :MagitOnly<cr>

"vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
"dracula
colorscheme dracula
let &t_ut='' "fixing background disapperas when scrolling in kitty terminal
"hi Normal guibg=NONE ctermbg=NONE "uses your terminal background instead
