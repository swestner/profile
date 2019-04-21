" dwiw-loader.vim - Load Vundle and tell it about bundles
" Version: 1.1
set nocompatible
filetype off
set rtp+=~/vimfiles/bundle/vundle.vim
call vundle#rc("~/vimfiles/bundle")
source ~/vimfiles/bundles.vim
filetype plugin indent on
runtime! plugin/sensible.vim
runtime! plugin/dwiw2015.vim
