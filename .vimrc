" -----------------------------------------------------------------------------
" Preface
" -----------------------------------------------------------------------------
"
" My personal vim configuration. Personal fan of using default keys and vim
" over neovim due to it covering my needs and default available on most
" distros. Also, I prefer having everything in one file and use folding or
" voom.
"
" TODO: check plugins https://github.com/gerardbm/vimrc?tab=readme-ov-file
"
" -----------------------------------------------------------------------------
" Prerequisites  
" -----------------------------------------------------------------------------
"
" apt-get install vim vim-gtk3 \
" 	exuberant-ctags \
" 	vim-addon-manager \
" 	vim-youcompleteme
"
" vim-addon-manager install youcompleteme
"
" https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Remember to :PlugInstall or :PlugUpdate

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------
"
" -----------------------------------------------------------------------------
" > Plugin manager
" -----------------------------------------------------------------------------
call plug#begin()

Plug 'dense-analysis/ale'		" linter
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'		" git (:Git)
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'
"Plug 'SirVer/ultisnips' 		" (installed using vim-addons)
Plug 'honza/vim-snippets'
Plug 'altercation/vim-colors-solarized'
Plug 'bronson/vim-trailing-whitespace'	" show trailing whitespace
Plug 'vim-voom/VOoM'			" outliner
Plug 'VundleVim/Vundle.vim'

call plug#end()

" -----------------------------------------------------------------------------
" > common plugin settings 
" -----------------------------------------------------------------------------

filetype plugin indent on
syntax enable

" -----------------------------------------------------------------------------
" > cscope
" -----------------------------------------------------------------------------
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

" Tips:
" -----
":cs f s <c-symbol>
":cs f g <definition>
":cs f d <func called by this function>
":cs f c <func calling this function>
":cs f t <text string>
":cs f e <egrep pattern> 
":cs f f <file>
":cs f i <files including this file>
":cs show - show current cscope database
":cs help


" -----------------------------------------------------------------------------
" > ctags
" -----------------------------------------------------------------------------
" Use ctags -R .
"
" C-] = follow --> issues :tag <variable>
" g] = --> issues :tselect <variable>
" C-t = reverse
" 
" :tag main    = jumps to main
" :tag /ma*    = jumps (most likely) to main
" :t[select] 	= list over matched tags e.g. tag /ma*
" :tn[ext] 	=
" :tp[rev]
"
" " autocomplete
" use C-x C-] for full completion

"" File browsing
" :A 		switches *.c -> *.h and visa versa 
" :AS 		horizonal split and *.h above
" :AV   	vertical split *.h to the side 
" :AT   	*.h in a new tab 
" :IH 		switches to file under cursor
" :IHS 		splits and switches
" :IHV 		vertical splits and switches
" :IHT 		new tab and switches
" :IHN  	cycles through matches
" <Leader>ih 	as :IH 
" <Leader>is    as :IHS	
" <Leader>ihn   as :IHN	

"" buffers
" :wn[ext] 
" :next
" :first
"


" -----------------------------------------------------------------------------
" > nerdtree 
" -----------------------------------------------------------------------------
"
let g:nerdtree_tabs_open_on_console_startup=0
let g:NERDTreeWinSize=60

" -----------------------------------------------------------------------------
" > syntastic
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" > taglist
" -----------------------------------------------------------------------------

:let g:Tlist_WinWidth=60


" -----------------------------------------------------------------------------
" > ultisnippers
" -----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger 		= "<tab>"
let g:UltiSnipsJumpForwardTrigger 	= "<tab>"
let g:UltiSnipsJumpBackwardTrigger 	= "<s-tab>"
let g:UltiSnipsListSnippets             = "<C-k>" 


" -----------------------------------------------------------------------------
" > youcompleteme / ycm
" -----------------------------------------------------------------------------
" Use C-Space for complete list of tags available
let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_ultisnippedentifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in stringr
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'



" -----------------------------------------------------------------------------
" Work settings
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" > C programming
" -----------------------------------------------------------------------------
autocmd FileType *.c setlocal expandtab shiftwidth=8 softtabstop=4
autocmd FileType *.h setlocal expandtab shiftwidth=8 softtabstop=4
autocmd FileType *.{c,h} setlocal omnifunc=ccomplete#Complete
autocmd FileType *.{c,h} set cindent
autocmd BufNewFile *.{hpp,h} 0r ~/scripts/c/template.h
autocmd BufNewFile *.{c,cpp,cxx,cc} 0r ~/scripts/c/template.c

" -----------------------------------------------------------------------------
" > cpp/c++ programming
" -----------------------------------------------------------------------------
"autocmd FileType cpp setlocal omnifunc=cppcomplete#Complete


