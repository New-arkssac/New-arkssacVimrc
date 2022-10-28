" __  ____   ____     _____ __  __ ____   ____ 
"|  \/  \ \ / /\ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  \ \ / / | || |\/| | |_) | |    
"| |  | | | |    \ V /  | || |  | |  _ <| |___ 
"|_|  |_| |_|     \_/  |___|_|  |_|_| \_\\____|
"                                              

"Author:@New-arkssac
"

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set number "设置行号
set tabstop=2 " tab是4个空格
set shiftwidth=2
set tw=0
set indentexpr=
set softtabstop=2
set encoding=utf-8 " 设置utf8编码
set t_Co=256 " 采用256色
set backspace=indent,eol,start
""set relativenumber
set tags=./.tags,.tags,./**/.tags
set showcmd
set wildmenu
set wrap
set scrolloff=5
set laststatus=2
set showmatch
set expandtab
set hlsearch
set incsearch
set smartcase
set ignorecase
set updatetime=100
set shortmess+=c


let g:mapleader=" "
let @q='j'
let @w='j'

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
map <LEADER>q :qa<CR>
map <LEADER>bn :buffers<CR>
map <LEADER>n :bmodified<CR>
map <LEADER>sp :set spell!<CR>

map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set splitbelow<CR>:split<CR>
map sj :set nosplitbelow<CR>:split<CR>

map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l


map  <down> :res -5<CR>
map  <UP> :res +5<CR>
map  <left> :vertical resize-5<CR>
map  <right> :vertical resiz+5<CR>

noremap <LEADER>st :tabe<CR>
noremap <LEADER>si :+tabnext<CR>
noremap <LEADER>su :-tabnext<CR>

noremap H 5h
noremap J 5j
noremap K 5k
noremap L 5l

noremap <LEADER>f <Cmd>CocCommand explorer<CR>

inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap <C-K> <ESC>A
inoremap <C-o> <ESC>o

source $HOME/.vim/config/vimspector.vim

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

" CheckProjectFile
function CheckProjectFile(NAME)
  if has(a:NAME) != 0
    return " ".a:NAME." No such file or directory"
  else
    return " ".a:NAME." Done"
  endif
endfunction

" find <++> replace it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>"_c4l

""coc-snippets
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ CheckBackSpace() ? "\<TAB>" :
                  \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    
    let g:coc_snippet_next = '<tab>'

""coc-translator
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)

"" find error
nmap <silent><LEADER>- <Plug>(coc-diagnostic-prev) 
nmap <silent><LEADER>= <Plug>(coc-diagnostic-next)

" GOTO code navigation.
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gi <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <LEADER>u :call ShowDocumentation()<CR>

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
noremap <C-b> :Buffers<CR>
noremap <C-k> :Files<CR>
noremap <C-f> :Rg<CR>
noremap <F1> :Helptags<CR>

"==========undotree==========
nnoremap <LEADER>uu :UndotreeToggle<CR>
if has("persistent_undo")
   let target_path = expand('~/.vim/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

"==========vim-gitgutter==========
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap ghn :GitGutterDiffOrig<CR>
nmap ghp <Plug>(GitGutterPreviewHunk)

call plug#begin('~/.vim/autoload')

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-dadbod', {'on': 'DBUI'}
Plug 'kristijanhusak/vim-dadbod-ui', {'on': 'DBUI'}
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'puremourning/vimspector', {'for': ['c', 'python']}
Plug 'skywind3000/asynctasks.vim', {'for': ['c', 'python']}
Plug 'skywind3000/asyncrun.vim', {'for': ['c', 'python']}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

call plug#end()

let g:coc_global_extensions = [
      \ 'coc-vimlsp',
      \ 'coc-clangd',
      \ 'coc-syntax',
      \ 'coc-json',
      \ 'coc-translator',
      \ 'coc-snippets',
      \ 'coc-explorer',
      \ '@yaegassy/coc-pylsp'
      \]

let g:airline_theme='onehalfdark'

colorscheme onehalfdark
let g:indentLine_enabled = 1

autocmd FileType c,cpp,python,vim :call SourceFile()

function SourceFile() abort
  source $HOME/.vim/config/asynctasks.vim
  if &filetype == 'c' || &filetype == 'cpp'
    source $HOME/.vim/config/CProject.vim
  elseif &filetype == 'python'
    source $HOME/.vim/config/PyProject.vim
  elseif &filetype == 'vim'
    source $HOME/.vim/config/VimProject.vim
  endif
  
endfunction
