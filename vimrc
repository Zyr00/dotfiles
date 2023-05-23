" ---------------------- CONFIGURATION ----------------------
set nocompatible
syntax on
set nu rnu

" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on

" better settings
set autoread
set cmdheight=2
set updatetime=300
set signcolumn=number

" encoding
set encoding=utf-8
set fileencoding=utf-8

runtime macros/matchit.vim

" delete over line breaks
set backspace=indent,eol,start

" don't unload buffers 4hen they are abandoned, instead stay in the background
set hidden

" set u nix line endings
set fileformat=unix
set fileformats=unix,dos

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" not redrawn while running macros
set lazyredraw

" set , as mapleader
let mapleader = ","

" map <leader>q and <leader>w to buffer prev/next buffer
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

set spelllang=pt,en
noremap <leader>s :set spell!<CR>

" copy to clipboard without prepending "* to commands
vmap <c-c> :!xclip -f -sel clip

" allow Tab and Shift+Tab to
" tab selection in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" remove the .ext~ files, but not the swapfiles
set nobackup
set nowritebackup
set noswapfile

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default

" use ESC ESC to remove search higlight
nnoremap <esc><esc> :noh<return><esc>

" Auto completion
set wildmode=longest,list,full

" keep the cursor visible within 4 lines when scrolling
set scrolloff=4

" indentation
set expandtab       " use spaces instead of tabs
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set shiftwidth=2    " when reading, tabs are 2 spaces
set softtabstop=2   " in insert mode, tabs are 2 spaces"

autocmd Filetype java setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype ts setlocal ts=4 sw=4 sts=0 expandtab

" folds
set foldmethod=syntax   " syntax highligting items specify folds
set foldcolumn=1        " defines 1 col at window left, to indicate folding
set foldlevelstart=99   " start file with all folds opened

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Auto compile on save
map <leader>a :!setsid autocomp % &<CR>
" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !~/.local/scripts/compiler <c-r>%<CR>
" Open corresponding .pdf/.html or preview
map <leader>p :!~/.local/scripts/opout <c-r>%<CR><CR>

" Navigating with guides
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l


" --------------------- LaTeX CONFIGURATION ----------------------
" Code snippets
autocmd FileType tex inoremap ,doc \begin{document}<Enter><Enter><++><Enter><Enter>\end{document}<Esc>2kf}i
autocmd FileType tex inoremap ,p \paragraph{}
autocmd FileType tex inoremap ,fi \begin{figure}<Enter><Enter>\end{figure}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap ,eq \begin{equation}<Enter>\centering<Enter>\end{equation}<Enter><Enter><++><Esc>3k$o
autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i}}} }`}`}
autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,li \item<Space>
autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i

" ---------------------- PLUGIN CONFIGURATION ----------------------
" initiate Vundle
let &runtimepath.=',$HOME/.vim/bundle/Vundle.vim'

call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins definition
Plugin 'scrooloose/nerdtree'

" Plugins for dev
Plugin 'ap/vim-css-color'

" Autocomplete
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'lervag/vimtex'
Plugin 'mattn/emmet-vim'

" Theme
Plugin 'vim-airline/vim-airline'
Plugin 'drewtempelmeyer/palenight.vim'

call vundle#end()            " required for vundle

" Nerdtree
nnoremap <leader>t :NERDTreeToggle<CR>

" Coc
inoremap <silent><expr> <c-@> coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" vim emmet
" let g:user_emmet_leader_key = ';'
let g:user_emmet_settings = {
      \  'php' : {
      \    'extends' : 'html',
      \    'filters' : 'c',
      \  },
      \  'xml' : {
      \    'extends' : 'html',
      \  },
      \  'haml' : {
      \    'extends' : 'html',
      \  },
      \}

" vim airline
let g:airline#extensions#coc#enabled = 1

" Theme
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
let g:enable_italic_font = 1
let g:enable_bold_font = 1
set background=dark
colorscheme palenight
let g:airline_theme = "palenight"
let g:palenight_terminal_italics=1
" hi Normal guibg=NONE ctermbg=NONE
