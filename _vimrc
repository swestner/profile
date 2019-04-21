source $HOME/vimfiles/dwiw-loader.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

map <silent> <C-n> :NERDTreeFocus<CR>

set backupdir=$TEMP,$TMP,~\vimfiles\bkup
set directory=$TEMP,$TMP,~\vimfiles\bkup
      
set shell=powershell.exe\ -ExecutionPolicy\ Unrestricted
set shellcmdflag=-Command
set shellpipe=>       
set shellredir=>

:hi CursorLine   cterm=NONE
:hi CursorColumn cterm=NONE
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
