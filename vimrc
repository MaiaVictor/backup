"folding
"set foldmethod=indent

set foldmethod=expr
set foldexpr=GetPotionFold(v:lnum)
set foldminlines=0
"set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
set foldopen=mark " what movements open folds

function! s:NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1
    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif
        let current += 1
    endwhile
    return -2
endfunction

function! s:IndentLevel(lnum)
    if &ft == 'chaos'
        if (a:lnum == 1)
            return 0
        else
            return (getline(a:lnum)=~?'\v^::' ? 0 : indent(a:lnum) / &shiftwidth + 1)
        endif
    else
        
        return indent(a:lnum) / &shiftwidth + (getline(a:lnum)=~?'^\s*}' ? 1 : 0)
    endif
endfunction

function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif
    let this_indent = <SID>IndentLevel(a:lnum)
    let next_indent = <SID>IndentLevel(<SID>NextNonBlankLine(a:lnum))
    let prev_indent = <SID>IndentLevel(<SID>PrevNonBlankLine(a:lnum))
    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

function! NeatFoldText()
    "let line = substitute(getline(v:foldstart), '^f', '')
    "let line = substitute(getline(v:foldstart), '\t', '    ', 'g')
    let line = getline(v:foldstart)
    "let line = substitute(getline(v:foldstart), 'foo', 'faa')
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = ' '
    let foldtextstart = strpart(line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 6)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
    "return repeat('  ',v:foldlevel) . foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

hi Folded ctermbg=231 ctermfg=2
hi FoldColumn ctermbg=white ctermfg=darkred

"let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
"let foldchar = matchstr(&fillchars, 'fold:\zs.')
"let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)

set ttyfast
"set nofoldenable
set ttyscroll=3
set lazyredraw
set hidden
set wrap      
set autoread
"set smartindent
set tabstop=4     " a tab is four spaces 
set expandtab     " 
set backspace=indent,eol,start " allow backspacing over everything in insert mode 
set autoindent    " always set autoindenting on 
set number        " always show line numbers 
set shiftwidth=4  " number of spaces to use for autoindenting 
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>' 
set showmatch     " set show matching parenthesis 
set ignorecase    " ignore case when searching 
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise 
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 
set hlsearch      " highlight search terms 
set incsearch     " show search matches as you type 
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set noswapfile

set nocompatible
set viminfo='1000,f1,<500,:100,/100,h  "
set shortmess=atl " no annoying start screen
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0


imap → ->


