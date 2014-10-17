set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Essential
Bundle 'vim-scripts/bufmru.vim'
Bundle 'bkad/CamelCaseMotion'
Bundle 'tpope/vim-fugitive'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'dimasg/vim-mark'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-repeat'
Bundle 'chrisbra/SudoEdit.vim'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular'
Bundle 'coderifous/textobj-word-column.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'JazzCore/ctrlp-cmatcher'

" Language/filetype-specific
Bundle 'kchmck/vim-coffee-script'
Bundle 'Twinside/vim-haskellConceal'
Bundle 'bitc/lushtags'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'leshill/vim-json'
Bundle 'tpope/vim-markdown'
Bundle 'techlivezheng/tagbar-phpctags'
Bundle 'spf13/PIV'
Bundle 'ehamberg/vim-cute-python'
Bundle 'marijnh/tern_for_vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'fatih/vim-go'

" The Rest
Bundle 'airblade/vim-gitgutter'
Bundle 'Raimondi/delimitMate'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/gist-vim'
Bundle 'gregsexton/gitv'
Bundle 'msanders/snipmate.vim'
Bundle 'vim-scripts/dbext.vim'
Bundle 'neh/vim-scratch'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/clam.vim'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-scripts/AnsiEsc.vim'
Bundle 'tpope/vim-sleuth'
" Bundle 'vim-scripts/easytags.vim'
Bundle 'Shougo/vimproc.vim'
"Bundle 'Shougo/unite.vim'
Bundle 'bling/vim-airline'
Bundle 'mmalecki/vim-node.js'
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-lastpat'

" Colors
Bundle 'rainux/vim-desert-warm-256'
Bundle 'vim-scripts/Sorcerer'
Bundle 'w0ng/vim-hybrid'
Bundle 'chriskempson/vim-tomorrow-theme'

if v:version > 703 || (v:version == 703 && has("patch584"))
    Bundle 'Valloric/YouCompleteMe'
else
    Bundle 'Shougo/neocomplcache'
endif
