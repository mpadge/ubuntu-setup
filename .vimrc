" ~./.vimrc
"
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim 
" sets 'nocompatible'
"
execute pathogen#infect()

if has("syntax")
  syntax on
endif
" Set up solarized colour profile, as per
" http://www.xorcode.com/2011/04/11/solarized-vim-eclipse-ubuntu/
" Copy the soliarized.vim file from solarized/vim-colors-solarized/colors/ to
" the directory (which needs to be mkdir'd) /.vim/colors.
if has ('gui_running')
    set background=light
else
    set background=dark
set background=dark
endif
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized

" Jump to the last position when reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Load indentation rules and plugins according to the detected filetype.
" Note these are essential for r-plugin!
"if has("autocmd")
  filetype plugin on
  filetype indent on
"endif

set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Extra config lines from Coming Home to Vim Steve Losh
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


"------------------------------------
" Change width for .tex files:
" From http://stackoverflow.com/questions/158968/changing-vim-indentation-behavior-by-file-type
:autocmd BufNewFile,BufRead *.tex set textwidth=144 | set colorcolumn=150
:autocmd BufNewFile,BufRead *.txt set textwidth=144 | set colorcolumn=150

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sample settings for vim-r-plugin and screen.vim
" From http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/My_R_Scripts/vim-r-plugin/.tmux.conf
" via http://manuals.bioinformatics.ucr.edu/home/programming-in-r/vim-r#TOC-Installation
" Installation 
"       - Place plugin file under ~/.vim/
"       - To activate help, type in vim :helptags ~/.vim/doc
"       - Place the following vim conf lines in .vimrc
" Usage
"       - Read intro/help in vim with :h vim-r-plugin or :h screen.txt
"       - To initialize vim/R session, start screen/tmux, open some *.R file in vim and then hit F2 key
"       - Object/omni completion command CTRL-X CTRL-O
"       - To update object list for omni completion, run :RUpdateObjList
" My favorite Vim/R window arrangement 
"	tmux attach
"	Open *.R file in Vim and hit F2 to open R
"	Go to R pane and create another pane with C-a %
"	Open second R session in new pane
"	Go to vim pane and open a new viewport with :split *.R
" Useful tmux commands
"       tmux new -s <myname>       start new session with a specific name
"	tmux ls (C-a-s)            list tmux session
"       tmux attach -t <id>        attach to specific session  
"       tmux kill-session -t <id>  kill specific session
" 	C-a-: kill-session         kill a session
" 	C-a %                      split pane vertically
"       C-a "                      split pane horizontally
" 	C-a-o                      jump cursor to next pane
"	C-a C-o                    swap panes
" 	C-a-: resize-pane -L 10    resizes pane by 10 to left (L R U D)
" Corresponding Vim commands
" 	:split or :vsplit      split viewport
" 	C-w-w                  jump cursor to next pane-
" 	C-w-r                  swap viewports
" 	C-w C-++               resize viewports to equal split
" 	C-w 10+                increase size of current pane by value

" To open R in terminal rather than RGui (only necessary on OS X)
" let vimrplugin_applescript = 0
" let vimrplugin_screenplugin = 0
" For tmux support
let g:ScreenImpl = 'Tmux'
"let vimrplugin_screenvsplit = 1 " For vertical tmux split
let g:ScreenShellInitialFocus = 'shell' 
" instruct to use your own .screenrc file
"let g:vimrplugin_noscreenrc = 1
" For integration of r-plugin with screen.vim
"let g:vimrplugin_screenplugin = 1
" Don't use conque shell if installed
"let vimrplugin_conqueplugin = 0
" map the letter 'r' to send visually selected lines to R 
"let g:vimrplugin_map_r = 1
" see R documentation in a Vim buffer
"let vimrplugin_vimpager = "no"
"set expandtab
" start R with F2 key - does not work properly, so need to be disabled
" to re-enable <leader>rf
"map <F2> <Plug>RStart 
"imap <F2> <Plug>RStart
"vmap <F2> <Plug>RStart
" send selection to R with space bar
vmap <Space> <Plug>RDSendSelection 
" send line to R with space bar
nmap <Space> <Plug>RDSendLine

" finally, stop the plugin remapping underscore to '->':
"let vimrplugin_assign = 0 
let R_assign = 0
" TODO: 1. Get tmux split to stay open when R quits

