" Comments in Vimscript start with a `"`.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality.
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Enable the number of matches in seach
set shortmess-=S

" leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" Line numbers
set number
set relativenumber
nnoremap <Leader>n :set nu! rnu!<CR>

" Always show the status line at the bottom, even if only one window is open
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" buffer
set hidden " By default, Vim doesn't let you hide a buffer that has unsaved changes.
nnoremap gn :bnext<cr>
nnoremap gp :bprevious<cr>
nnoremap gd :bdelete<cr>
nnoremap <Leader>; <C-^>
nnoremap <Leader>b :buffers<CR>

" tab
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt

nnoremap <Leader>h gT<CR>
nnoremap <Leader>l gt<CR>

au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <Leader><Tab> :exe "tabn ".g:lasttab<CR>

" window
nnoremap <C-w>; <C-w>p

" search
set ignorecase " case-insensitive search when all characters lowercase
set smartcase " case-sensitive if containing any capital letters

set incsearch
set hlsearch

nnoremap <C-r> :noh<CR>
nnoremap <Leader>s :let @/='\<'.expand('<cword>').'\>'<Bar>set hlsearch<CR>
vnoremap / y:let @/='\V'.escape(@", '/\')<Bar>set hlsearch<CR>

" Unbind some useless/annoying default key bindings.
nmap Q <Nop>
nnoremap q: <nop>
nmap K <Nop>

" Disable audible bell.
set noerrorbells visualbell t_vb=

" Enable mouse support. Useful for scrolling.
" set mouse+=a

" Show a few lines of context around the cursor.
set scrolloff=5

" redo
nnoremap U <C-r>

" indent
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" write and exit
nnoremap <Leader>q :q<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>z :wq<cr>
nnoremap <Leader>x :q!<cr>

" paste mode
nnoremap <Leader>p :set paste!<CR>

" recording
noremap Q q
noremap q <Nop>

" cursor movement
noremap <C-h> ^
noremap <C-l> $
noremap <C-j> 5j
noremap <C-k> 5k
noremap <C-s> %

" auto match
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha

" marks
nnoremap <Leader>m :marks<CR>

" pathogen
execute pathogen#infect()

" fzf
set rtp+=~/.dotfiles/.fzf
nnoremap <C-n> :FZF<CR>

" ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

nnoremap <Leader>a :Ack! 

" YouCompleteMe
packadd YouCompleteMe
let g:ycm_python_binary_path = 'python'

set completeopt-=preview
let g:ycm_auto_hover = '' " If set to empty string, popup is not auto displayed
nmap <C-p> <plug>(YCMHover)

nnoremap <C-g> :YcmCompleter GoTo<CR>

" colorscheme
colorscheme gruvbox
set background=dark

" highlightedyank
let g:highlightedyank_highlight_duration = 250

" NERDTree
nnoremap <C-q> :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" vim-fugitive
nnoremap <Leader>c :Gvdiffsplit<CR>
nnoremap <UP>   [c
nnoremap <DOWN> ]c

