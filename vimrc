set nocompatible    " use vim defaults
set ls=2            " allways show status line
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set number          " show line numbers
set ignorecase      " ignore case when searching
"set noignorecase   " don't ignore case
set title           " show title in console title bar
set ttyfast         " smoother changes
"set ttyscroll=0        " turn off scrolling, didn't work well with PuTTY
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
"set viminfo='20,<50,s10,h

set autoindent     " always set autoindenting on
"set smartindent        " smart indent
"set cindent            " cindent
set noautoindent
set nosmartindent
set nocindent  

set cursorline     " highlight current line
"set autowrite      " auto saves changes when quitting and swiching buffer
"set expandtab      " tabs are converted to spaces, use only when required
set sm             " show matching braces, somewhat annoying...
"set nowrap         " don't wrap lines

syntax on           " syntax highlighing
" Folding Settings
set foldmethod=indent "fold based on indent
set foldnestmax=10    "Depest fold is 10 levels
set nofoldenable      "Don't Fold by Default
set foldlevel=1
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType xsl setlocal foldmethod=syntax

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
  
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

if has("gui_running")
    " See ~/.gvimrc
    set guifont=lucida_console:h14 " use this font
    set lines=50       " height = 50 lines
    set columns=100        " width = 100 columns
    set background=dark   " adapt colors for background
    colorscheme desert    " use this color scheme
    set selectmode=mouse,key,cmd
    set keymodel=
else
    set background=dark        " adapt colors for background
    "colorscheme default    " use this color scheme
    "colorscheme autumn    " use this color scheme
    colorscheme slate    " use this color scheme
endif

if has("autocmd")
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Filetypes (au = autocmd)
    au FileType helpfile set nonumber      " no line numbers when viewing help
    au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back
    
    " When using mutt, text width=72
    au FileType mail,tex set textwidth=72
    au FileType cpp,c,java,sh,pl,cu,php,asp  set autoindent
    au FileType cpp,c,java,sh,pl,cu,php,asp  set smartindent
    au FileType cpp,c,java,sh,pl,php,asp  set cindent
	autocmd FileType python call <SID>pystuff()
	function! <SID>pystuff()
		set foldmethod=indent
		set foldlevel=999999
		set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
		set expandtab
	endfunction
	autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
	autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
	autocmd BufRead *.py nmap <F5> :!python %<CR>

	"Syntax support for SCSS
	au BufRead,BufNewFile *.scss set filetype=scss
	au BufWritePost *.scss checktime

    "au BufRead mutt*[0-9] set tw=72
    
    " Automatically chmod +x Shell and Perl scripts
    au BufWritePost   *.sh             !chmod +x %
    au BufWritePost   *.pl             !chmod +x %

    " File formats
    au BufNewFile,BufRead  *.pls    set syntax=dosini
    au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
	au BufRead,BufNewFile *.cuh set ft=cuda
	au BufRead,BufNewFile *.ode set filetype=xppaut
	au BufRead,BufNewFile *.xsl set filetype=xml
    au! Syntax xppaut source ~/.vim/syntax/ode.vim
endif

" Keyboard mappings
map <F2><Leader>be<cr>          " map F2 to open previous window
"map <F3><C-W>w          " map F3 to open next window
map :W :w
"map <F5>:w<cr> " map F5 to save the current buffer
"imap <F5><ESC>:w<cr> " map F5 to save the current buffer
"----- write out html file
map ,h :colorscheme zellner<cr>:TOhtml<cr>:w<cr>:clo<cr> :colorscheme darkblue<cr>
"Split in to four or three different windows
map ,four  :vsplit<cr>:split<cr><C-W>w <C-W>w :split<cr>
map ,three :vsplit<cr>:vsp<cr>

"Mappings to move through windows
map <A-Left> <C-W>W
map <A-Right> <C-W>w
map <A-Up> :bp<cr>
map <A-Down> :bn<cr>
map <Leader>[ <C-W>W
map <Leader>] <C-W>w
map <Leader>- :bp<cr>
map <Leader>= :bn<cr>
nmap <silent> <Leader>d :bd<cr>
"nmap <silent> <Leader>P :Project<CR>

"Toggle the Project Sidebar
nmap <silent> <F8> <Plug>ToggleProject

"Toggle the Taglist Sidebar
nnoremap <silent> <F9> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1

set encoding=utf-8
set nobackup
set nowritebackup
set noswapfile
"--------------------------VimRC configurations from Derek Wyatt's Blog
filetype plugin on
set hidden   "Gets rid of the must save before switching windows
set wildmenu "Awesome tab completion

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

" Don't update the display while executing macros
set lazyredraw
 
" Allow backspacing over indent, eol, and the start of an insert
set backspace=2
"
" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is
"      executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=500

" Keep some stuff in the history
set history=100

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Allow the cursor to go in to "invalid" places
"set virtualedit=all

" These things start comment lines
set comments=sl:/*,mb:\ *,ex:\ */,O://,b:#,:%,:XCOMM,n:>,fb:-


"Mappings

nmap <silent> ,esv :sp $MYVIMRC<cr>    " edit my .vimrc file in a split
nmap <silent> ,ev :e $MYVIMRC<cr>      " edit my .vimrc file
nmap <silent> ,sv :so $MYVIMRC<cr> " update the system settings from my vimrc file
" Toggle paste mode
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

