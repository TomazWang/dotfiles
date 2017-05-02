" Add plugin with Vim-plug
call plug#begin('~/.vim/plugged')

" NERDtree: a tree look directroy plugin
Plug 'scrooloose/nerdtree'

" Airline: bottom status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" vim-indent-guides: shows the indents 
Plug 'nathanaelkane/vim-indent-guides'
 
Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'

call plug#end()

" for airline theme
set laststatus=2
let g:airline_theme='luna'


" for youcompleteme
let g:ycm_python_binary_path = '/usr/bin/python3'


