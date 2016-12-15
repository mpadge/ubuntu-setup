" ~./.vimrc
"
runtime! debian.vim 
" sets 'nocompatible'
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

execute pathogen#infect()

if has("syntax")
    syntax on
endif

if has ('gui_running')
    set background=light
else
    set background=dark
    "set background=light
endif
set background=light
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized

if has("autocmd")
    " Jump to the last position when reopening a file
    "au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Load indentation rules and plugins according to the detected filetype.
    " Note these are essential for r-plugin!
    filetype plugin on
    " filetype indent on " set above for vundle
endif

set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" Extra config lines 
set modelines=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set ruler
"set relativenumber
set nu "line numbering
set wrap
set textwidth=80
set colorcolumn=84
set undofile
"global searches, so :%s/foo/bar/g automatically becomes :%s/foo/bar
set gdefault 
"automatically highlight searching
set hlsearch 
" Height of the command bar
set cmdheight=2
set backspace=indent,eol,start


"------------------------------------
" Behavior
"------------------------------------
let maplocalleader = ","
let mapleader = ";"
"let g:mapleader = ","
"set foldenable


"------------------------------------
" Remaps
"------------------------------------
nnoremap <C-L> :nohls<cr>
noremap <C-m> :!make<cr>
nmap <leader>w :w!<cr>
nmap <C-x> :qa<cr>

" openbrowser maps:
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nmap gw <Plug>(openbrowser-open)
vmap gw <Plug>(openbrowser-open)

" Next 2 lines make tab match brackets instead of %
nnoremap <tab> %
vnoremap <tab> %

"------------------------------------
" Showmarks
"------------------------------------
let Tlist_Ctags_Cmd = '/usr/bin/ctags-exuberant'
let marksCloseWhenSelected = 0
let showmarks_include="abcdefghijklmnopqrstuvwxyz"

"------------------------------------
" ExploreMode (instead of NERDTree) mapped to F2
" Note that help doesn't work, but just search "vim netrw" or see here:
" https://medium.com/@mozhuuuuu/vimmers-you-dont-need-nerdtree-18f627b561c3
"------------------------------------
function MyExplore()
    tabnew
    Explore
    nmap <buffer> <leader>q :q<cr>
endfunction

nmap <F2> :call MyExplore()<cr>


"----------------------------------------
"-------------   Nvim-R   ---------------
"----------------------------------------

" https://github.com/jcfaria/Vim-R-plugin/issues/204
let g:ScreenImpl = 'Tmux'
let g:ScreenShellInitialFocus = 'shell' 
" send selection to R with space bar
vmap <Space> <Plug>RDSendSelection 
" send line to R with space bar
nmap <Space> <Plug>RDSendLine

" stop the plugin remapping underscore to '->':
let R_assign = 0

let g:R_in_buffer = 0
let g:R_tmux_split = 1
let g:R_vsplit = 1 "enable vertical split
let R_args = ['--no-save', '--quiet']
let R_tmux_title = 'R'
let g:R_notmuxconf = 1 "use my .tmux.conf, not the Nvim-r one

let r_syntax_folding = 1

"-------------------------------------------
"-------------   vim-latex   ---------------
"-------------------------------------------

" Set grep program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

autocmd BufRead,BufNewFile *.tex call CheckFileType()
function! CheckFileType()
    set textwidth=144
    set colorcolumn=150
endfunction

" set same widths for text files too
autocmd BufNewFile,BufRead *.txt set textwidth=144 | set colorcolumn=150

" =============== WORD COUNT FUNCTION =============
" From http://stackoverflow.com/questions/2974954/correct-word-count-of-a-latex-document
" with modifications from:
" http://tex.stackexchange.com/questions/534/is-there-any-way-to-do-a-correct-word-count-of-a-latex-document
" NOTE that this is globally defined for ALL filetypes, and may muck up other <F3> mappings!
:map <F3> :call WC()<CR>
function! WC()
    let filename = expand("%")
    "let cmd = "detex " . filename . " | wc -w | perl -pe 'chomp; s/ +//;'"
    let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
    let result = system(cmd)
    echo result . " words"
endfunction
" g<C-g> just counts words of a selection, but does not detex.

" NOTE that the above WC() function seems to give really rubbish estimates.
" A superior alternative is texcount, gives far more detail, for which see
" http://app.uio.no/ifi/texcount/howto.html
" To run it, just type :!texcount %<CR>
" It takes a while, but is far more accurate. It is nevertheless not really
" accurate, because it still counted far more words that those remaining when all
" major environments were excised. This is nevertheless possibly just because of
" \itemize, lists, and so on, so it seems to be the best way for the moment.


" =============== SPELL CHECKING =============
" NOTE that spell stopped working with .tex at some stage, and can be fixed by
" entering :syn spell toplevel.  To avoid having to manually enter this every
" time, follow the instructions in ":h mysyntaxfile-add": 
" Make a new directory in /.vim/after/sytax, with "tex.vim" holding this syn
" command. 
" The mysyntaxfile-add instructions also have lots of details about custom
" colour highlight schemes and the likes.
