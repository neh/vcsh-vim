" Initial Setup {{{ -----------------------------------------------------------

set nocompatible
" Clear autocmds
autocmd!

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'bitc/lushtags'
Bundle 'bkad/CamelCaseMotion'
Bundle 'chrisbra/SudoEdit.vim'
Bundle 'dimasg/vim-mark'
" Bundle 'dmedvinsky/uritality.vim'
Bundle 'ehamberg/vim-cute-python'
Bundle 'godlygeek/tabular'
Bundle 'kana/vim-smartinput'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'leshill/vim-json'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/gist-vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'mileszs/ack.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'neh/dbext.vim'
Bundle 'neh/vim-git-inline-diff'
Bundle 'neh/vim-scratch'
Bundle 'pangloss/vim-javascript'
Bundle 'rainux/vim-desert-warm-256'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplcache'
Bundle 'sjl/clam.vim'
Bundle 'sjl/gundo.vim'
Bundle 'spf13/PIV'
Bundle 'techlivezheng/tagbar-phpctags'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-markdown'
Bundle 'Twinside/vim-haskellConceal'
Bundle 'vim-scripts/Align'
Bundle 'vim-scripts/AnsiEsc.vim'
Bundle 'vim-scripts/bufmru.vim'
" Bundle 'vim-scripts/easytags.vim'

" Enable filetype detection and syntax highlighting
filetype plugin indent on
syntax on

" Make vim update screen window title
if &term =~ "^screen"
    set t_ts=k
    set t_fs=\
