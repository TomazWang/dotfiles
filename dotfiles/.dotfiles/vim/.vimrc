" ------------ General Configuration ---------------                           

set number                     " show line numbers
set rnu                        " show relative line numbers
set history=1000               " store lots of :command line history
set showcmd                    " show incomplete commands
set autoread                   " reload files changed outside vim
set backspace=indent,eol,start " make backspace work like in most other program
set ignorecase                 " case insensive 

" ------------ Indentation -------------------

set tabstop=4			" show existing tab with 4 space width 
set shiftwidth=4		" when indenting with '>', use 4 spaces width 
set expandtab			" when pressing tab, insert spaces instead
set autoindent          " copy the indentation of current line when start a new line.	
set smartindent         " smart indent, works with C-like languages
set smarttab            

" ----------- Looks and Feel --------------------
" color 
set t_Co=256



" highlight over 80 colum
set textwidth=80
set colorcolumn+=1
highlight ColorColumn ctermbg=236 guibg=#32322f 
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(120,999),",")
" ------------ Plugin Setting --------------


" Add plugin with Vim-plug
call plug#begin('~/.vim/plugged')

" NERDtree: a tree look directory plugin
Plug 'scrooloose/nerdtree'

" Airline: bottom status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" vim-indent-guides: shows the indents 
Plug 'nathanaelkane/vim-indent-guides'

" syntax highlighting
Plug 'scrooloose/syntastic'

" markdown syntax support
Plug 'plasticboy/vim-markdown'

" auto complete
Plug 'valloric/youcompleteme'

" git gutter
Plug 'airblade/vim-gitgutter'

" add Dracula-theme
Plug 'crusoexia/vim-dracula'

" ctrlp.vim, a fuzzy finder
Plug 'kien/ctrlp.vim'

" quick preview GFM markdown 
Plug 'superbrothers/vim-quickrun-markdown-gfm'

" easy-to-use Vim alignment plugin.
Plug 'junegunn/vim-easy-align'

call plug#end()

" -------- Plugin Config -------------


" vim-markdown
let g:vim_markdown_folding_disabled = 1     " disable folding

" for airline theme
set laststatus=2
let g:airline_theme='luna'


" for youcompleteme
let g:ycm_python_binary_path='/usr/bin/python3'

" YCM
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" ------------- Key Mapping ------------

" toggle paste mode
set pastetoggle=<F3>

" jump between splits
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" For NERDTree
map <C-n> :NERDTreeToggle<CR>

" For vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ------------ Other -----------------

" fix the first line render probelm
set t_RV=

