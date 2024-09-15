" Comments in Vimscript start with a `"`.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality.
set nocompatible

" Disable audible bell.
set noerrorbells visualbell t_vb=

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Enable the number of matches in search
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
nnoremap <Leader>n :set nu! rnu!<Cr>

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
nnoremap <Leader>k :bdelete<Cr>
nnoremap <Leader>; <C-^>

" tab
nnoremap <Leader>t :tabnew<Cr>
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt
nnoremap <Leader>0 :tablast<Cr>

nnoremap <Leader>h gT<Cr>
nnoremap <Leader>l gt<Cr>

au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <Leader><Tab> :exe 'tabn '.g:lasttab<Cr>

" window
nnoremap <C-w>; <C-w>p

" search
set ignorecase " case-insensitive search when all characters lowercase
set smartcase " case-sensitive if containing any capital letters

set incsearch
set hlsearch

nnoremap <Leader>r :noh<Cr>
nnoremap <Leader>s :let @/='\C\<'.expand('<cword>').'\>'<Bar>set hlsearch<Cr>
vnoremap <Leader>s y:let @/='\C\V'.escape(@", '/\')<Bar>set hlsearch<Cr>
vnoremap / y:let @/='\C\V'.escape(@", '/\')<Bar>set hlsearch<Cr>

" recording
noremap q <Nop>
noremap <C-r> :if reg_recording() == '' <Bar> exe 'normal! qq' <Bar> else <Bar> exe 'normal! q' <Bar> let @q=strpart(@q, 0, len(@q) - 1) <Bar> endif <Cr>

" Do the following mapping at start up b/c <C-y> somehow
" gets overwritten if mapped in the .vimrc
autocmd VimEnter * nnoremap <C-y> @q

vnoremap <C-y> :normal! @q<Cr>

" Toggle mouse support. Useful for scrolling.
noremap ` :if &mouse == 'a' <Bar> set mouse= <Bar> else <Bar> set mouse=a <Bar> endif <Cr>

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
noremap <Leader>i =

" write and exit
nnoremap <Leader>q :q<Cr>
nnoremap <Leader>Q :qa!<Cr>
nnoremap <Leader>w :w<Cr>
nnoremap <Leader>W :wa<Cr>
nnoremap <Leader>z :wq<Cr>
nnoremap <Leader>Z :wqa<Cr>
nnoremap <Leader>x :q!<Cr>

" copy paste
if has('clipboard')
  set clipboard=""    " disable auto yank into * register when exiting visual mode
  noremap <Leader>Y "+Y
  noremap <Leader>y "+y

  nnoremap <Leader>p "+gp
  nnoremap <Leader>P "+gP
  vnoremap <Leader>p "+gp
  vnoremap <Leader>P "+gP
else
  echo "Install vim-gtk or other similar packages for the clipboard feature."
endif

noremap p "0p
noremap P "0P
inoremap <C-p> <C-r>0

vnoremap x "0ygvd

" cursor movement
noremap <C-h> ^
noremap <C-l> $
noremap <C-j> 5j
noremap <C-k> 5k
noremap <C-s> %

" marks
nnoremap <Leader>m :marks<Cr>

" fold
call SetupCommandAlias('fm', 'setlocal foldmethod=manual')
call SetupCommandAlias('fi', 'setlocal foldmethod=indent')
call SetupCommandAlias('fs', 'setlocal foldmethod=syntax')

nnoremap gm :setlocal foldmethod=manual<Cr>
nnoremap gi :setlocal foldmethod=indent<Cr>
nnoremap gs :setlocal foldmethod=syntax<Cr>

" pathogen
execute pathogen#infect()

" colorscheme
colorscheme gruvbox
set background=dark

" highlightedyank
let g:highlightedyank_highlight_duration = 250

" NERDTree
nnoremap <C-q> :NERDTreeFocus<Cr>
nnoremap <Leader>f :NERDTreeFind<Cr>

" easymotion
map <Leader><Leader> :noh<Cr> <Plug>(easymotion-prefix)

" fzf
set rtp+=~/.dotfiles/.fzf
nnoremap <C-n> :FZF<Cr>

command! -bang -nargs=* Agc call fzf#vim#ag(<q-args>, '--literal --case-sensitive', fzf#vim#with_preview(), <bang>0)
nnoremap <Leader>a :Agc <C-r><C-w><Cr>
vnoremap <Leader>a y:Agc <C-r>=@"<Cr><Cr>
nnoremap <Leader>A :Ag 

" Do to following mapping at start up b/c <C-e> somehow
" gets overwritten if mapped in vimrc
autocmd VimEnter * nnoremap <C-e> :Buffers<Cr>

" YouCompleteMe
let g:ycm_python_binary_path = 'python'

set completeopt-=preview
let g:ycm_auto_hover = '' " If set to empty string, popup is not auto displayed
nmap <C-p> <plug>(YCMHover)

nnoremap <C-g> :YcmCompleter GoTo<Cr>

let g:ycm_key_list_select_completion = ['<Tab>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']

call SetupCommandAlias('yfx', 'YcmCompleter FixIt')
call SetupCommandAlias('yfm', 'YcmCompleter FixIt')
call SetupCommandAlias('yrr', 'YcmCompleter RefactorRename')

" vim-fugitive
nnoremap <Leader>g :Git<Cr>
nnoremap <Leader>c :Gvdiffsplit<Cr>
nnoremap <Leader>C :Gvdiffsplit HEAD<Cr>
nnoremap <Leader>b :Git blame<Cr>
nnoremap <Leader>u :Git restore --staged %<Cr>
nnoremap <Leader>U :Git add %<Cr>
nnoremap <Leader>o :Gread<Cr>
nnoremap <Leader>O :Gread HEAD:%<Cr>

nnoremap <UP>   [c
nnoremap <DOWN> ]c

call SetupCommandAlias('Gv' , 'Gvdiffsplit')
call SetupCommandAlias('Gd' , 'Git diff')
call SetupCommandAlias('Gds', 'Git diff --staged')
call SetupCommandAlias('Gau', 'Git add --update')
call SetupCommandAlias('Grs', 'Git restore')

