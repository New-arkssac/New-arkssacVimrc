" __  ____   ____     _____ __  __ ____   ____ 
"|  \/  \ \ / /\ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  \ \ / / | || |\/| | |_) | |    
"| |  | | | |    \ V /  | || |  | |  _ <| |___ 
"|_|  |_| |_|     \_/  |___|_|  |_|_| \_\\____|
"                                              

"Author:@New-arkssac
"
"
"==========Auto get plug.vim on first start vim==========
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


source $HOME/.config/nvim/test/test.vim

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set number "设置行号
set tabstop=4 " tab是4个空格
set shiftwidth=4
set tw=0
set indentexpr=
set textwidth=100
set softtabstop=2
set encoding=utf-8 " 设置utf8编码
set t_Co=256 " 采用256色
set backspace=indent,eol,start
"set relative number
set tags=./.tags,.tags,./**/.tags
set showcmd
set wildmenu
set wrap
set scrolloff=5
set sidescroll=20
set laststatus=2
set showmatch
set expandtab
set hlsearch
set incsearch
set smartcase
set ignorecase
set ttimeout
set ttimeoutlen=100
set updatetime=100
set shortmess+=c


let g:mapleader=" "

exec "nohlsearch"

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

noremap sk :e $MYVIMRC<CR>

""set termini colors
syntax on 

map ; :
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>
map <silent><LEADER>q :qa<CR>
map <silent><LEADER>sp :set spell!<CR>

map <silent>sl :set splitright<CR>:vsplit<CR>
map <silent>sh :set nosplitright<CR>:vsplit<CR>
map <silent>sk :set splitbelow<CR>:split<CR>
map <silent>sj :set nosplitbelow<CR>:split<CR>

map <silent><nowait><LEADER>j <C-w>j
map <silent><nowait><LEADER>k <C-w>k
map <silent><nowait><LEADER>h <C-w>h
map <silent><nowait><LEADER>l <C-w>l


map <silent><down> :res +5<CR>
map <silent><UP> :res -5<CR>
map <silent><left> :vertical resize+5<CR>
map <silent><right> :vertical resiz-5<CR>

noremap <nowait><LEADER>st :tabe<CR>
noremap <nowait><LEADER>si :+tabnext<CR>
noremap <nowait><LEADER>su :-tabnext<CR>

noremap <nowait><silent>H 5h
noremap <nowait><silent>J 5j
noremap <nowait><silent>K 5k
noremap <nowait><silent>L 5l
vnoremap <nowait><silent><C-y> "+y
noremap <nowait><silent><C-p> "+p
inoremap <nowait><silent><C-p> <ESC>"+pi

noremap <LEADER>f <Cmd>CocCommand explorer<CR>

inoremap ' ''<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
" inoremap <C-o> <ESC>ji

"==========Netrw==========
let g:netrw_altv = 1
let g:netrw_browse_split = 2
let g:netrw_liststyle = 3 
let g:netrw_banner = 1
let g:netrw_winsize = 20

inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" find <++> replace it
noremap <silent><LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
inoremap <silent><buffer>,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l

""coc-translator
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)

"" find error
nmap <silent><LEADER>= <Plug>(coc-diagnostic-prev) 
nmap <silent><LEADER>- <Plug>(coc-diagnostic-next)

" GOTO code navigation.
" nmap <silent>gd <Plug>(coc-definition)
" nmap <silent>gy <Plug>(coc-type-definition)
" nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent><nowait><LEADER>u :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

""Symbol rename
nmap <LEADER>rn <Plug>(coc-rename)

"==========Vista==========
noremap al :Vista finder fzf<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista#renderer#icons = {
  \ "subroutine": "\uf247", 
  \ "method": "\uf1b2", 
  \ "func": "\uf09a", 
  \ "variables": "\uf1b2", 
  \ "constructor": "\uf2b8",
  \ "field": "\uf1cb",
  \ "interfac": "\uf1e6",
  \ "type": "\uf173",
  \ "packages": "\uf1c4",
  \ "property": "\uf155",
  \ "implementation": "\uf111",
  \ "default": "",
  \ "augroup": "\uf248",
  \ "macro": "\uf196",
  \ "enumerator": "\uf175",
  \ "const": "\uf08d",
  \ "macros": "\uf047",
  \ "map": "\uf03a",
  \ "fields": "\uf056",
  \ "functions": "\uf09a",
  \ "enum": "\uf162",
  \ "function": "\u0192",
  \ "target": "\uf140",
  \ "typedef": "\uf174",
  \ "namespace": "\uf035",
  \ "enummember": "\uf063",
  \ "variable": "\uf1b2",
  \ "modules": "",
  \ "constant": "\uf08d",
  \ "struct": "\uf0e8",
  \ "types": "\uf174",
  \ "module": "",
  \ "typeParameter": "\uf174",
  \ "package": "\uf1c4",
  \ "class": "\uf085",
  \ "member": "",
  \ "var": "\uf1b2",
  \ "union": "\uf0ec"
  \ }

"==========fzf==========
noremap <silent><nowait><C-b> :Buffers<CR>
noremap <nowait><C-s> :Rg 
noremap <silent><nowait><F1> :Helptags<CR>

"==========undotree==========
nnoremap <nowait><LEADER>uu :UndotreeToggle<CR>
if has("persistent_undo")
   let target_path = expand('~/.config/nvim/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

"==========vim-gitgutter==========
nmap ]h <Plug>(GitGutterStageHunk)
nmap [h <Plug>(GitGutterUndoHunk)
nmap ghn :GitGutterDiffOrig<CR>
nmap ghp <Plug>(GitGutterPreviewHunk)


"==========vim-plug==========
call plug#begin('~/.config/nvim/autoload')

Plug 'brooth/far.vim'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-dadbod', {'on': 'DBUI'}
Plug 'kristijanhusak/vim-dadbod-ui', {'on': 'DBUI'}
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'puremourning/vimspector', {'for': ['c', 'python', 'go']}
Plug 'skywind3000/asynctasks.vim', {'for': ['c', 'python', 'go']}
Plug 'skywind3000/asyncrun.vim', {'for': ['c', 'python', 'go']}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'Yggdroot/indentLine'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

call plug#end()

source $HOME/.config/nvim/config/vimspector.vim
source $HOME/.config/nvim/config/asynctasks.vim

let g:coc_global_extensions = [
      \ 'coc-vimlsp',
      \ 'coc-clangd',
      \ 'coc-syntax',
      \ 'coc-json',
      \ 'coc-translator',
      \ 'coc-snippets',
      \ 'coc-explorer',
      \ 'coc-pyright',
      \ 'coc-go',
      \ 'coc-java',
      \ 'coc-sumneko-lua',
      \ 'coc-git',
      \ 'coc-stylua'
      \]

let g:airline_theme='onedark'
let g:onedark_termcolors=256
colorscheme onehalfdark
highlight Search cterm=italic,bold,underline ctermbg=247
highlight IncSearch cterm=italic,bold,underline ctermbg=247
highlight Visual term=reverse cterm=italic,bold
highlight Pmenu ctermfg=247 ctermbg=236 guibg=#dcdfe4
highlight Pmenusel ctermbg=239 guibg=#474e5d
