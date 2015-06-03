"---------------------------
"
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" NERDTreeを設定
NeoBundle 'scrooloose/nerdtree'
" autoclose {}補完プラグイン
NeoBundle 'Townk/vim-autoclose'
" quickrun
NeoBundle 'thinca/vim-quickrun'

"lightline 
"https://github.com/itchyny/lightline.vim
NeoBundle 'itchyny/lightline.vim'

"シンタックスチェック 構文チェック
NeoBundle 'scrooloose/syntastic'


" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"
 
call neobundle#end()
 
" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------


"--------------------
" lightline setting
"-------------------- 
set laststatus=2 

let g:lightline = {
     \ 'colorscheme': 'wombat',
     \ 'mode_map': {'c': 'NORMAL'},
     \ 'active': {
     \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
     \ },
     \ 'component_function': {
     \   'modified': 'MyModified',
     \   'readonly': 'MyReadonly',
     \   'fugitive': 'MyFugitive',
     \   'filename': 'MyFilename',
     \   'fileformat': 'MyFileformat',
     \   'filetype': 'MyFiletype',
     \   'fileencoding': 'MyFileencoding',
     \   'mode': 'MyMode'
     \ }
     \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
	 endfunction
  
function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
	 endfunction
    
function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
     \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
     \  &ft == 'unite' ? unite#get_status_string() :
     \  &ft == 'vimshell' ? vimshell#get_status_string() :
     \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
     \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
     
function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
return ''
 	 endfunction
			   
function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
	 endfunction
		   
function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
	 endfunction
					   
function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
	 endfunction
				   
function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
	 endfunction ') ] ] ]}}

"-------------------------
" End light line setting 
"-------------------------

"---------------------
" syntastic setting
"---------------------

let g:syntastic_javascript_checker = "jshint"		"JavaScriptのSyntaxチェックはjshintで
let g:syntastic_check_on_open = 0			"ファイルオープン時にはチェックをしない
let g:syntastic_check_on_save = 1			"ファイル保存時にはチェックを実施

"----------------------
" end syntastic setting
"----------------------

" 表示設定
set number                   "行番号
set guifont=Ricty\ 12        "フォント

" カラースキーマ設定
set t_Co=256
colorscheme molokai
let g:molokai_original=1
set background=dark

" 拡張設定

"挿入モードで",date",',time'で日付、時刻挿入
inoremap ,date <C-R>=strftime('%Y/%m/%d (%a)')<CR>
inoremap ,time <C-R>=strftime('%H:%M')<CR>