" new stuff for Nvim-r from
" https://github.com/jcfaria/Vim-R-plugin/issues/204
let g:R_in_buffer = 0
let g:R_tmux_split = 1
let g:R_vsplit = 1 "enable vertical split
let R_args = ['--no-save', '--quiet']
let R_tmux_title = 'R'
let g:R_notmuxconf = 1 "use my .tmux.conf, not the Nvim-r one

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------
"-------------   vim-latex   ---------------
"-------------------------------------------

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
" filetype plugin on " already turned on for r-plugin above

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" vim-latex does not properly compile when installed. Solution given here:
" http://www.quentinhuys.com/vim.html is the TexLet command that I have
" embedded within a function that is called upon opening all tex files.
"autocmd BufRead,BufNewFile *.tex call CheckFileType()
"function! CheckFileType()
"	let g:filename = expand("%:p:t")
"	TexLet g:Tex_MultipleCompileFormats = ''
"endfunction
" NOTE however that this command does not appear to work when the filenames contain
" unorthodox characters such as spaces and symbols ("#", "&", etc.).

" **** Compiling rules taken from here:
" **** http://sourceforge.net/p/vim-latex/mailman/vim-latex-devel/?viewmonth=201003&viewday=17
" **** Note that the only working bit is the actually to set CompileRule_dvi() to run
" **** the full compilation all the way to pdf. The intermediate ps step is because of
" **** pstricks. If this is not needed, then this vimrc file can be modified to skip ps
" **** and just run pdftex or pdflatex
autocmd BufRead,BufNewFile *.tex call CheckFileType()
function! CheckFileType()
    colorscheme delek
    let g:Tex_MultipleCompileFormats = 'dvi,ps'
    let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
    let g:Tex_DefaultTargetFormat = 'pdf'
    " The ViewRule does not do anything here, and I can't work out why! 
    "let g:Tex_ViewRule_pdf = 'xdg-open'

    " NOTE That these are disabled because I always use makefiles, and just
    " remap <C-m> to make above.
    "let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'
    "let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    "let g:Tex_CompileRule_ps = 'dvips $*.dvi $*.ps'
    "let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps $*.pdf'
    " **** The following lines are for dvi -> ps -> pdf ****
    "let g:Tex_CompileRule_dvi='latex -interaction=nonstopmode -shell-escape $*.tex'
    "	\.' && dvips -P pdf -q  $*.dvi'
    "	\.' && ps2pdf $*.ps'
    " **** The following lines are for dvi -> pdf direct ****
    let g:Tex_CompileRule_dvi='latex -interaction=nonstopmode -shell-escape $*.tex'
                \.' && dvipdfm $*.dvi'

    let g:Tex_IgnoreLevel = 7

    TexLet g:Tex_FormatDependency_ps = 'dvi,ps'
    TexLet g:Tex_DefaultTargetFormat = 'pdf'
    "TexLet g:Tex_ViewRule_dvi = 'xdg-open'
    "TexLet g:Tex_ViewRule_pdf = 'xdg-open'
endfunction

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
" Commands from h: spell :
" ]s - next misspelled word
" [s - previous
" z= - view spelling suggestions
" zg - add word to dictionary
" zug - undo add word

" NOTE that spell stopped working with .tex at some stage, and can be fixed by
" entering :syn spell toplevel
" The problem is that this has to be entered manually every time. To avoid this,
" I followed the instructions in ":h mysyntaxfile-add" and made a new directory
" in /.vim/after/sytax, with "tex.vim" holding this syn command. The
" mysyntaxfile-add instructions also have lots of details about custom colour
" highlight schemes and the likes.
if v:version >= 700
    "set nospell
    "setlocal spell spelllang=en_gb
    "set spellfile=~/.vim/dict.add
endif

" =============== NOTE on keymappings =============
" expand('%') produces filename
" expand('%:p') does same, with directory string
" substitute(expand('%'),'.tex','.dvi') does the obvious

" How to call a function at startup:
"autocmd BufRead,BufNewFile *.tex call CheckFileType()
"function! CheckFileType()
"   let g:filename = expand("%:p:t")
"endfunction
"When the file has finished loading, I echo the filename:
"echo g:filename

" The following 2 lines dump an echo of the command i want to execute:
" (they thus don't work, but it's the closest i've got so far)
":map <A-2> echo :call MyLaTexCmd()
"function! MyLaTeXCmd()
"	let g:filename = expand("%:p:t")
"	latex g:filename
"endfunction

"=====
" For custom mappings
" From http://vim.1045645.n5.nabble.com/understanding-Alt-key-mapping-in-latex-suite-td1216914.html
"augroup MyTeXIMAPs
"	au VimEnter * if &filetype == "tex" | imap <A-2>
"latex *.tex| endif
"augroup END
" 
