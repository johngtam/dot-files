" -----------------------------------------------------------------------------
" Use Pathogen
" -----------------------------------------------------------------------------
execute pathogen#infect()

" -----------------------------------------------------------------------------
" Colors
" -----------------------------------------------------------------------------
syntax on                            " enable syntax processing
set background=light                 " set background to be light
colorscheme solarized                " set colorscheme
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
set t_Co=256                         " force vim to use 256 colors
let g:solarized_termcolors=256       " use solarized 256 fallback

" -----------------------------------------------------------------------------
" Spaces and Tabs
" -----------------------------------------------------------------------------
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set autoindent      " tell Vim to apply indentation of the current line to next
set smartindent     " Vim will indent according to filetype.
filetype plugin on  " turns on plugin for filetypes
filetype indent on  " load filetype-specific indent files

" -----------------------------------------------------------------------------
" Vim config
" -----------------------------------------------------------------------------
set nocompatible
set modifiable
set laststatus=2

" Maps jj as Escape
inoremap jj <ESC>

" Maps comma as leader
let mapleader = ","

" -----------------------------------------------------------------------------
" UI Config
" -----------------------------------------------------------------------------
set number              " show line numbers
set relativenumber      " shows relative numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set ttyfast             " update terminal faster
set encoding=utf-8      " set encoding to be utf-8
set showmode            " explicitly show which mode we're in
set showcmd             " explicitly show which command I'm entering
set visualbell          " stop having Vim beep when I do something wrong
set splitright          " splits start on the right side first
set splitbelow          " splits start on the bottom side first
set mouse=a             " allow usage of mouse in Vim
set ruler               " shows where your cursor is
set scrolloff=5         " center the scroll when we go up and down

" Toggle between pasting and nopaste
nnoremap <leader>v :set paste<cr>
nnoremap <leader>c :set nopaste<cr>

" -----------------------------------------------------------------------------
" Searching
" -----------------------------------------------------------------------------
" sets 'magic mode,' which means non-alphanumeric chars need to be escaped
nnoremap / /\v
vnoremap / /\v

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " ignore case for when searching
set smartcase           " Vim will only be case-sensitive when search has capital
set gdefault            " by default, global replace
nnoremap <leader><space> :nohlsearch<CR>
set showmatch           " highlight matching [{()}]

" -----------------------------------------------------------------------------
" Wrapping
" -----------------------------------------------------------------------------
set wrap                " set Vim to visually wrap
set textwidth=80        " set Vim to wrap at 80 characters
set colorcolumn=75      " set Vim to visually indicate where the end is.

" -----------------------------------------------------------------------------
" Folding
" -----------------------------------------------------------------------------
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" space open/closes folds
nnoremap <space> za

" -----------------------------------------------------------------------------
" Movement
" -----------------------------------------------------------------------------
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Remaps keybindings so I don't have to ctrl+W before switching pane.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" have space just advanced one character (although I should be using hjkl)
nnoremap space a<space><esc>

" Remaps so I can repeat actions
vnoremap . :norm.<CR>

" ---------------------------------------------
"  Easymotion customization
" ---------------------------------------------
map <Leader><Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)
" <Leader>f{char} to move to {char}
map  <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

" -----------------------------------------------------------------------------
" Backups
" -----------------------------------------------------------------------------
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nobackup

" -----------------------------------------------------------------------------
" Custom functions/mappings
" -----------------------------------------------------------------------------
" tells which directory I'm in
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" removes extra white space.
:nnoremap <leader>rmw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Copy and paste to system clipboard.
vnoremap <C-c> "*y
vnoremap <C-v> "*p

" Edit a new file, and exit out 
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

" -----------------------------------------------------------------------------
" FZF Setup
" -----------------------------------------------------------------------------
set rtp+=~/.fzf
nnoremap <silent> <leader>fe :call fzf#run({'sink': 'tabe'})<CR>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" - window (nvim only)
let g:fzf_layout = { 'down': '~40%' }

" -----------------------------------------------------------------------------
" Ag Settings
" -----------------------------------------------------------------------------
let g:ag_working_path_mode="r"
let g:ag_highlight=1

" Advanced customization using autoload functions
autocmd VimEnter * command! Colors
   \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})

" -----------------------------------------------------------------------------
" NERDTree Settings
" -----------------------------------------------------------------------------

nnoremap <leader>n :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<cr>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -----------------------------------------------------------------------------
" Gundo settings
" -----------------------------------------------------------------------------
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_auto_preview = 1

" -----------------------------------------------------------------------------
" Airline settings
" -----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" -----------------------------------------------------------------------------
" CtrlP settings
" -----------------------------------------------------------------------------
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
nmap <leader>bt :CtrlPTag<cr>

" -----------------------------------------------------------------------------
" Buffergator settings
" -----------------------------------------------------------------------------
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorToggle<cr>

" -----------------------------------------------------------------------------
" Tagbar settings
" -----------------------------------------------------------------------------
nmap <leader>tt :TagbarToggle<CR>
autocmd FileType tagbar setlocal nocursorline nocursorcolumn
set tags=./tags;