" CtrlP stuff
"let g:ctrlp_default_input = '^'
"let g:ctrlp_max_depth = 1
"let g:ctrlp_max_files = 2000
"let g:ctrlp_regexp = 1
"let g:ctrlp_match_window_bottom = 0
"let g:ctrlp_by_filename = 1
"let g:ctrlp_switch_buffer = 0
"map <leader>x cal ctrlp#exit()
:map <expr> <space> ":CtrlP ".getcwd()."<cr>"
":map <expr> & ":CtrlP ".getcwd()."<cr>"
:set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.hi,*.o,*.js_hi,*.js_o,*/.git/*,*/elm-stuff/*,*/sprites/* " MacOSX/Linux

":map z :!clear;

" I never use marks
:map m %

:noremap j gj
":noremap <expr> <leader>h foldlevel(line(".") + 1) ? 'normal! hzO' : 'normal! h'
":noremap <expr> <leader>h (foldlevel(line(".") + 1) ? ':normal! hzO<cr>' : ':normal! h<cr>')
":noremap <expr> <leader>l (foldlevel(line(".") + 1) ? ':normal! lzO<cr>' : ':normal! l<cr>')
:noremap k gk


:nnoremap <expr> <leader>w ':w!<cr>:!clear;browserify --fast -d main.js -o app/main.js; osascript ~/Viclib/osx/chromereload.scpt &<cr><esc><esc>'


:nnoremap <expr> <leader>b ':!clear<cr>:w!<cr>:!gulp<cr>:!osascript ~/Viclib/osx/chromereload.scpt &<cr>'

" Compile/run stuff

:nnoremap <expr> r ':!clear<cr>:w!<cr>'.(
    \ &ft=='lambda'     ? ':!time lambda % --haskell --bruijn --expand --normalize --verbose --stats --javascript main<cr>' :
    \ &ft=='ocaml'      ? ':!ocamlc -o %:r %<cr>:!./%:r<cr>' :
    \ &ft=='factor'     ? ':!~/factor/factor %<cr>' :
    \ &ft=='python'     ? ':!time python %<cr>' :
    \ &ft=='scheme'     ? ':!csc %<cr>:!time ./%:r<cr>' :
    \ &ft=='elm'        ? '<esc>:!clear<cr>:w!<cr>:!elm % -r elm-runtime.js<cr>:!osascript ~/Viclib/osx/chromereload.scpt &<cr>' :
    \ &ft=='racket'     ? ':!racket %<cr>' :
    \ &ft=='haskell'    ? ':!ghc -outputdir bin -o bin/%:r %<cr>:!time ./bin/%:r<cr>' :
    \ &ft=='dvl'        ? ':!dvl run %<cr>' :
    \ &ft=='javascript' ? ':!time node %<cr>' :
    \ &ft=='idris'      ? ':!idris % -o %:r<cr>:!./%:r<cr>' :
    \ &ft=='c'          ? ':!clang -O3 -L/System/Library/Frameworks -Wall % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='cuda'       ? ':!rm %:r; nvcc -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='cpp'        ? ':!clang++ % -o %:r<cr>:!./%:r<cr>' :
    \ &ft=='agda'       ? ':!agda % -o %:r<cr>:!./%:r<cr>' :
    \ &ft=='ls'         ? ':!lsc -c %<cr>:!node %:r.js<cr>' :
    \ &ft=='lispell'    ? ':!node ~/Viclib/lispedia/bin/lis.js reduce %:r<cr>' :
    \ ':!lsc -c %<cr>:!node %:r.js<cr>')

    "\ &ft=='c'          ? ':!clang -O3 -L/System/Library/Frameworks -framework GLUT -framework OpenGL -Wall % -o %:r<cr>:!time ./%:r<cr>' :
":nnoremap <expr> <leader>m ':!clear<cr>:w!<cr>:!make<cr>:!time ./%:r<cr>'
":nnoremap <expr> R ':!clear<cr>:w!<cr>:!ghc -outputdir bin -O2 -threaded -rtsopts -funfolding-use-threshold10000 -funfolding-keeness-factor1000 -optlo-O3 -fllvm -o %:r %<cr>:!time ./%:r +RTS -N4<cr>'
:nnoremap <expr> R ':!clear<cr>:w!<cr>:!ghc -outputdir bin -O2 -fllvm -o bin/%:r %<cr>:!time ./bin/%:r<cr>'





:nnoremap <expr> <leader>r ':!clear<cr>:w!<cr>:!runghc -i$HOME/Viclib/Haskell %<cr>'
:nnoremap <expr> <leader>g ':!clear<cr>:w!<cr>:!ghcjs -i$HOME/Viclib/Haskell -fforce-recomp -O2 -rtsopts -funfolding-use-threshold10000 -funfolding-keeness-factor1000 -optlo-O3 -threaded -o %:r.js %<cr>:!time node ./%:r.js/all.js<cr>:!rm %:r.js_o; rm %:r.js_hi<cr>'

"NERDTree stuff
:let NERDTreeIgnore = ['\.hi$','\.o$','\.js_o$','\.js_hi$']
:let NERDTreeChDirMode = 2
:nmap <expr> <enter> v:count1 <= 1 ? "<C-h>C<C-w>p" : "@_<C-W>99h". v:count1 ."Go<C-w>l"
au VimEnter * NERDTree
au VimEnter * set nu
au VimEnter * wincmd l

"au VimEnter * wincmd p
:nmap <expr> <leader>t ":ClearCtrlPCache<cr>:NERDTree<cr>:set nu<cr><C-w>l"
"autocmd BufEnter * silent! if bufname('%') !~# 'NERD_tree_' | cd %:p:h | NERDTreeCWD | wincmd p | endif
"map <leader>r :NERDTreeFind<cr>

" Can I solve the ESC out of home problem?
:inoremap ☮ <esc>
:vnoremap ☮ <esc>
:cnoremap ☮ <esc>


" tagbar
":autocmd VimEnter * TagbarToggle

" shared clipboard
:set clipboard=unnamed,unnamedplus,autoselect


" ConqueTerm
":nmap <expr> <leader>c ":sp<cr>12<C-w>+99<C-w>j:ConqueTerm bash<cr>"
":nnoremap <leader>r 10<C-w>jaclear<cr>sudo node server 80<cr><esc><C-w>p

" PBufferWindows
:map <left> 4<C-w><
:map <right> 4<C-w>>
:map <up> 4<C-w>-
:map <down> 4<C-w>+
:noremap <C-j> <esc><C-w>j
:noremap <C-k> <esc><C-w>k
:noremap <C-h> <esc><C-w>h
:noremap <C-l> <esc><C-w>l
:map! <C-j> <esc><C-w>j
:map! <C-k> <esc><C-w>k
:map! <C-h> <esc><C-w>h
:map! <C-l> <esc><C-w>l

" Change Color when entering Insert Mode
hi cursorline cterm=none ctermbg=white
au InsertEnter * set cursorline
au InsertLeave * set nocursorline

" vim-ls
call pathogen#runtime_append_all_bundles()
hi link lsSpaceError NONE
hi link lsReservedError NONE

" Vim can automatically change the current working directory to the directory where the file you are editing lives. 
" set autochdir*/

