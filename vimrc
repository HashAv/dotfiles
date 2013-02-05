""""""""""""""""""""""""""""""""""""""""""""""""""
"  Windows instructions  "
"  1. Clone my dotfiles
"  2. Clone vundle in .dotfiles/vim/bundle/vundle (bundles are ignored by git)
"     (also checkout vundle for windows wiki on github)
"  3. Create a ~/_vimrc with the following 2 lines
"     set rtp+=~/.dotfiles/vim
"     source ~/.dotfiles/vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""
" For windows comptatibility
set rtp+=~/.dotfiles/vim/bundle/vundle/
if has("gui_running")
  set guioptions-=m "menu bar
  set guioptions-=T "tool bar

  "Full screen
  if has("gui_win32")
    if $LANG == "FR"
      au GUIEnter * simalt ~n
    endif
  endif
endif

set nocompatible               " be iMproved
filetype off                   " required!
call vundle#rc()

noremap <silent> <C-L> :nohls<CR><C-L>

" Swap those keys for inline searching
nnoremap , ;
nnoremap ; ,

" Default encoding is needed for Windows XP and this mapleader
set encoding=utf8
let mapleader = "è"

" Set the ALT key (press <C-V> then <A-D> to get the raw value)
set <A-D>=d

inoremap <C-D> <Del>
inoremap <A-D> <C-O>de