" Turn off that stupid highlight search
nmap <silent> ,n :set invhls<CR>:set hls?<CR>

" Set text wrapping toggles
nmap <silent> ,w :set invwrap<CR>:set wrap?<CR>

" Set up retabbing on a source file
nmap <silent> ,rr :1,$retab<CR>

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>

" Hide the mouse pointer while typing
set mousehide
" Maps to make handling windows a bit easier
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>

noremap <silent> ,cc :close<CR>
noremap <silent> ,cw :cclose<CR>
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J
noremap <silent> <C-7> <C-W><
noremap <silent> <C-8> <C-W>-
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>>

" Make horizontal scrolling easier
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh


"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
 nmap <S-F7> :NERDTreeClose<CR>

 " Store the bookmarks file in perforce
 let NERDTreeBookmarksFile=$HOME . '/.vim/NERDTreeBookmarks'

 " Show the bookmarks table on startup
 let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
            \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
            \ '\.embed\.manifest$', '\.embed\.manifest.res$',
            \ '\.intermediate\.manifest$', '^mt.dep$' ]

 "-----------------------------------------------------------------------------
 " FSwitch Settings
 "-----------------------------------------------------------------------------
 nmap <silent> ,of :FSHere<CR>
 nmap <silent> ,ol :FSRight<CR>
 nmap <silent> ,oL :FSSplitRight<CR>
 nmap <silent> ,oh :FSLeft<CR>
 nmap <silent> ,oH :FSSplitLeft<CR>
 nmap <silent> ,ok :FSAbove<CR>
 nmap <silent> ,oK :FSSplitAbove<CR>
 nmap <silent> ,oj :FSBelow<CR>
 nmap <silent> ,oJ :FSSplitBelow<CR>

 "-----------------------------------------------------------------------------
 " SnipMate Settings
 "-----------------------------------------------------------------------------
 "source
 "~/.vim/snippets/support_functions.vim
 "source
 "~/.vim/snippets/support_functions_derek.vim

function! ListKnownSnippetLanguageTypes(A, L, P)
    let filesanddirs = split(globpath(g:snippets_dir, a:A . "*"), "\n")
    let dirsonly = []
    for f in filesanddirs
        if isdirectory(f)
            let each = split(f, '/')
            let dirsonly = add(dirsonly, each[-1])
        end
    endfor
    return dirsonly
endfunction

function! ReloadSnippets(type)
    call ResetSnippets()
    if a:type != ""
        call ExtractSnips(g:snippets_dir . a:type, a:type)
    else
        let alltypes = ListKnownSnippetLanguageTypes("", "", "")
        for type in alltypes
            call ExtractSnips(g:snippets_dir . type, type)
        endfor
    endif
endfunction

command! -complete=customlist,ListKnownSnippetLanguageTypes
         \ -nargs=? RS call ReloadSnippets("<args>")

"-----------------------------------------------------------------------------
"" Fix constant spelling mistakes
"-----------------------------------------------------------------------------

iab teh       the
iab Teh       The
iab taht      that
iab Taht      That
iab alos      also
iab Alos      Also
iab aslo      also
iab Aslo      Also
iab becuase   because
iab Becuase   Because
iab bianry    binary
iab Bianry    Binary
iab bianries  binaries
iab Bianries  Binaries
iab charcter  character
iab Charcter  Character
iab charcters characters
iab Charcters Characters
iab exmaple   example
iab Exmaple   Example
iab exmaples  examples
iab Exmaples  Examples
iab shoudl    should
iab Shoudl    Should
iab seperate  separate
iab Seperate  Separate
iab fone      phone
iab Fone      Phone

"-----------------------------------------------------------------------------
"" Source Explorer Plugin Settings
"-----------------------------------------------------------------------------
"" The switch of the Source Explorer
"nmap <silent> <F9> :SrcExplToggle<CR>

" Set the height of Source Explorer window
 let g:SrcExpl_winHeight = 16
"
" " Set 10 ms for refreshing the Source Explorer
 let g:SrcExpl_refreshTime = 10

" In order to Avoid conflicts, the Source Explorer should know what plugins
" are using buffers. And you need add their bufname into the list below
" according to the command ":buffers!"
let g:SrcExpl_pluginList = [
             \ "_NERD_tree_",
			 \ "Source_Explorer"
			 \ ]
" Map CTRL-E to do what ',' used to do
nnoremap <c-e> ,
vnoremap <c-e> ,


" Alignment Scripts
vmap <silent> <Leader>i= <ESC>:AlignPush<CR>:AlignCtrl lp1P1<CR>:'<,'>Align =<CR>:AlignPop<CR>
vmap <silent> <Leader>i, <ESC>:AlignPush<CR>:AlignCtrl lp0P1<CR>:'<,'>Align ,<CR>:AlignPop<CR>
vmap <silent> <Leader>i( <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align (<CR>:AlignPop<CR>


"let g:pydiction_location = '$HOME/.vim/ftplugins/pydiction/complete-dict'
"filetype off
call pathogen#infect()
call pathogen#helptags()
"filetype plugin indent on

"Edit file in the same directory as the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