" space to enter command
" :nnoremap <space> :
:syntax on

" cursor always in middle of screen
:set so=99999

:map , <leader>

" join
:nnoremap <leader>j J

" default the statusline to green when entering Vim
hi StatusLine ctermfg=lightblue ctermbg=black
hi StatusLineNC ctermfg=lightgray ctermbg=black
hi VertSplit ctermfg=lightgray ctermbg=black



" NERDComment
:map ! <leader>c<space>

" d/ to unhighlight search matches
:nnoremap d/ :nohl<cr>

" R to search&replace
" :nnoremap R :%s/*/

" macros
:nnoremap q qa<esc>
:nnoremap Q @a

" vimrc autosave
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so ~/.vim/.vimrc "$MYVIMRC
augroup END
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" previous and next location
:nnoremap <C-u> <C-o>
":nnoremap <C-i> <C-i>

" easymotion
":nmap f <leader><leader>f
":vmap f <leader><leader>f
":omap f <leader><leader>f
":nmap f /
":vmap f /
":omap f /
":nmap f /
":vmap f /
":omap f /


" MARKS SHORTCUTS, LIST OF MARKS
":nnoremap <leader>m `
":nnoremap <leader>M m
":nnoremap <leader>, :marks abcdefghijklmnopqrstuvwxyz<cr>

" quit
:map <leader>q :xa!<cr>

" navigates through marks (if exist), if not, moves fast
:nnoremap <S-j> 6gj
:nnoremap <S-k> 6gk
:vnoremap <S-j> 6gj
:vnoremap <S-k> 6gk

" line join (because <S-j> is taken)
:nnoremap <leader>j J

" go to previous location
:nmap <D-h>    <C-o>

" :inoremap <S-space> <tab>
:nmap ( <<
:nmap ) >>
:nmap <tab> >>
:nmap <S-tab> << 
:map U <C-r>
:nmap <C-j> <C-w>j
:nmap <C-k> <C-w>k
:nmap <C-l> <C-w>l
:nmap <C-h> <C-w>h