" Annotate Ending Tag (with a comment -- relies matchit.vim and tComment)
" I have to mark the original jump position since it gets lost (i.e. I can't
" use ``)
" mz  = mark z
" yy  = copy line
" g%  = cycle match backwards
" p   = paste the copied line
" gcc = comment it
" kJ  = merget it
" `z  = go back to where I was
nmap _aet mzyyg%pgcckJ`z

" Align a ruby hash (1.9)
nmap _arh vip:Tabularize/\w:\zs/l0l1<CR>
vmap _arh :Tabularize/\w:\zs/l0l1<CR>

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Git wrapper
Bundle 'tpope/vim-fugitive'

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'

" Simulates M-t emacs function
Bundle 'transpose-words'
nmap <Leader>t <Plug>Transposewords
imap <Leader>t <Plug>Transposewords
cmap <Leader>t <Plug>Transposewords

" Like Emacs chords.
" Create maps inside the ~/.vim/plugin directory
" Arpeggio inoremap ts  <Esc> # this will fail in vimrc
Bundle "https://github.com/kana/vim-arpeggio.git"

" Haml and Sass syntax hl and indentation
Bundle 'https://github.com/tpope/vim-haml.git'

" Alternate column colors. Toggle with <Leader>ig
Bundle 'https://github.com/nathanaelkane/vim-indent-guides.git'
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" I fixed scss -> css indenting issues by copying a custom
" vim.css in ~/.vim/indent/css.vim
" I debugged the issue with ':verbose set indentexpr' inside vim

" Don't think I need those for now
" Bundle 'css3-syntax-plus'
" Bundle 'https://github.com/cakebaker/scss-syntax.vim.git'
" Bundle 'https://github.com/hail2u/vim-css3-syntax.git'

"Bundle 'https://github.com/othree/html5-syntax.vim.git'
" Don't think I need this anymore since I user snippets now
" Bundle 'https://github.com/othree/html5.vim.git'

" Move easily with <Leader><Leader>w
" Seems to be buggy so I'm gone remove it
" Bundle 'Lokaltog/vim-easymotion'
" let g:EasyMotion_leader_key = '<Leader>'
" let g:EasyMotion_mapping_f = '_f'
" let g:EasyMotion_mapping_w = 'é'


" Ruby syntax files, etc.
Bundle 'vim-ruby/vim-ruby'

" vim-scripts repos
"Bundle 'vim-scripts/Align.git'

Bundle 'https://github.com/spf13/vim-colors.git'

Bundle 'Auto-Pairs'
let g:AutoPairsShortcutToggle = "<Leader>p""

Bundle 'matchit.zip'

" Bundle 'neocomplcache'
" Bundle 'neocomplcache-snippets_complete'
" Bundle 'Syntastic'

" Align double quotes
" :Tabularize / "/l0"
Bundle "https://github.com/godlygeek/tabular.git"

Bundle 'xmledit'

Bundle 'buffet.vim'
map <F2> :Bufferlist<CR>

" " snipmate --START
" " Install dependencies:
" Bundle "MarcWeber/vim-addon-mw-utils"
" Bundle "tomtom/tlib_vim"
" Bundle "honza/snipmate-snippets"
" " Install
" Bundle "garbas/vim-snipmate"
" " snipmate --END
"
Bundle "scrooloose/nerdtree"
" Single click to open filepath elements
let NERDTreeMouseMode = 3
map <C-T> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

" Collapse all nodes
" Select parent node and type 'X'

" Allow mouse use.
" This enables click select in normal mode + NERDTree click
if has('mouse')
  " Enable mouse in terminal, just in normal mode
  " set mouse=a
  set mouse=n "n works better with NERDTree
endif

" vim-snipmate alternative
Bundle "https://github.com/SirVer/ultisnips.git"
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsListSnippets="<F9>"

" SQL formatting with <LEADER>sfs
Bundle 'SQLUtilities'
let g:sqlutil_align_comma = 1
" Dependencie
Bundle 'Align'

" autocmd bufEnter *.html.erb UltiSnipsAddFiletypes eruby.html
" Snippets + syntax highlighting
autocmd bufEnter *.html.erb set ft=eruby.html

autocmd bufEnter *.scss UltiSnipsAddFiletypes scss.css

" Setting this variable allows me to override the default snippets with a bang!
" Otherwise the default snippets still show up.
let g:UltiSnipsDontReverseSearchPath="1"

" I tried to make a toggle function but the search path does not get updated
" For now the best solution is to modify vimrc and restart vim
let g:DefaultSnippetsInhibited=0
if g:DefaultSnippetsInhibited
  let g:UltiSnipsSnippetDirectories=["myUltiSnips"]
else
  let g:UltiSnipsSnippetDirectories=["myUltiSnips", "UltiSnips"]
endif


" non github repos
" Fast file search
" Install then
" cd ~/.vim/bundle/command-t/ruby/command-t
" rvm use system
" ruby extconf.rb
" make
" Bundle 'git://git.wincent.com/command-t.git'
Bundle 'https://github.com/kien/ctrlp.vim.git'

filetype plugin indent on     " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"=========================
" Bundles
" ========================
Bundle 'tComment'
" tComment is probably better than NERDCommenter because it allows to user vim words/motion
" gc Toggles, gC adds
" gcap # Comment a paragrap
" gc} # Comment until end of block
" gcas # Comment a 'sentence' word
" gcj # Comment current line and 1 below
" gc2j # Comment current 3 lines from current line
" gc% # Comment a ruby block for instance


" First test the keymap
" place 'stty -ixon' in bashrc first, to use <C-S>
" map <C-S> :echo 'c-s ok'<CR>
" check the value inside vim with :echo g:tcommentMapLeader1
" let g:tcommentMapLeader1 = '<C-S>'
" let g:tcommentMapLeader1 = '<F6>'
" noremap <C-S> <C-_>
" map <C-C> :echo 'c-c ok'<CR>
"

" Should use tComment now
" Bundle 'The-NERD-Commenter'
" NERDCommenter will add space after comment
" <Leader>cA # Comment to end of line
" <Leader>c<Space> # Toggle on and off
" <Leader>ci # Inverts commen state
" <Leader>cl # Comment symbol are aligned in line
" <Leader>ca # Switch to alternative comment symbol
" let NERDSpaceDelims = 1

" map <F3> :call NERDComment(0, 'uncomment')<CR>+
" map <S-F3> :call NERDComment(0, 'uncomment')<CR>
" map <F4> :call NERDComment(0, 'norm')<CR>+
" map <S-F4> :call NERDComment(0, 'norm')<CR>
" imap <F4> <ESC>:call NERDComment(0, 'insert')<CR><Esc>==$xA
"
" Re-indent the whole file
nmap <F6> gg=G``
imap <F6> <Esc>gg=G``


"=========================
" Vim configuration
" ========================

set history=1000          " Keep x lines of command line history
set undolevels=1000       " Use many levels of undo                                        "
set ruler                 " Show the cursor position all the time (normally on by default)
set showcmd               " Displays incomplete commands and if the leader key was pressed
set incsearch             " Do incremental searching (this moves the cursor as I search)
set number                " Display line numbers
set ic                    " Ignore case on search
set scs                   " Smartcase
set wildmode=list:longest " Prevent command line completion cycle effect
set go-=r                 " Pas d'ascenseur dans gvim
set foldcolumn=1          " Noter dans la marge les plis existants
syntax on                 " Turns syntax highlighting on
set hlsearch              " Highlight search
set nobackup

" old setup
" set softtabstop=4
" set shiftwidth=4
" set tabstop=4

" This converts tabs to spaces. This should be better overall
set expandtab
set shiftwidth=2
set softtabstop=2

set bg=dark
set t_Co=256

colorscheme ir_black

"Fix ir_black coloring inside terminals
highlight Visual ctermfg=white
highlight Pmenu ctermbg=238
highlight PmenuSel ctermbg=DarkRed

if has("gui_running")
  highlight Search guifg=Cyan gui=reverse
else
  highlight Search ctermfg=white ctermbg=6
endif

nmap <F7> :set hlsearch!<CR>
set pastetoggle=<F8>

" Display the annoying unicode char 00a0 (non-breaking space) with a '%'
set listchars+=nbsp:%

" Default is croql.
" tcrq is a better setting for me
" the 'o' flag is off so I can stop autocommenting on new lines with <C-O>O
" This way, there's no need to customize 'formatoptions' per file.
au BufEnter * set fo=tcrq

" Get rid of hidden non-breaking-space
imap <CHAR-0x00a0> <CHAR-0x20>

" Not sure what this one does anymore
set backspace=indent,eol,start whichwrap+=<,>,[,]

" This is actually done with <ALT-O> by default
" inoremap <C-O> <C-O>o

inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-H> <Left>
inoremap <C-L> <Right>

cnoremap <C-A> <Home>
cnoremap <C-E> <End>

noremap <F1> :q<CR>
noremap <S-F1> :qa!<CR>

" Normal mode & save
nnoremap <F4> :w<CR>:echo "File succesfully saved at" strftime("%H:%M:%S")<CR>
inoremap <F4> <ESC>:w<CR>:echo "File succesfully saved at" strftime("%H:%M:%S")<CR>
" imap <C-S> <F4>
" map <C-S> <F4>

" Cycle quickly through buffers
map <S-LEFT> :bp<CR>
map <S-RIGHT> :bn<CR>
map <S-UP> :ls<CR>:b
" This is the same like the built-in <C-S-6> shortcut
map <S-DOWN> :b#<CR>

" ci" and ci' work even if I'm not inside the quotes range
" ci< ci( and ci{ however require being inside the brackets range.
" So I can use ci> ci) ci} to mimick the behaviour of ci" and ci'
nnoremap ci> f<ci<
nnoremap ci) f(ci(
nnoremap ci} f{ci{
nnoremap ci] f[ci[

if has("autocmd")
  " Apply .vimrc modifications automatically
  autocmd! bufwritepost .vimrc source ~/.vimrc

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "
  " This is already called by vundle but I'm leaving it there anyways
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
  augroup END
else
  " Always set autoindenting on
  " This mustn't load if filetype plugin indent is on
  set autoindent
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Folds text according to syntax highlighting rules
set foldmethod=syntax
" Don't close folds on file open (default=0 => all folds are closed)
set foldlevel=20

" Not needed anymore due to UtilSnip's html5 tag
" autocmd bufNewfile *.html 0r ~/.vim/my_skels/skel.html

autocmd bufEnter *.txt set tw=79

" Cycle through folds easily
if &term == "screen-256color" "tmux sessions
  nmap <Esc>[1;2A zk
  nmap <Esc>[1;2B zj
  nmap <Esc>[1;2D zc
  nmap <Esc>[1;2C zo
else
  nmap <S-UP> zk
  nmap <S-DOWN> zj
  nmap <S-LEFT> zc
  nmap <S-RIGHT> zo
endif

" Navigation
nmap <Space> <C-F>
nmap <BS> <C-B>

" <cword> permet de désigner le mot sous le curseur.
" :map <C-W> :!lynx http://fr.wikipedia.org/wiki/<cword><CR><CR>

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
