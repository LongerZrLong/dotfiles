" Comments in Vimscript start with a `"`.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality.
set nocompatible


" Disable audible bell.
set noerrorbells visualbell t_vb=


" Color

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" Turn on syntax highlighting.
syntax on


" Disable the default Vim startup message.
set shortmess+=I


" Enable the number of matches in search
" set shortmess-=S


" helper function definition
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun


" a function to blink the line for duration ms
function! BlinkLine(duration=500)
    let lnum = line('.')
    let match_id = matchadd('Visual', '\%' . lnum . 'l', 100)
    call timer_start(a:duration, {-> matchdelete(match_id)})
endfunction


" leader key
nnoremap <SPACE> <Nop>
let mapleader=' '


" Line numbers
set number
set relativenumber


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
map <C-q> <Nop>
map <C-r> <Nop>
autocmd VimEnter * nnoremap <C-y> <Nop>


" jump
" ' originally jumps the the start of the line that has the mark
noremap ' `

nnoremap <C-o> <C-o>:call BlinkLine()<Cr>
nnoremap <C-i> <C-i>:call BlinkLine()<Cr>

" buffer
set hidden " By default, Vim doesn't let you hide a buffer that has unsaved changes.
nnoremap <Leader>k :bp<Cr>:bd #<Cr>
nnoremap <Leader>K m0 <Bar> :%bd <Bar> e# <Cr> `0
nnoremap <Leader>e <C-^>


" tab
nnoremap <Leader>t :tab split<Cr>
nnoremap <Leader>T :tabc<Cr>
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

autocmd TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <Leader><Tab> :exe 'tabn '.g:lasttab<Cr>


" window
nnoremap <C-w>; <C-w>p
nnoremap <C-w>> <C-w>20>
nnoremap <C-w>< <C-w>20<
nnoremap <C-w>- <C-w>10-
nnoremap <C-w>+ <C-w>10+

nnoremap s <C-w>v
nnoremap S <C-w>s

vnoremap s <C-w>vgv

" b/c vim-surround overwrites S
autocmd VimEnter * vnoremap S <C-w>sgv


" search
set ignorecase " case-insensitive search when all characters lowercase
set smartcase " case-sensitive if containing any capital letters

set incsearch
set hlsearch

nnoremap n n:call BlinkLine(250)<Cr>
nnoremap N N:call BlinkLine(250)<Cr>

nnoremap <C-r> :set hlsearch<Cr>
nnoremap <Leader>L :noh<Cr>
nnoremap <Leader>l :let @/='\C\<'.expand('<cword>').'\>'<Bar>set hlsearch<Cr>
vnoremap <Leader>l y:let @/='\C\V'.escape(@", '/\')<Bar>set hlsearch<Cr>
vnoremap / y:let @/='\C\V'.escape(@", '/\')<Bar>set hlsearch<Cr>


" recording

" Do the following mapping at start up b/c <C-y> somehow
" gets overwritten if mapped in the .vimrc
nnoremap <C-q> :if reg_recording() == '' <Bar> exe 'normal! qq' <Bar> else <Bar> exe 'normal! q' <Bar> endif <Cr>

nnoremap q @q
vnoremap q :normal! @q<Cr>


" Toggle mouse support. Useful for scrolling.
set mouse=
noremap ` :if &mouse == 'a' <Bar> set mouse= <Bar> else <Bar> set mouse=a <Bar> endif <Cr>


" join
nnoremap <Leader>j J
nnoremap <Leader>J gJ


" scroll
set scrolloff=5 " Show a few lines of context around the cursor.

noremap J 5<C-e>
noremap K 5<C-y>

noremap <C-f> zt:call BlinkLine()<Cr>
noremap <C-b> zb:call BlinkLine()<Cr>
noremap <C-n> zz:call BlinkLine()<Cr>


" redo
autocmd VimEnter * nnoremap U :redo<Cr>


" indent
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
noremap <Leader>i =


" write and exit
nnoremap <Leader>q :q<Cr>
nnoremap Q :q!<Cr>
nnoremap <Leader>Q :qa!<Cr>
nnoremap <Leader>w :w<Cr>
nnoremap <Leader>W :wa<Cr>


" insert mode
inoremap <C-d> <Del>


" copy cut paste
if has('clipboard')
  set clipboard=""    " disable auto yank into * register when exiting visual mode
  noremap <Leader>Y "+Y
  noremap <Leader>y "+y

  nnoremap <Leader>p "+gp
  nnoremap <Leader>P "+gP
  vnoremap <Leader>p "+gp
  vnoremap <Leader>P "+gP

  call SetupCommandAlias("cpa", "%y+")
else
  echo "Install vim-gtk or other similar packages for the clipboard feature."
endif

noremap p "0p
noremap P "0P
inoremap <C-p> <C-r>0

noremap x "0d
noremap X "0D


" cursor
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set ttimeout
set ttimeoutlen=1
set ttyfast

autocmd InsertEnter,InsertLeave * set cursorline!

nnoremap <Leader>v :set cursorcolumn!<Cr>


" cursor movement
noremap <C-h> ^
noremap <C-l> $
noremap <C-j> 5j
noremap <C-k> 5k
noremap <C-s> %


" fold
call SetupCommandAlias('fm', 'setlocal foldmethod=manual')
call SetupCommandAlias('fi', 'setlocal foldmethod=indent')
call SetupCommandAlias('fs', 'setlocal foldmethod=syntax')

" set default foldmethod to indent and open all the folds
" autocmd BufWinEnter * setlocal foldmethod=indent | silent! :%foldopen!


" pathogen
execute pathogen#infect()


" netrw
let g:netrw_home=$XDG_STATE_HOME.'/vim'


" colorscheme
let g:gruvbox_invert_selection=0
autocmd VimEnter * hi Search guibg=DARKBLUE guifg=DARKYELLOW

colorscheme gruvbox
set background=dark

let $BAT_THEME='gruvbox-dark'

" set color theme for integrated terminal to dracula
" this makes the bat preview have better color
let g:terminal_ansi_colors = [
      \ '#21222C', '#FF5555', '#50FA7B', '#F1FA8C',
      \ '#BD93F9', '#FF79C6', '#8BE9FD', '#F8F8F2',
      \ '#6272A4', '#FF6E6E', '#69FF94', '#FFFFA5',
      \ '#D6ACFF', '#FF92DF', '#A4FFFF', '#FFFFFF'
      \ ]

" vim-surround
autocmd VimEnter * vnoremap C <plug>VSurround


" highlightedyank
let g:highlightedyank_highlight_duration = 250


" NERDTree
nnoremap <Leader>f :NERDTreeFocus<Cr>
nnoremap <Leader>F :NERDTreeFind<Cr>

autocmd FileType nerdtree map <buffer> <Enter> o <Bar> :NERDTreeToggle <Cr>


" easymotion
" map ; <Plug>(easymotion-prefix)
map <Leader>; <Plug>(easymotion-s2)


" air-line
set noshowmode  " air-line will show the mode
let g:airline_symbols_ascii = 1


" repeat
nmap U <Plug>(RepeatRedo)


" fzf
let fzf_home = fnamemodify(system('which fzf'), ':h:h')
let &runtimepath .= ','.fzf_home

command! -bang -nargs=* Agc call fzf#vim#ag(<q-args>, '--literal --case-sensitive', fzf#vim#with_preview(), <bang>0)
nnoremap <Leader>a :Agc <C-r><C-w><Cr>
vnoremap <Leader>a y:Agc <C-r>=@"<Cr><Cr>
nnoremap <Leader>A :Ag 

command! -bang -nargs=* BLinesc call fzf#vim#grep('ag --nogroup --column --filename --color -- '.shellescape(empty(<q-args>) ? '^(?=.)' : <q-args>) .. ' ' .. shellescape(expand('%')) .. ' /dev/null 2>/dev/null', fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* BLinescLC call fzf#vim#grep('ag --nogroup --column --filename --color --literal --case-sensitive -- '.shellescape(empty(<q-args>) ? '^(?=.)' : <q-args>) .. ' ' .. shellescape(expand('%')) .. ' /dev/null 2>/dev/null', fzf#vim#with_preview(), <bang>0)
nnoremap <Leader>s :BLinescLC <C-r><C-w><Cr>
vnoremap <Leader>s y:BLinescLC <C-r>=@"<Cr><Cr>
nnoremap <Leader>S :BLinesc<Cr>

nnoremap <C-p><C-f> :Files<Cr>
nnoremap <C-p><C-a> :GFiles<Cr>
nnoremap <C-p><C-d> :GFiles?<Cr>
nnoremap <C-p><C-e> :Buffers<Cr>
nnoremap <C-p><C-l> :call fzf#vim#buffer_lines({'options': '--no-preview'})<Cr>
nnoremap <C-p><C-o> :Jumps<Cr>
nnoremap <C-p><C-w> :Windows<Cr>
nnoremap <C-p><C-r> :History<Cr>
nnoremap <C-p><C-i> :History:<Cr>
nnoremap <C-p><C-s> :History/<Cr>
nnoremap <C-p><C-u> :Snippets<Cr>
nnoremap <C-p><C-g> :Commits<Cr>
nnoremap <C-p><C-h> :BCommits<Cr>
nnoremap <C-p><C-m> :Marks<Cr>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-g': 'Gvdiffsplit'}

set diffopt=internal,filler,closeoff,vertical


" YouCompleteMe
let g:ycm_python_binary_path = 'python'

set completeopt-=preview
let g:ycm_auto_hover = '' " If set to empty string, popup is not auto displayed

" Do to following mapping at start up b/c <C-e> somehow
" gets overwritten if mapped in vimrc
autocmd VimEnter * nmap <C-e> <plug>(YCMHover)

nnoremap <C-g> :YcmCompleter GoTo<Cr>:call BlinkLine()<Cr>

let g:ycm_key_list_select_completion = ['<Tab>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']

call SetupCommandAlias('Yfx', 'YcmCompleter FixIt')
call SetupCommandAlias('Yfm', 'YcmCompleter Format')
call SetupCommandAlias('Yrr', 'YcmCompleter RefactorRename')

let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0


" vim-fugitive
nnoremap <Leader>g :Git<Cr>
nnoremap <Leader>G :GcLog<Cr>
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


" ale
let g:ale_disable_lsp = 0
let g:ale_fix_on_save = 0
let g:ale_virtualtext_cursor = 'current'

nmap gn <plug>(ale_next_wrap)
nmap gp <plug>(ale_previous_wrap)
call SetupCommandAlias('Afx', 'ALEFix')
call SetupCommandAlias('Aim', 'ALEImport')

