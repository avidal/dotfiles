" Use vim settings, rather than vi settings.
" This must be first, because it changes other options as a side effect
set nocompatible

" load debian paths when applicable
runtime! debian.vim

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" My custom vim bundle
Plugin 'avidal/vim-bundle'

Plugin 'AutoComplPop'
Plugin 'bufexplorer.zip'
Plugin 'bufkill.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'mileszs/ack.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'Blackrush/vim-gocode'
Plugin 'LokiChaos/vim-tintin'
Plugin 'wting/rust.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ervandew/supertab'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'elixir-lang/vim-elixir'
Plugin 'davidhalter/jedi-vim'

call vundle#end()

filetype plugin indent on

" enable omnicomplete
set ofu=syntaxcomplete#Complete

" open the syntastic fix window automatically
let g:syntastic_auto_loc_list=1

" use jshint and eslint for javascript
let g:syntastic_javascript_checkers = ['jshint']

" filter out a few unnecessary files from the nerd tree
let NERDTreeIgnore=['\.pyc$', '\~$']

" show hidden files in NERDTree
let NERDTreeShowHidden=1

" Change mapleader to ,
let mapleader=","

let g:Powerline_symbols="fancy"

" Editing behavior {{{
set showmode                        " always show the current editing mode
set nowrap                          " do not wrap lines
set tabstop=4                       " tab == 4 spaces
set softtabstop=4                   " when backspacing, pretend a tab is removed
                                    " (4 spaces)
set expandtab                       " expand all tabs (to spaces) by default
set shiftwidth=4                    " number of spaces used for autoindenting
set shiftround                      " use a multiple of shiftwidth when using
                                    " < and >
set backspace=indent,eol,start      " backspace over everything in insert mode
set autoindent                      " always turn on autoindent
set copyindent                      " copy the previous indent when
                                    " autoindenting
set number                          " always show line numbers
set showmatch                       " highlight matching parens/braces
set ignorecase                      " ignore case when searching
set smartcase                       " do not ignore case when search pattern
                                    " is mixed-case
set smarttab                        " insert tabs on start of line according
                                    " to shiftwidth, not tabstop
set scrolloff=4                     " keep 4 lines off the edges of the screen
set virtualedit=block,onemore       " allow the cursor anywhere
set hlsearch                        " highlight search terms
set incsearch                       " show matches as you type
set gdefault                        " search/replace with the /g flag by default
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

set nolist                          " hide invisible characters by default
set pastetoggle=<F2>                " enable/disable paste mode
set mouse=a                         " enable the mouse if the term supports it
set fileformats="unix,dos,mac"
set formatoptions+=1                " don't end lines with 1-letter words
                                    " when wrapping paragraphs

" insert \v before any searched string, basically replacing vim's wonky re
" syntax with regular re syntax
nnoremap / /\v
vnoremap / /\v
" }}}

" Folding settings {{{
set nofoldenable                    " don't close folds when opening files
set foldcolumn=2                    " add a fold column
set foldmethod=marker               " detect triple-{ fold markers
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                    " which commands trigger unfold

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()
" }}}

" Editor settings {{{
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                      " don't update display while running macros
set laststatus=2                    " always show status line
set cmdheight=2                     " 2-line status bar
set textwidth=79

if v:version >= 730
    set colorcolumn=81              " draw a column at col 81
endif

