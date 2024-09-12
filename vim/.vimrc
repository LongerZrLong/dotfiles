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

" helper function definition
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" leader key
nnoremap <SPACE> <Nop>
let mapleader=' '

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

" unbind useless
noremap Q <Nop>
noremap K <Nop>

" buffer
set hidden " By default, Vim doesn't let you hide a buffer that has unsaved changes.
nnoremap gn :bnext<cr>
nnoremap gp :bprevious<cr>
nnoremap gd :bdelete<cr>
nnoremap <Leader>; <C-^>

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
nnoremap <Leader>0 :tablast<CR>

nnoremap <Leader>h gT<CR>
nnoremap <Leader>l gt<CR>

au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <Leader><Tab> :exe 'tabn '.g:lasttab<CR>

" window
nnoremap <C-w>; <C-w>p

" search
set ignorecase " case-insensitive search when all characters lowercase
set smartcase " case-sensitive if containing any capital letters

set incsearch
set hlsearch

nnoremap <Leader>r :noh<CR>
nnoremap <Leader>s :let @/='\C\<'.expand('<cword>').'\>'<Bar>set hlsearch<CR>
vnoremap <Leader>s y:let @/='\C\V'.escape(@", '/\')<Bar>set hlsearch<CR>
vnoremap / y:let @/='\C\V'.escape(@", '/\')<Bar>set hlsearch<CR>

" recording
noremap q <Nop>
noremap <C-r> :if reg_recording() == '' <Bar> exe 'normal! qq' <Bar> else <Bar> exe 'normal! q' <Bar> let @q=strpart(@q, 0, len(@q) - 2) <Bar> endif <CR>

" Do the following mapping at start up b/c <C-y> somehow
" gets overwritten if mapped in the .vimrc
autocmd VimEnter * nnoremap <C-y> @q

vnoremap <C-y> :norm! @q<CR>

" Disable audible bell.
set noerrorbells visualbell t_vb=

" Toggle mouse support. Useful for scrolling.
noremap ` :if &mouse == 'a' <Bar> set mouse= <Bar> else <Bar> set mouse=a <Bar> endif<CR>

" join
nnoremap <Leader>j J

" scroll
set scrolloff=5 " Show a few lines of context around the cursor.
nnoremap J 5<C-e>
nnoremap K 5<C-y>

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

" copy paste
if has('clipboard')
  set clipboard=""    " disable auto yank into * register when exiting visual mode
  noremap <Leader>Y "+Y
  noremap <Leader>y "+y
  nnoremap <C-p> :set paste<CR>"+gp:set nopaste<CR>
  inoremap <C-p> <C-o>:set paste<CR><C-o>"+gP<C-o>:set nopaste<CR>
else
  echo "Install vim-gtk or other similar packages for the clipboard feature."
endif

" cursor movement
noremap <C-h> ^
noremap <C-l> $
noremap <C-j> 5j
noremap <C-k> 5k
noremap <C-s> %

" marks
nnoremap <Leader>m :marks<CR>

" fold
call SetupCommandAlias('fmm', 'setlocal foldmethod=manual')
call SetupCommandAlias('fmi', 'setlocal foldmethod=indent')
call SetupCommandAlias('fms', 'setlocal foldmethod=syntax')

" pathogen
execute pathogen#infect()

" fzf
set rtp+=~/.dotfiles/.fzf
nnoremap <C-n> :FZF<CR>

command! -bang -nargs=* Agc call fzf#vim#ag(<q-args>, '--literal --case-sensitive', fzf#vim#with_preview(), <bang>0)
nnoremap <Leader>a :Agc <C-r><C-w><CR>
vnoremap <Leader>a y:Agc <C-r>=@"<CR><CR>
nnoremap <Leader>A :Ag 

" Do to following mapping at start up b/c <C-e> somehow
" gets overwritten if mapped in vimrc
autocmd VimEnter * nnoremap <C-e> :Buffers<CR>

" YouCompleteMe
let g:ycm_python_binary_path = 'python'

set completeopt-=preview
let g:ycm_auto_hover = '' " If set to empty string, popup is not auto displayed
nmap <Leader>p <plug>(YCMHover)

nnoremap <C-g> :YcmCompleter GoTo<CR>

let g:ycm_key_list_select_completion = ['<Tab>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']

" colorscheme
colorscheme gruvbox
set background=dark

" highlightedyank
let g:highlightedyank_highlight_duration = 250

" NERDTree
nnoremap <C-q> :NERDTreeFocus<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" vim-fugitive
nnoremap <Leader>c :Gvdiffsplit<CR>
nnoremap <Leader>b :Git blame<CR>
nnoremap <Leader>u :Git restore --staged %<CR>
nnoremap <Leader>U :Git add %<CR>
nnoremap <Leader>o :Gread<CR>
nnoremap <Leader>O :Gread HEAD:%<CR>

nnoremap <UP>   [c
nnoremap <DOWN> ]c

call SetupCommandAlias('Gd' , 'Git diff')
call SetupCommandAlias('Gds', 'Git diff --staged')
call SetupCommandAlias('Gau', 'Git add --update')
call SetupCommandAlias('Grs', 'Git restore')

