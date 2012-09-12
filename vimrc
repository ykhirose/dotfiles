" Buck's vimrc
" ------------
"
" Installed plugins:
"
"    plugin name      short description
"    --------------------------------------------------------------------------
"
"   Simple plugins (one script in the plugin/ dir)
"   * a.vim           Easy switching between header and source files
"   * MRU             Remembers recently visited files to open quickly
"   * rename          Allows renaming of files by doing :rename <file>
"   * pathogen        Plugin path manager (for bundling plugins)
"   * visualmark      Visualize marks (type 'mm')
"
"   Simple ftplugins (one script in the ftplugin/ dir)
"   * nsh
"   * phpfolding
"   * xml             Contains function for pretty XML printing
"
"   Bundled plugins
"   * bufexplorer     Buffer explorer
"   * clojure         Clojure highlighting, indenting, etc.
"   * CtrlP           Fuzzy Finder
"   * delimitMate     Auto complete brackets, etc.
"   * fugitive        Git wrapper
"   * NERDTree        Provides a way to peruse directories
"   * OmniCppComplete C++ Omni-Complete
"   * protodef        Creates skeleton C++ source files based on header files
"   * racket          Highlight, indenting, etc. for Racket language
"   * snipMate        Snippets!
"   * supertab
"   * surround        Surround text with tags, quotes, etc.
"   * taglist         CTags explorer for viewing all tags in open files
"   * tcomment        Quickly comment out lines or selections

call pathogen#infect()

" basic settings --------------------------------------------------------------
set nocompatible " not vi-compatible
set rnu " shows relative line numbers
set bs=2 " needed on Windows for backspace to work properly

" tab settings ->
set autoindent " Uses indent from current line as indent for new line
set expandtab " Expands tab into spaces
set smarttab " Allows deleting of full tab at beginning of lines when it's turned into spaces
set shiftwidth=4
set softtabstop=4
" <-

set laststatus=2

set hidden " only hide buffers when switching (don't close them which erases undo)

" Visual whitespace
set list
set listchars=tab:>\ ,trail:.

set visualbell " Stops the 'ding' heard all the time

" searching
set incsearch " incremental search (i.e. search while typing)
set hlsearch  " highlight searched text
set ignorecase " ignore case on searches
set smartcase " override ignorecase when search term has uppercase in it

set mouse=a " enables mouse use in all modes
syntax enable " enables syntax highlighting
filetype on " enables filetype detection
filetype plugin on

" change <leader> to a comma
let mapleader = ","

" jump to last position on previous close
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" ensure visual whitespace is being shown
autocmd BufEnter * set list

" automatically open and close the popup menu / preview window
" from: http://vim.wikia.com/wiki/C%2B%2B_code_completion
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menu,menuone,longest,preview
set complete-=t,i

" other stuff -----------------------------------------------------------------
" From http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns/235970#235970
set colorcolumn=80

" set cursorline
" highlight CursorLine guibg=#FFE0F7
" highlight CursorColumn guibg=#FFE0F7
nnoremap <Leader>l :set cursorline!<CR>
nnoremap <Leader>c :set cursorcolumn!<CR>

" general key mappings --------------------------------------------------------
" Change 'Y' to copy to end of line to be similar to D and C
nnoremap Y y$

" Keys for more efficient saving
nnoremap <F11> :w<CR>
nnoremap <F12> :wa<CR>

" line movement mappings from http://vim.wikia.com/wiki/Moving_lines_up_or_down
" Use Alt-j or Alt-k to move lines up or down, respectively
nnoremap <A-j> :m+<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
nnoremap <A-k> :m-2<CR>==
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-k> :m-2<CR>gv=gv

" Map Ctrl+Del in insert mode to delete back a word
inoremap <C-BS> <C-w>

" Proper Ctrl+C -> Esc map
map <C-c> <Esc>

" Tab movements
nnoremap <F5> :tabm<CR>
nmap <C-S-PageUp> :tabm tabpagenr()-1<CR>
nmap <C-S-PageDown> :tabm tabpagenr()+1<CR>

" Mapping to auto-format the entire document and return
" to original position
nnoremap <F8> mzgggqG`z

" Remove trailing whitespace
nmap <Leader>w :%s/\s\+$//<CR>

" -----------------------------------------------------------------------------
" Plugin settings and mappings
" -----------------------------------------------------------------------------

" Tips for getting header/source switch came from
" http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
" mappings for a.vim
nnoremap <F4> :A<CR>

" NERDTree settings and mappings
let NERDTreeIgnore=['\.swp$', '\.orig$', '\.pyc$', '\.class$', '__pycache__',
                \   '\.swo$']
let NERDTreeChDirMode=2 " set the CWD whenever NERDTree root changes
let NERDTreeShowHidden=1 " show hidden files
" mapping to open NERDTree
nnoremap <F3> :NERDTreeToggle<CR>
" find the current file in NerdTree
map <leader>r :NERDTreeFind<CR>

" supertab -------------------------------------------------------------------
" kick off supertab with space
" leave tab controls to delimitMate
let g:SuperTabMappingForward = '<C-Space>'
let g:SuperTabMappingBackward = '<S-C-Space>'
" don't map <CR> as it's causing conflicts with delimitMate's expand CR
let g:SuperTabCrMapping = 0

" OmniCppComplete settings ---------------------------------------------------
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::o

" delimitMate ----------------------------------------------------------------
let delimitMate_expand_cr=1 " Expand carriage return
let delimitMate_expand_space=1 " Expand spaces
imap <Tab> <Plug>delimitMateS-Tab
imap <S-Tab> <Plug>delimitMateJumpMany

" ctrlp ----------------------------------------------------------------------
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$\|build$',
    \ }
let g:ctrlp_by_filename = 1 " default to filename search instead of full path

" taglist --------------------------------------------------------------------
let Tlist_Use_Right_Window = 1 " place taglist window on the right
let Tlist_Display_Prototype = 1 " show prototypes instead of tags
" mapping to open taglist
nmap <F6> :TlistToggle<CR>

" snipMate--------------------------------------------------------------------
" be able to reload snippets from:
" http://code.google.com/p/snipmate/issues/detail?id=67
function! ReloadSnippets(snippets_dir, ft)
    if strlen(a:ft) == 0
        let filetype = "_"
    else
        let filetype = a:ft
    endif
    call ResetSnippets()
    call GetSnippets(a:snippets_dir, filetype)
endfunction
nmap ,m :call ReloadSnippets(snippets_dir, &filetype)<CR>