" statusline from http://www.linux.com/archive/feature/120126
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" statusline from
" https://github.com/nvie/vimrc/blob/master/vim/after/plugin/statusline.vim
if exists('g:loaded_fugitive')
   set statusline=%f\ %m\ (%L\ lines)\ %r\ %=%{fugitive#statusline()}\ (%l,%c)\ %y
else
   set statusline=%f\ %m\ (%L\ lines)\ %r\ %=(%l,%c)\ %y
endif
" }}}

" Vim behavior {{{
set hidden                          " hide buffers instead of closing them
set switchbuf=useopen               " reveal already opened files from the
                                    " quickfix window instead of opening new
                                    " buffers
set history=1000                    " command/search history length
set undolevels=1000                 " mucho undos por favor
if v:version >= 730
    set undofile                    " persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set nobackup                        " no backup files (pita)
set noswapfile                      " no swap files (pita!)
set directory=~/.vim/.tmp,~/tmp,/tmp
                                    " put swap files here IF swapfile is
                                    " enabled
set viminfo='20,\"80                " use a .viminfo file with no more than 80
                                    " lines of registers
set wildmenu                        " bash-like tab complete for files/buffers
set wildmode=list:full              " show a list when hitting tab and complete
                                    " first full match
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell                      " no beeping!
set noerrorbells                    " no beeping!
set showcmd                         " show partial command in the last line
                                    " of the screen
set nomodeline                      " disable modelines for security
set cursorline                      " draw a line below the cursor

" tame quickfix window (toggle with ,f)
nmap <silent> <leader>f :QFix<CR>

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
" }}}


" Highlighting {{{

set background=dark " default to dark background
colorscheme jellybeans

if &t_Co >= 256 || has("gui_running")
    " color scheme for 256 colors
    colorscheme jellybeans
endif

if &t_Co > 2 || has("gui_running")
    syntax on                       " enable syntax highlighting when the term
                                    " has colors
endif

" slower but better sync, should fix problems with incorrect highlighting
syntax sync fromstart

" }}}

" Shortcuts {{{

" use ; for commands in addition to :
nnoremap ; :

" map <F1> to <Esc>
map! <F1> <Esc>

" close the current window, fast!
nnoremap <leader>q :q<CR>

" use Q to format the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" replace visual selection with yank register when you hit p
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" swap ' and ` for marker jumps
" by default, ' goes to the line, ` goes to line + column
" line + column is more useful, so let's swap the keys
nnoremap ' `
nnoremap ` '

" remap j and k to work as expected on long, wrapped lines
nnoremap j gj
nnoremap k gk

" easier moving between windows
" use ,w to cycle through
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" complete whole filenames/lines a bit faster in insert mode
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>

" use ,d (or ,dd ,dj 20,dd etc) to delete a line and skip the yank stack
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" quick yank to end of line
nmap Y y$

" Yank/paste to OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P

" set yankring history directory
let g:yankring_history_dir = '$HOME/.vim/.tmp'

" map ,r to show/hide the yank ring
nmap <leader>r :YRShow<CR>

" edit/source vimrc with ,ev and ,sv
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" use ,h to clear search highlighting
nmap <silent> <leader>h :nohlsearch<CR>

" use ,s to enable/disable showing invisible chars
nmap <silent> <leader>s :set list!<CR>

" use ,e to open buf explorer
nmap <silent> <leader>e :BufExplorer<CR>

" jj/jk for getting out of insert mode
inoremap jj <Esc>
inoremap jk <Esc>

" text alignment
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>

" start a substitution using word under cursor
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" quick-load of the scratch plugin
nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>

" forgot to sudo vim?
cmap w!! w !sudo tee % > /dev/null

" use tab to jump between pairs
nnoremap <Tab> %
vnoremap <Tab> %

" use space for folding
nnoremap <Space> za
vnoremap <Space> za

" strip all trailing whitespace with ,W
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" quick ack!
nnoremap <leader>a :Ack<Space>

" Reselect just-pasted text
nnoremap <leader>v V`]

" gundo plugin
nnoremap <F5> :GundoToggle<CR>
" }}}

augroup invisible_chars "{{{
    au!

    " Show invisible characters in all of these files
    autocmd filetype vim setlocal list
    autocmd filetype python,rst setlocal list
    autocmd filetype ruby setlocal list
    autocmd filetype javascript,css setlocal list
augroup end "}}}

" restore cursor position when reopening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" extra vi compatibility {{{
set cpoptions+=$        " when changing a line, don't redisplay it, but put a $ at
                        " the end
set formatoptions-=o    " don't start new lines with a comment leader when
                        " pressing o
au filetype vim set formatoptions-=o
" }}}

" rainbow parens don't work well on my dark background
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
\ ]

" GVIM specifics {{{
if has("gui_running")
    set guifont=Ubuntu\ Mono\ 12
    colorscheme jellybeans

    " remove toolbar, left and right scrollbars
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
endif
" }}}
