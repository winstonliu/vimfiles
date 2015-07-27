" _vimrc

let mapleader="\<Space>"

" Disable menu display and sourcing to enable ALT key mappings
" ... see :help guioptions for more info
set guioptions-=m
set guioptions-=M
set guioptions-=T

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" Set for different paths for different OSes. Doesn't work for MAC
if has('win32')
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim
    call vundle#begin("$HOME/vimfiles/bundle")
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

    " alternatively, pass a path where Vundle should install plugins
    " call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-surround'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'godlygeek/tabular'
    Plugin 'delimitMate.vim'

    " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

" Need to figure out what this stuff does
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" Colorscheme = solarized
syntax enable
let g:solarized_italic=0
set background=dark
colorscheme solarized

" delimitMate
let delimitMate_expand_cr=1
let delimitMate_jump_expansion=1

" netrw
" Open in a new tab
let g:netrw_browse_split=3

" Folding
set foldmethod=syntax
set foldnestmax=1
set foldclose=all

" Change into word processing mode for :WP
"   func! WordProcessorMode() 
"       set guifont=Courier_New:h11:b:cANSI
"       set background=light
"       colorscheme solarized
"       setlocal formatoptions=1 
"       setlocal noexpandtab 
"       map j gj 
"       map k gk
"       setlocal spell spelllang=en_us 
"       set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
"       set complete+=s
"       set formatprg=par
"       setlocal wrap 
"       setlocal linebreak 
"   endfu 
"   com! WP call WordProcessorMode()

" Show tab numbers in GUI
set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor
    " Append the tab number
    let label .= v:lnum.': '
    " Append the buffer name
    let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    if name == ''
        " give a name to no-name documents
        if &buftype=='quickfix'
            let name = '[Quickfix List]'
        else
            let name = '[No Name]'
        endif
    else
        " get only the file name
        let name = fnamemodify(name,":t")
    endif
    let label .= name
    " Append the number of windows in the tab page
    let wincount = tabpagewinnr(v:lnum, '$')
    return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}

" Git mappings
nnoremap <leader>g :Gstatus<CR>

" Mappings
inoremap jj <ESC>
inoremap ,, ->
inoremap ;; ::

inoremap #pp #pragma once<CR>
inoremap #ii #include
inoremap #!! #!/bin/bash

" Windowed movement
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h

nnoremap <leader>s <C-w>s
nnoremap <leader>v <C-w>v
nnoremap <leader>c <C-w>c

nnoremap <leader>n :tabe %<CR>

" Easy open vimrc
nnoremap <leader>r :tabe $MYVIMRC<CR>

" No undo files in ubuntu
set noundofile
set number
set noswapfile
set nobackup
set tabstop=4
set shiftwidth=4
set expandtab
