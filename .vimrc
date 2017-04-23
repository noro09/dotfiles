" vimrc に以下のように追記

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
        endif
          execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
          endif

" 設定開始
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

" プラグインリストを収めた TOML ファイル
" 予め TOML ファイル（後述）を用意しておく
let g:rc_dir    = expand('~/.vim/rc')
let s:toml      = g:rc_dir . '/dein.toml'
let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

" TOML を読み込み、キャッシュしておく
call dein#load_toml(s:toml,      {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

" 設定終了
call dein#end()
call dein#save_state()
endif
" もし、未インストールものものがあったらインストール
if dein#check_install()
call dein#install()
endif

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
scriptencoding utf-8
set encoding=utf-8

set number                   "行番号
set guifont=Ricty\ 12        "フォント

" カラースキーマ設定
set t_Co=256
syntax on
colorscheme molokai
let g:molokai_original=1
"set background=dark

" 拡張設定

"挿入モードで",date",',time'で日付、時刻挿入
inoremap ,date <C-R>=strftime('%Y/%m/%d (%a)')<CR>
inoremap ,time <C-R>=strftime('%H:%M')<CR>
