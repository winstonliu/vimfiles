" _vimrc

execute pathogen#infect()
set nocompatible

" Disable menu display and sourcing to enable ALT key mappings
" ... see :help guioptions for more info
set guioptions-=m
set guioptions-=M

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
func! WordProcessorMode() 
    set guifont=Courier_New:h11:b:cANSI
    set background=light
    colorscheme solarized
    setlocal formatoptions=1 
    setlocal noexpandtab 
    map j gj 
    map k gk
    setlocal spell spelllang=en_us 
    set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
    set complete+=s
    set formatprg=par
    setlocal wrap 
    setlocal linebreak 
endfu 
com! WP call WordProcessorMode()

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

" Mappings
inoremap jj <ESC>
inoremap ,, ->
inoremap ;; ::
inoremap -- <=

noremap <A-k> <C-w>k
noremap <A-j> <C-w>j
noremap <A-l> <C-w>l
noremap <A-h> <C-w>h

set noundofile
set number
set noswapfile
set nobackup
set tabstop=4
set shiftwidth=4
set expandtab