" -----------------------------------------------------------------------------
" > Python programming
" -----------------------------------------------------------------------------
"autocmd FileType python set sw=4
"autocmd FileType python set ts=4
"autocmd FileType python set sts=4
"autocmd FileType python set et
"autocmd FileType python set ai
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" python/django
" In visual mode type Sv or S{ for a variable. Next is block, if statement
" with statement and comment. (does not work?)
"let b:surround_{char2nr("v")} = "{{ \r }}"
"let b:surround_{char2nr("{")} = "{{ \r }}"
"let b:surround_{char2nr("%")} = "{% \r %}"
"let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
"let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
"let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
"let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
"let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"

" Python PDB
"
" pip3 install vimpdb
" import vimpdb; vimpdb.set_trace()
"
" :PDBNext 	n 	pdb (n)ext
" :PDBStep 	s 	pdb (s)tep
" :PDBArgs 	a 	pdb (a)rgs
" :PDBUp 	u 	pdb (u)p
" :PDBDown 	d 	pdb (d)own
" :PDBReturn 	r 	pdb (r)eturn
" :PDBContinue 	c 	pdb (c)ontinue
" :PDBBreak 	b 	Sets a breakpoint at the line of the cursor
" :PDBClear 	B 	Clears a breakpoint at the line of the cursor
" :PDBWord 	w 	Evaluates the value of the identifier on the cursor
" :PDBEval 	? 	Evaluates a Python expression
" :PDBReset 	x 	Switch back to normal debugging in shell (standard pdb)
"  N/A 	        v(im) 	Switch back to vimpdb; only in plain pdb.

" no built-in python syntax folding.
autocmd FileType python set foldmethod=indent
autocmd FileType python set foldnestmax=2


" -----------------------------------------------------------------------------
" > css
" -----------------------------------------------------------------------------

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS


" -----------------------------------------------------------------------------
" > markdown
" -----------------------------------------------------------------------------

" Force markdown for .md files thus ignore module 2.
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

autocmd FileType markdown nnoremap <buffer> <F3> :VoomToggle markdown<CR>
autocmd FileType markdown let g:markdown_folding = 1
autocmd FileType markdown set foldlevel=1
autocmd FileType markdown set foldclose=all
autocmd FileType markdown set foldopen=all
"autocmd FileType markdown set foldmethod=syntax

" -----------------------------------------------------------------------------
" > html
" -----------------------------------------------------------------------------

autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags

" -----------------------------------------------------------------------------
" > javascript
" -----------------------------------------------------------------------------

autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS


" -----------------------------------------------------------------------------
" > json
" -----------------------------------------------------------------------------

autocmd FileType json setlocal ts=2 sw=2 expandtab

let g:vim_json_conceal=0 " disable quote concealing


" -----------------------------------------------------------------------------
" > xml
" -----------------------------------------------------------------------------

autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType xml let xml_syntax_folding=1


" -----------------------------------------------------------------------------
" > go / golang
" -----------------------------------------------------------------------------

autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
autocmd FileType go syntax on
autocmd FileType go filetype plugin indent on
autocmd FileType go set colorcolumn=80


" -----------------------------------------------------------------------------
" > Yaml
" -----------------------------------------------------------------------------

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml set foldmethod=indent
autocmd FileType yaml set nofoldenable
autocmd FileType yaml let g:indentLine_char = '⦙'



" -----------------------------------------------------------------------------
" > Terraform tsvars
" -----------------------------------------------------------------------------

autocmd FileType tfvars setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType tfvars set foldmethod=indent
autocmd FileType tfvars set nofoldenable


" -----------------------------------------------------------------------------
" > vimrc
" -----------------------------------------------------------------------------

" TODO: not working
let g:voom_ft_modes = {
    \ 'vim': {
    \   'level': 's',
    \   'pattern': '^\s*"\s*(\w+:)*',
    \   'syntax_match': '^\s*"\s*\(\w\+\):.*',
    \   'commentstring': '" %s',
    \   'filetype': 'vimrc'
    \ }
\ }


" -----------------------------------------------------------------------------
" > vimdiff 
" -----------------------------------------------------------------------------

if &diff
	colorscheme desert
endif


" -----------------------------------------------------------------------------
" Vim settings 
" -----------------------------------------------------------------------------

" General display
set number			" line numbers

" indent
set autoindent


" -----------------------------------------------------------------------------
" > bell
" -----------------------------------------------------------------------------

set visualbell
set t_vb=


" -----------------------------------------------------------------------------
" > clipboard
" -----------------------------------------------------------------------------
set clipboard=unnamedplus	" yank to + and *

" Windows Yank
" https://superuser.com/questions/1291425/windows-subsystem-linux-make-vim-use-the-clipboard
if has('win32') || has('win64')
	let g:clipboard = {
	\   'name': 'win32yank-wsl',
        \   'copy': {
	        \      '+': 'win32yank.exe -i --crlf',
        \      '*': 'win32yank.exe -i --crlf',
        \    },
        \   'paste': {
	        \      '+': 'win32yank.exe -o --lf',
        \      '*': 'win32yank.exe -o --lf',
        \   },
        \   'cache_enabled': 0,
        \ }
endif


" -----------------------------------------------------------------------------
" > keybindings 
" -----------------------------------------------------------------------------
map <F1> :NERDTreeToggle<cr>
map <F2> :TlistToggle<cr>
" map <F3> :VoomToggle<cr> " see each work setion
"nmap <unique> <silent> <F3> <Plug>SelectBuf
":nnoremap <F3> :buffers<CR>:buffer<Space>
"map <F4> :SyntasticToggleMode<cr>
" F5 used by pep8
"let g:UltiSnipsExpandTrigger            ="<F6>"
":nnoremap <silent> <F7> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>



" -----------------------------------------------------------------------------
" > Indent
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" > Layout / template / color
" -----------------------------------------------------------------------------
set title
set background=dark
set colorcolumn=80
highlight ColorColumn ctermbg=9
set number				" line number


" -----------------------------------------------------------------------------
" > Persistent undo programming
" -----------------------------------------------------------------------------
" https://stackoverflow.com/questions/5700389/using-vims-persistent-undo
let vimDir = '$HOME/.vim'

if stridx(&runtimepath, expand(vimDir)) == -1
  " vimDir is not on runtimepath, add it
  let &runtimepath.=','.vimDir
endif

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/persistent_undo')
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" -----------------------------------------------------------------------------
" > Search
" -----------------------------------------------------------------------------

hi Search ctermfg=Yellow ctermbg=NONE cterm=bold,underline

" -----------------------------------------------------------------------------
" > Tags
" -----------------------------------------------------------------------------
" tags (ctags) (tested working)
" tips:
"" :tselect /pattern
"" :help tag-regexp.
set tags=./tags;/ " autoload tag file recursive
