" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Enable highlight search. Note that use :noh can disable the current highlight.
set hlsearch
nnoremap <C-h> :noh<CR>

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable command history
nnoremap q: <nop>

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
" set mouse+=a

" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" set tab for 4 spaces indent
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" map jk to esc
" inoremap jk <Esc>

" auto match
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha

" pathogen
execute pathogen#infect()

" fzf
set rtp+=~/.dotfiles/.fzf
nnoremap <C-l> :FZF<CR>

" ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

nnoremap <c-s> :Ack 

" YMC
packadd YouCompleteMe
let g:ycm_python_binary_path = 'python'
set completeopt-=preview

" colorscheme
colorscheme gruvbox
set background=dark

" highlightedyank
let g:highlightedyank_highlight_duration = 250

" Enable the number of matches in seach
set shortmess-=S

" NERDTree
nnoremap <C-q> :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTreeFind<CR>

" vim-fugitive
nnoremap <C-g> :Gvdiffsplit<CR>