endif
" Workaround to make italics work in tmux sessions
if $TMUX != '' && &term =~ "screen-256color"
    set t_so=[7m
    set t_ZH=[3m
endif

" Set titlestring when switching buffers (kept short for screen window names)
autocmd BufEnter * let &titlestring = expand("%:t")

set background=dark
" Set up color settings and scheme based on terminal type
if has('gui_running')
    colo mustang
else
    if $TERM =~ '^screen-bce' || $TERM == 'screen-256color' || $TERM =~ '256'
        set t_Co=256
        colo Tomorrow-Night
    else
        set t_Co=16
    endif
endif

" Set up man page viewing
let $PAGER=''
runtime! ftplugin/man.vim

runtime macros/matchit.vim

" Pull in dbext database profiles if they exist
if filereadable($HOME.'/dbext_profiles')
    source $HOME/dbext_profiles
endif


" }}}
" Filetype specific options {{{ -----------------------------------------------

" add filetype to files that need it
"autocmd BufRead,BufNewFile COMMIT_EDITMSG setlocal filetype git
autocmd BufRead,BufNewFile *.erb setlocal filetype eruby
autocmd BufRead,BufNewFile *.snippet? setlocal filetype=snippet sts=8 sw=8 noet
autocmd BufRead,BufNewFile *.mustache,*.ms setlocal filetype=mustache

" some files need real tabs (I default to spaces for indentation)
autocmd FileType make setlocal noexpandtab
autocmd FileType snippet setlocal noexpandtab

"autocmd FileType text,mail setlocal formatprg=perl\ -MText::Autoformat\ -e\ 'autoformat{all=>1}'
autocmd FileType text,mail setlocal formatoptions+=t formatprg=par\ -w80\ -q

autocmd FileType html setlocal makeprg=tidy\ -q\ -e\ %
autocmd FileType html setlocal errorformat=line\ %l\ column\ %v\ -\ %m
autocmd FileType html setlocal equalprg=tidy\ -q\ -w\ -i

autocmd FileType ruby setlocal sts=2 sw=2 ts=2

" No wrapping for the quickfix window
autocmd BufReadPost quickfix setlocal nowrap

" re-read vimrc after writing it
autocmd BufWritePost *vimrc source $HOME/.vimrc | call Pl#Load()
autocmd BufRead *vimrc,*zshrc,*tmux.conf setlocal foldmethod=marker

autocmd BufRead,BufNewFile *.zsh-theme setlocal filetype=zsh
autocmd BufRead,BufNewFile *tmux.conf setlocal filetype=tmux

" Useful when customizing xterm
autocmd BufWritePost *Xdefaults*,*Xresources* :!xrdb ~/.Xresources
" give machine-specific X setting files the proper filetype
autocmd BufRead,BufNewFile *Xdefaults-* setlocal filetype=xdefaults

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" Make yssp wrap a line in php tags
autocmd FileType php let b:surround_112 = "<?php \r ?>"

" folding setup
let php_folding = 1
autocmd FileType javascript setlocal foldmethod=syntax
autocmd FileType css,php setlocal foldmethod=syntax

" completion setup
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

let php_sql_query = 1
let php_htmlInStrings = 1
let php_parent_error_close = 1
let php_parent_error_open = 1


" }}}
" Custom highlighting {{{ -----------------------------------------------------

" Highlight error logging functions (php error_log, js console.log, etc)
" Terms to be highlighted are defined in ~/.vim/after/syntax/*
hi ErrorLogFunction term=inverse,bold cterm=inverse,bold ctermfg=red ctermbg=black

" Change some highlight group colours, overriding the colour scheme search terms
hi Search term=none cterm=none ctermfg=232 ctermbg=220
hi IncSearch term=none cterm=none ctermfg=232 ctermbg=41
" todo
hi Todo term=bold cterm=bold ctermfg=red ctermbg=yellow
" popup menu
hi Pmenu term=none cterm=none ctermfg=250 ctermbg=238
hi PmenuSel term=bold cterm=bold ctermfg=black ctermbg=250
" diff viewer
hi DiffAdd term=none cterm=none ctermfg=black ctermbg=120
hi DiffDelete term=none cterm=none ctermfg=233 ctermbg=233
hi DiffChange term=none cterm=none ctermfg=248 ctermbg=237
hi DiffText term=none cterm=none ctermfg=234 ctermbg=120
" cursor line
hi CursorLine term=none cterm=none ctermfg=7 ctermbg=22 gui=none guibg=#333333
" folding
hi Folded term=none cterm=bold ctermbg=236 ctermfg=244 gui=none guibg=#333333
hi FoldColumn term=none cterm=none ctermbg=236 ctermfg=244 gui=none guibg=#333333

if $TMUX != '' || $TERM == 'rxvt-256color'
    hi Folded cterm=italic
    hi Comment cterm=italic
endif

" make special chars (tabs, trailing spaces, etc) barely visible
hi SpecialKey cterm=none ctermfg=241
" other special chars (line wrap chars etc.)
hi NonText cterm=none ctermfg=240 ctermbg=235

hi ExtraWhitespace ctermbg=124 ctermfg=white guibg=red guifg=white
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

" }}}
" General options {{{ ---------------------------------------------------------

let mapleader=","
set encoding=utf-8
set fileencodings=utf-8
set ruler
set pastetoggle=<F12>
set title
set laststatus=2
set visualbell t_vb=
set formatoptions+=croqnwl
set ttyfast
set history=500
set nowrap
set linebreak
set showcmd
set nostartofline
set hidden
set backspace=indent,eol,start
set timeoutlen=500

set shortmess=atI

set autoindent
set smartindent

set textwidth=79
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab

set incsearch
set hlsearch

set showmatch
set matchtime=2

set ignorecase
set smartcase
set gdefault

set scrolloff=3
set sidescroll=1
set sidescrolloff=2

set completeopt=longest,menuone

if has("wildmenu")
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png
    set wildignore+=*~,*.swp,*.tmp,.DS_Store
    set wildmenu
    set wildmode=longest,list
endif

set clipboard=unnamed

" Put backup/swap files all in one place
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Enable mouse usage in terminals
" (allows window resizing, mousewheel scrolling, proper text highlighting)
set mouse=a
set ttymouse=xterm2
" Workaround for bug in vim that breaks mouse support when in tmux.
" bug: http://groups.google.com/group/vim_dev/browse_thread/thread/0416d81258cbb5a0?pli=1
" workaround: https://wincent.com/blog/tweaking-command-t-and-vim-for-use-in-the-terminal-and-tmux
if $TMUX != '' || $TERM == 'rxvt-256color'
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
endif

" Show trailing whitespace and tabs as visible chars
set list
set listchars=tab:➜\ ,extends:❱,precedes:❰

" Mark column 80, method depending on vim version
if exists('+colorcolumn')
    hi ColorColumn ctermbg=236 guibg=#111111
    set cc=80
endif

if v:version >= '703'
    set undodir=~/.vim/undo
    set undofile
endif

let &showbreak = '↪ '

" make concealed chars stay concealed when I'm just moving around
set concealcursor=nc

" Remove parts of the gui, just in case I happen to run it
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b


" }}}
" Key mappings {{{ ------------------------------------------------------------

" toggle folds
nnoremap <space> za
vnoremap <space> za

" recursively open folds
nnoremap z<space> zCzO

" refocus folds
nnoremap zf zMzvzz

" delete trailing whitespace
map <leader>dtr :%s/\s\+$//e<cr>

" make Y behave like other capitals
map Y y$

" A few dvorak movement adjustments
noremap s l
noremap S L
noremap t gj
noremap n gk
noremap l n
noremap L N
noremap j J

" Keep line containing search term centered and unfold as needed
nnoremap l nzzzv
nnoremap L Nzzzv

" Unmap my dvorak movement keys in select mode so Snipmate snippets don't suck
sunmap s
sunmap S
sunmap t
sunmap n
sunmap N

" Window nav mappings
nmap <C-n> :call SwitchWindowOrBuffer('b')<CR>
nmap <C-t> :call SwitchWindowOrBuffer('f')<CR>
nmap <F4> <C-W>o
nmap <F5> <C-W>c
nmap <F6> <C-W>=
nmap <F7> <C-W><
nmap <F8> <C-W>-
nmap <F9> <C-W>+
nmap <F10> <C-W>>
nmap <F11> <C-W>_
nmap <F12> :bd<CR>
nmap <Leader><F12> :bd!<CR>

" No more Ex mode mapping. Do something useful instead.
vmap Q gq
nmap Q gqap

" Fast save mapping
nmap <Leader><return> :w<cr>

" Save files that you need sudo for, but didn't open as root
cmap W! silent w !sudo tee % >/dev/null

" Change regex handling
nnoremap / /\v
vnoremap / /\v

" Toggle wrapping
nnoremap <Leader>w :setlocal nowrap! nolist!<cr>

" Move a line of text
" TODO these don't actually work (the mappings, I mean).
nmap <M-t> mz:m+<cr>`z
nmap <M-n> mz:m-2<cr>`z
vmap <M-t> :m'<-2<cr>`>my`<mzgv`yo`z
vmap <M-n> :m'>+<cr>`<my`>mzgv`yo`z

" quickly turn off search highlighting
map <Leader><space> :noh<cr>

" Load vimrc in a split window and switch to it
nmap <Leader>V :vs ~/.vimrc<cr>
" Source .vimrc
nmap <Leader>VS :so ~/.vimrc<cr>

" cd to the dir containing the current file
nmap <Leader>cd :lcd %:h<cr>

" Set up retabbing on a source file
nmap <Leader>rt :1,$retab<cr>

" In visual mode press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>zzzv
vnoremap <silent> # :call VisualSearch('b')<CR>zzzv

" Searches for the current selection using Ack
vnoremap <silent> gf :call VisualSearch('gf')<CR>

" Quickfix window maps
nmap <Leader>co :copen<cr>
nmap <Leader>cx :cclose<cr>

" Location window maps
nmap <Leader>lo :lopen<cr>
nmap <Leader>lx :lclose<cr>

" Turn off diff options
nmap <Leader>do :diffoff<cr>
nmap <Leader>do! :diffoff!<cr>

" Quick PHP syntax check (CTRL-l)
autocmd FileType php noremap <Leader>phpl :!/usr/bin/php -l %<CR>

" Create folds for objects (tags, paras, blocks, etc.)
nnoremap <Leader>ft Vatzf
nnoremap <Leader>fp Vapzf
nnoremap <Leader>fb VaBzf

" fast file format conversion
nnoremap <Leader>ffd :setlocal ff=dos<CR>
nnoremap <Leader>ffu :setlocal ff=unix<CR>


" }}}
" Plugin configs {{{ ----------------------------------------------------------

" SudoEdit
nmap <Leader>W :SudoWrite<cr>
vmap <Leader>W :SudoWrite<cr>

" tcomment
let g:tcommentMapLeader2="<Leader>c"
nmap <Leader>/ :TComment<cr>
vmap <Leader>/ :TComment<cr>
vmap <Leader>ci :TCommentInline<cr>

" PHPCtags
if executable($HOME . "/myconfig/phpctags/phpctags")
    let g:tagbar_phpctags_bin=$HOME.'/myconfig/phpctags/phpctags'
endif

" URitality
let g:uritality_color_insert = "#33b1ff"
let g:uritality_color_normal = "#fffb17"

" Mark
nmap <Leader><Leader><Leader>/ <Plug>MarkSearchAnyNext
function! s:SetMarkColours()
    highlight MarkWord1 ctermbg=208 ctermfg=Black guibg=#F2891F guifg=Black
    highlight MarkWord2 ctermbg=148 ctermfg=Black guibg=#BCFA37 guifg=Black
    highlight MarkWord3 ctermbg=075 ctermfg=Black guibg=#4DD0F7 guifg=Black
    highlight MarkWord4 ctermbg=185 ctermfg=Black guibg=#EFF589 guifg=Black
    highlight MarkWord5 ctermbg=197 ctermfg=Black guibg=#F52A63 guifg=Black
    highlight MarkWord6 ctermbg=249 ctermfg=Black guibg=#E3E3E3 guifg=Black
endfunction
autocmd ColorScheme * call s:SetMarkColours()
call s:SetMarkColours()

" Powerline
let g:Powerline_symbols = 'unicode'
let g:Powerline_symbols_override = {
    \ 'BRANCH': [0x2325],
    \ 'LINE': '',
    \ 'RO': [0x2205],
    \ }
let g:Powerline_dividers_override = ['', [0x2502], '', [0x2502]]
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

" bufmru
let g:bufmru_switchkey = "<c-e>"

" ctrlp
let g:ctrlp_dotfiles = 0
let g:ctrlp_open_multi = 'vr'
let g:ctrlp_map = '<leader>f'
nmap <Leader>e :CtrlPBuffer<cr>
nmap <Leader>h :CtrlPCurFile<cr>

" Neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_max_list = 40
let g:neocomplcache_auto_completion_start_length = 3

" CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw

" Syntastic
let g:syntastic_auto_loc_list=2
let g:syntastic_enable_signs=1

" Tagbar
nmap <Leader>. :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_usearrows = 1
let g:tagbar_singleclick = 1

" Easymotion
let g:EasyMotion_mapping_f = '<Leader>,f'
let g:EasyMotion_mapping_F = '<Leader>,F'
let g:EasyMotion_mapping_t = '<Leader>,t'
let g:EasyMotion_mapping_T = '<Leader>,T'
let g:EasyMotion_mapping_w = '<Leader>,w'
let g:EasyMotion_mapping_b = '<Leader>,b'
let g:EasyMotion_mapping_e = '<Leader>,e'
let g:EasyMotion_mapping_ge = '<Leader>,ge'
let g:EasyMotion_mapping_j = '<Leader>,j'
let g:EasyMotion_mapping_k = '<Leader>,k'

" Scratch
nmap <Leader>' :SscratchToggle<cr>

" dbext
let g:dbext_default_use_sep_result_buffer = 1
nmap <Leader>sdb :DBSetOption dbname=

" Space
let g:space_no_character_movements = 1
let g:space_disable_select_mode = 1
let g:space_no_search = 1

" Gundo
nmap <Leader>un :GundoToggle<CR>
let g:gundo_map_move_older="t"
let g:gundo_map_move_newer="n"

" Surround
" Change visual mode surround mappings so s works for movement again
vmap <Leader>s <Plug>Vsurround
vmap <Leader>S <Plug>Vsurround

" NERDTree
nmap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>nm :NERDTreeMirror<CR>
let g:NERDTreeMapOpenInTab="a"
let g:NERDTreeMapOpenInTabSilent="A"
let g:NERDTreeMapJumpFirstChild="N"
let g:NERDTreeMapJumpLastChild="T"
let g:NERDTreeMapJumpNextSibling="<C-S-T>"
let g:NERDTreeMapJumpPrevSibling="<C-S-N>"
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeAutoCenter=1
let g:NERDTreeAutoCenterThreshold=6

" Ack
nmap <Leader>gf :LAck 

" fugitive (git)
nmap <Leader>gs :Gstatus<cr>
nmap <Leader>gd :Gdiff<cr>
nmap <Leader>gg :Ggrep 
nmap <Leader>glg :Glog<cr>
nmap <Leader>gc :Gcommit<cr>
nmap <Leader>gmv :Gmove 
nmap <Leader>grm :Gremove
nmap <Leader>gpu :Git push<cr>
nmap <Leader>gt :w<cr>:bd<cr>:diffoff!<cr>
nmap <Leader>gta :Gread<cr>:w<cr>:bd<cr>:diffoff!<cr>
" clean up all those buffers fugitive leaves behind
nmap <Leader>gbd :bdelete fugitive://<C-A><cr>

" Snipmate
let g:snips_author = 'Nathan Howell'

" Jsbeautify
nnoremap <silent> <leader>jb :call g:Jsbeautify()<cr>

" Align
map <Leader>ac :AlignCtrl 
nmap <Leader>a vii:Align 
vmap <Leader>a :Align 

" Yankring
"let g:yankring_enabled = 1
map <Leader>y :YRShow<cr>
let g:yankring_min_element_length = 2
let g:yankring_replace_n_nkey = ''


" }}}
" Custom functions and commands {{{ -------------------------------------------

" I keep hitting :W when saving. It may as well work.
command! W :w


" Number text object. From http://vimbits.com/bits/334
onoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>

function! s:NumberTextObject(whole)
    normal! v

    while getline('.')[col('.')] =~# '\v[0-9]'
        normal! l
    endwhile

    if a:whole
        normal! o

        while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
            normal! h
        endwhile
    endif
endfunction


" Switch windows/buffers, depending on whether multiple windows exist.
function! SwitchWindowOrBuffer(d)
    if winbufnr(2) == -1
        if a:d == 'f'
            execute 'normal :bnext'
        elseif a:d == 'b'
            execute 'normal :bprev'
        endif
    else
        if a:d == 'f'
            execute 'normal :wincmd w'
        elseif a:d == 'b'
            execute 'normal :wincmd W'
        endif
    endif
endfunction


" Check whether the cursor has moved to a new line and toggle
" cursorline highlighting (on if on a new line, off if not).
" orig from: http://vim.wikia.com/wiki/Highlight_cursor_line_after_cursor_jump
function! s:Cursor_Moved()
    let cur_screen_pos = winline()
    let cur_file_pos = line('.')
    if g:last_file_pos == 0 || g:last_file_pos == 0
        setlocal cursorline
        let g:last_screen_pos = cur_screen_pos
        let g:last_file_pos = cur_file_pos
        return
    endif
    let sdiff = g:last_screen_pos - cur_screen_pos
    let fdiff = g:last_file_pos - cur_file_pos
    if sdiff >= 1 || sdiff <= -1 || fdiff >= 1 || fdiff <= -1
        setlocal cursorline
    else
        setlocal nocursorline
    endif
    let g:last_screen_pos = cur_screen_pos
    let g:last_file_pos = cur_file_pos
endfunction
" highlight the current line (all the way to the right edge), but only if the 
" cursor has moved to a new line
"autocmd CursorMoved,CursorMovedI * call s:Cursor_Moved()
let g:last_screen_pos = 0
let g:last_file_pos = 0


" A visual search mode function. Searches for the current selection
" forwards, backwards, or with Ack.
" from: http://amix.dk/vim/vimrc.html (but slightly customized)
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . ""
    elseif a:direction == 'gf'
        execute "normal :LAck " . l:pattern . ""
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . ""
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Show syntax highlighting groups for word under cursor
nmap <Leader>syn :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" }}}
" Local config settings {{{ ---------------------------------------------------

if filereadable($HOME . "/.local.vim")
    source $HOME/.local.vim
endif

" }}}
