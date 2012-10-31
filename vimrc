set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Git wrapper
Bundle 'tpope/vim-fugitive'

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'

" Move easily with <leader><leader>w
Bundle 'Lokaltog/vim-easymotion'

" Ruby syntax files, etc.
Bundle 'vim-ruby/vim-ruby'

" vim-scripts repos
"Bundle 'vim-scripts/Align.git'

Bundle 'spf13/vim-colors.git'

Bundle 'Auto-Pairs'
"let g:AutoPairsShortcutToggle = "<LEADER>p""

Bundle 'matchit.zip'
" Bundle 'neocomplcache'
" Bundle 'neocomplcache-snippets_complete'
" Bundle 'Syntastic'
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

" vim-snipmate alternative
Bundle "https://github.com/SirVer/ultisnips.git"
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<TAB>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsListSnippets="<S-F8>"

" Setting this variable allows me to override the default snippets with a bang!
" Otherwise the default snippets still show up.
let g:UltiSnipsDontReverseSearchPath="1"

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
"
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
" First test the keymap
" place 'stty -ixon' in bashrc first, to use <C-S>
" map <C-S> :echo 'c-s ok'<CR>
" check the value inside vim with :echo g:tcommentMapLeader1
" let g:tcommentMapLeader1 = '<C-S>'
" let g:tcommentMapLeader1 = '<F6>'
" noremap <C-S> <C-_>
" map <C-C> :echo 'c-c ok'<CR>
"
 
Bundle 'The-NERD-Commenter'

" Single click to open filepath elements
let NERDTreeMouseMode = 2
map <C-T> :NERDTreeToggle<CR>

autocmd FileType ruby let b:vimpipe_command="ruby"

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

let mapleader = ","

" Allow mouse use. This enables click select in normal mode + NERDTree click
if has('mouse')                                            " Enable mouse in terminal, just in normal mode
  set mouse=a
endif

" Not sure what this one does anymore
set backspace=indent,eol,start whichwrap+=<,>,[,]

inoremap <C-O> <C-O>o
inoremap <C-A> <HOME>
inoremap <C-E> <END>
inoremap <C-J> <DOWN>
inoremap <C-K> <UP>
inoremap <C-H> <LEFT>
inoremap <C-L> <RIGHT>


" NERDCommenter will add space after comment
let NERDSpaceDelims = 1

map <F3> :call NERDComment(0, 'uncomment')<CR>+
map <S-F3> -:call NERDComment(0, 'uncomment')<CR>
map <F4> :call NERDComment(0, 'norm')<CR>+
map <S-F4> -:call NERDComment(0, 'norm')<CR>
imap <F4> <ESC>:call NERDComment(0, 'insert')<CR><ESC>==$xA

noremap <F1> :q<cr>
noremap <S-F1> :qa!<cr>

" Normal mode & save
nmap <F5> :w<cr>:echo "File succesfully saved at" strftime("%H:%M:%S")<cr>
imap <F5> <esc>:w<cr>:echo "File succesfully saved at" strftime("%H:%M:%S")<cr>
imap <C-S> <F5>
map <C-S> <F5>

" Cycle quickly through buffers
map <s-left> :bp<cr>
map <s-right> :bn<cr>
map <s-up> :ls<cr>:b
" This is the same like the built-in <C-S-6> shortcut
map <s-down> :b#<cr>

" Swap those keys
nnoremap , ;
nnoremap ; ,

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

autocmd bufNewfile *.html 0r ~/.vim/my_skels/skel.html

autocmd bufEnter *.txt set tw=79

" Cycle through folds easily
nmap <c-up> zk
nmap <c-down> zj
nmap <c-left> zc
nmap <c-right> zo

" Navigation
nmap <space> <c-f>
nmap <BS> <c-b>

" <cword> permet de désigner le mot sous le curseur.
" :map <C-W> :!lynx http://fr.wikipedia.org/wiki/<cword><CR><CR>
