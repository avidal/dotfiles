" Use vim settings, rather than vi settings.
" This must be first, because it changes other options as a side effect
set nocompatible

" load debian paths when applicable
runtime! debian.vim

filetype off
runtime vundle.vim

filetype plugin indent on

" enable omnicomplete
set ofu=syntaxcomplete#Complete

" Change mapleader to ,
let mapleader=","

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
set colorcolumn=81                  " draw a column at col 81
set textwidth=79

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

if &t_Co >= 256 || has("gui_running")
    " color scheme for 256 colors
    colorscheme molokai
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

" use ,n to clear search highlighting
nmap <silent> <leader>n :nohlsearch<CR>

" use ,s to enable/disable showing invisible chars
nmap <silent> <leader>s :set list!<CR>

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

" create folds for html tags
"nnoremap <leader>ft Vatzf

" Reselect just-pasted text
nnoremap <leader>v V`]

" gundo plugin
nnoremap <F5> :GundoToggle<CR>
" }}}

" Filetype specific stuff {{{
" only want to support this if we have autocommands
if has("autocmd")
    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end "}}}

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}

    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        autocmd BufNewFile,BufRead *.html,*.htm call s:DetectHTMLVariant()
        autocmd filetype html setlocal ts=2 sts=2

        autocmd filetype html,htmldjango,xml set sw=2 ts=2 sts=2

        " Auto-closing of HTML/XML tags
        " let g:closetag_default_xml=1
        " autocmd filetype html,htmldjango let b:closetag_html_style=1
        " autocmd filetype html,xhtml,xml source ~/.vim/scripts/closetag.vim

        " Enable Sparkup for lightning-fast HTML editing
        let g:sparkupExecuteMapping = '<leader>e'
    augroup end " }}}

    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                " search for: import django, from django import, from
                " django.<etc> import
                if getline(n) =~ '^\(import\|from\)\s\+\<django\>'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with python
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd filetype python setlocal textwidth=80
        autocmd filetype python match ErrorMsg '\%>80v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python map <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python imap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python map <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python imap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Run a quick static syntax check every time we save a Python file
        autocmd BufWritePost *.py call Flake8()
    augroup end " }}}

    augroup ruby_files "{{{
        au!

        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup textile_files "{{{
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end "}}}

    augroup markdown_files "{{{
        au!

        " i've never used modula2, and i like .md for markdown!
        au BufNewFile,BufRead *.md set ft=markdown
    augroup end "}}}
endif

" anything under .zsh should be marked as a zsh file
autocmd BufNewFile,BufRead ~/.zsh* setlocal filetype=zsh
autocmd BufNewFile,BufRead ~/dotfiles/zsh* setlocal filetype=zsh

" }}}

" restore cursor position when reopening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" common misspellings
runtime autocorrect.vim

" extra vi compatibility {{{
set cpoptions+=$        " when changing a line, don't redisplay it, but put a $ at
                        " the end
set formatoptions-=o    " don't start new lines with a comment leader when
                        " pressing o
au filetype vim set formatoptions-=o
" }}}

" Extra user or machine-specific settings {{{
runtime local.vim " should probably be a symlink to a machine-specific config
" }}}

" insert-mode abbreviations for lorem ipsum
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

" GVIM specifics {{{
if has("gui_running")
    "set guifont=Inconsolata:h14
    colorscheme molokai

    " remove toolbar, left and right scrollbars
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
endif
" }}}