" begin/end of line
:nnoremap H ^
:nnoremap L $
:vnoremap H ^
:vnoremap L $

" idris ft
"au BufNewFile,BufRead *.ls set filetype=Livescript
au BufNewFile,BufRead *.chaos set filetype=chaos
au BufNewFile,BufRead *.chaos set syntax=javascript
au BufNewFile,BufRead *.idr set filetype=idris
au BufNewFile,BufRead *.lc set filetype=lambda
au BufNewFile,BufRead *.lc set syntax=elm
au BufNewFile,BufRead *.agda set filetype=agda
au BufNewFile,BufRead *.dvl set filetype=dvl
au BufNewFile,BufRead *.lis set filetype=lispell
au BufNewFile,BufRead *.lscm set filetype=lispell
"filetype plugin on

" C++11 syntax
au BufNewFile,BufRead *.cpp set syntax=cpp11

" More fold stuff
":nnoremap <Bar> zO
":nnoremap ∘ zc
:nnoremap + zr:echo 'foldlevel: ' . &foldlevel<cr>
:nnoremap - zm:echo 'foldlevel: ' . &foldlevel<cr>
:nnoremap <leader>f zO
:nnoremap <leader>d zo
:nnoremap <leader>s zc
:nnoremap <leader>a zC
":nnoremap <leader>z :%s/\t/    /g<cr>

" relative lines on/off
nnoremap <silent><leader>n :set relativenumber!<cr>

":map <leader>x :x<cr>
:map <leader>v :source ~/.vimrc<cr>:nohl<cr>:echo 'reloaded .vimrc'<cr>
:map <leader>e :w!<cr>:!node chaos.js<cr>:e!<cr>:echo 'done'<cr>
":map <leader>w <cr>:!node chaos.js -r expand("<cword>")<cr>:e!<cr>
:map <leader>h :w!<cr>:!clear;hlint %<cr>
:map <leader>p :w!<cr>:!clear;ghc -O2 --make % -prof -auto-all -caf-all -fforce-recomp;time ./%:r +RTS -p<cr>:e %:r.prof<cr>zR<cr>
:map <leader>C :w!<cr>:!clear;java -jar ~/bin/compiler.jar --compilation_level ADVANCED_OPTIMIZATIONS --js % > %:r.min.js<cr>:e %:r.min.js<cr>
:unmap <C-i>
"au BufEnter *.hs compiler ghc

" open GHCI
":map <leader>m :w!<cr>:!tmux send-keys :cmd Space return Space $ Space unlines Space [\":reload\",\":!clear\",\":main\"] Enter; tmux attach<cr>
:map <leader>n :!tmux new-session -d -s ghci ghci rays.o; tmux send-keys :load Space all.hs Space Tmux Enter import Space Tmux Enter<cr>
":map <leader>m :w!<cr>:!clear<cr>:!tmux send-keys :\!clear Enter :r Enter main Enter d; tmux attach<cr>
":map <leader>g :w!<cr>:!clear<cr>:!tmux send-keys Enter :r Enter; tmux attach<cr>
":map <leader>e :w!<cr>:!clear<cr>:!tmux send-keys :\!clear Enter :r Enter :\!clear Enter <cword> Enter d; tmux attach<cr>
":map <leader>t :w!<cr>:!clear<cr>:!tmux send-keys :\!clear Enter :r Enter :\!clear Enter :t Space <cword> Enter d; tmux attach<cr>


:map <leader>m :w!<cr>:!ghci -i$HOME/Viclib/haskell %<cr>

":set comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,:--
:set comments+=:--


:let g:haddock_docdir="/nix/store/5d76fg657kgm3rwq4pjyvqcwrsf90ll3-ghc-7.4.2-binary/share/doc/ghc/html"
set undofile
set undodir=~/.vim/undo
set foldlevel=0
au Syntax * normal zR

set formatoptions=cql
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction
