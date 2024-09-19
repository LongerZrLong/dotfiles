set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.dotfiles/vim/init.vim

" vim-plug
call plug#begin()
  Plug 'folke/noice.nvim'
  Plug 'MunifTanjim/nui.nvim'
call plug#end()

" some init from lua
lua require('init')

" noice
lua require('plugins/noice')
