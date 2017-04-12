" _vimrc

let mapleader="\<Space>"

" Disable menu display and sourcing to enable ALT key mappings
" ... see :help guioptions for more info
set guioptions-=m
set guioptions-=M
set guioptions-=T

set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle initialization -------------------------{{{ 
" Set for different paths for different OSes. Doesn't work for MAC
if has('win32')
    set guifont=Consolas:h11:cANSI
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim
    call vundle#begin("$HOME/vimfiles/bundle")
else
    set guifont=mono
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

    " alternatively, pass a path where Vundle should install plugins
    " call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'
    Plugin 'tpope/vim-surround'
    Plugin 'godlygeek/tabular'
    Plugin 'ervandew/supertab'
    Plugin 'junegunn/goyo.vim'
    Plugin 'delimitMate.vim'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'reedes/vim-colors-pencil'
    Plugin 'xolox/vim-misc'
    Plugin 'xolox/vim-notes'

    " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" ------------------------------ Put your non-Plugin stuff after this line ------------------------------  
" Need to figure out what this stuff does
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

syntax enable
if has("gui_running")
    " Colorscheme = solarized
    let g:solarized_italic=0
    set background=dark
    colorscheme solarized
endif

" delimitMate
let delimitMate_expand_cr=1
let delimitMate_jump_expansion=1

" netrw
" Open in a new tab
let g:netrw_browse_split=0

" Folding
set foldmethod=manual

" Vimscript file settings -------------------------{{{
augroup filetype_vim
    autocmd!
    autocmd filetype vim setlocal foldmethod=marker
augroup END
" }}}
" Show tab numbers in GUI -------------------------{{{ 
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
" }}}

" Goyo mappings -------------------------{{{ 
noremap <leader>wp :Goyo 120x85%<CR>
function! s:goyo_enter()
    setlocal showmode
    noremap j gj
    noremap k gk
    setlocal scrolloff=999
endfunction

function! s:goyo_leave()
    nunmap j
    nunmap k
    colorscheme default
    setlocal scrolloff=5
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}
" vim-notes mappings ---{{{
let g:notes_directories=['~/Dropbox/Writing/SFF']
let g:notes_suffix= '.markdown'
" }}}

noremap! jk <ESC>
vnoremap as <ESC>

" Windowed movement
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h

nnoremap <leader>ws <C-w>s
nnoremap <leader>wv <C-w>v
nnoremap <leader>x <C-w>c

nnoremap <leader>wn :tabe %<CR>
nnoremap <leader>ww :w<CR> 
nnoremap <leader>wr :set nowrap<CR>

" Easy (e)dit (v)imrc
nnoremap <leader>ev :tabe $HOME/.vim/vimrc<CR>
nnoremap <leader>cd :cd %:p:h<CR>

" No undo files in ubuntu
set noundofile
set number
set noswapfile
set nobackup
set tabstop=4
set shiftwidth=4
set expandtab

set viewdir=$HOME/vimfiles/views/
set tags=./tags;/
