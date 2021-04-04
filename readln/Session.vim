let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <Nul> 
inoremap <expr> <Up> pumvisible() ? "\" : "\<Up>"
inoremap <expr> <S-Tab> pumvisible() ? "\" : "\<S-Tab>"
inoremap <expr> <Down> pumvisible() ? "\" : "\<Down>"
inoremap <silent> <Plug>MuT_cWORD =lh#mut#search_templates(GetCurrentWord())
inoremap <silent> <Plug>MuT_ckword =lh#mut#search_templates(GetCurrentKeyword())
inoremap <silent> <BS> =lh#brackets#_switch('''\<bs\>''', [{'action': 'lh#brackets#_delete_empty_bracket_pair()', 'condition': 'lh#brackets#_match_any_bracket_pair()'}])
imap <silent> <F9> <Plug>ToggleBrackets
inoremap <silent> <Plug>ToggleBrackets :call lh#brackets#toggle()
imap <Plug>MarkersJumpB !jumpB!
imap <Plug>MarkersJumpF !jump!
imap <Plug>MarkersMark !mark!=LHMoveWithinMarker()
imap <M-S-Del> <Plug>MarkersJumpB
imap <M-Del> <Plug>MarkersJumpF
imap <M-Insert> <Plug>MarkersMark
vmap 	 <Plug>MuT_Surround
vmap <silent> <M-Down> <Plug>CTagsSplitOpen
nmap <silent> <M-Down> <Plug>CTagsSplitOpen
nmap <silent> ta <Plug>CTagsUpdateAll
nmap <silent> tc <Plug>CTagsUpdateCurrent
map C :let g:ycm_auto_trigger=xor(g:ycm_auto_trigger,1)|echo "AutoTrigger Toggled " . togglemodes[ycm_auto_trigger] 
map c :let g:ycm_complete_in_comments=xor(g:ycm_complete_in_comments,1)|echo "Comment AutoTrigger Toggled " . togglemodes[g:ycm_complete_in_comments] 
map OP :execute("Man 0 <cword>")
map f :execute expand("split <cfile>")
nmap d :cs find d =expand("<cword>")	
nmap i :cs find i ^=expand("<cfile>")$
nmap f :cs find f =expand("<cfile>")	
nmap e :cs find e =expand("<cword>")	
nmap t :cs find t =expand("<cword>")	
nmap c :cs find c =expand("<cword>")	
nmap g :cs find g =expand("<cword>")	
nmap s :cs find s =expand("<cword>")	
vmap !Hname! "zc<a name="!mark!">z</a>!mark!`<!jump!
vmap !Href! "zc<a href="!mark!">z</a>!mark!`<!jump!
vmap !Htag! "zc<!mark!>z</!mark!>`<!jump!
map !stripcomment! :s,^[ 	]*[#>/]\+[ 	]\=,,j
map !*comment! :s,.*,/* &	*/,j
map !/comment! :s,^,// ,j
map !#comment! :s/^/# /j
map !mail! :%s/^[^ 	]*$/> &/
vmap !func! !}!'<kO!)!!mark!!jump!I
vmap !$! "zc${z}
vmap !nroffi! "zc\fIz\fP
vmap !nroffb! "zc\fBz\fP
vmap !space! "zc z 
vmap !}! >'<O{'>o}^
vmap !{! "zc{z}
vmap !`! "zc`z`
vmap !]! "zc[ z ]
vmap ![! "zc[z]
vmap !>! "zc< z >
vmap !<! "zc<z>
vmap !_! "zc_z_
vmap !)! "zc( z )
vmap !(! "zc(z)
vmap !*! "zc*z*
vmap !'! "zc'z'
vmap !"! "zc"z"
nnoremap <silent> !bjump-and-del! @=Marker_Jump(0,1)
vnoremap <silent> !bjump-and-del! @=Marker_Jump(0,1)
nnoremap <silent> !jump-and-del! @=Marker_Jump(1,1)
vnoremap <silent> !jump-and-del! @=Marker_Jump(1,1)
nnoremap <silent> !jumpB! @=Marker_Jump(0)
vnoremap <silent> !jumpB! `<@=Marker_Jump(0)
nnoremap <silent> !jump! @=Marker_Jump(1)
vnoremap <silent> !jump! @=Marker_Jump(1)
nmap <silent> !mark! viw!mark!
vnoremap <silent> !mark! @=LHToggleMarkerInVisual()
nmap <silent> "" viw""
xnoremap <silent> "" @=Surround('"', '"', 0, 0, '`>ll', 1)
nmap <silent> '' viw''
xnoremap <silent> '' @=Surround('''', '''', 0, 0, '`>ll', 1)
nmap <silent> ( viw(
xnoremap <silent> ( @=Surround('(', ')', 0, 0, '`>ll', 1)
vmap ,gq :s/\s\+/ /ggvgq
nmap ,gq :%s/\s\+/ /ggq1G
inoremap <expr> ¬ pumvisible() ? '' : '=pumvisible() ? "\<Down>" : ""'
vmap [% [%m'gv``
nnoremap \d :YcmShowDetailedDiagnostic
nmap \ihn :IHN
nmap \is :IHS:A
nmap \ih :IHS
nmap <silent> \{ V\{
xnoremap <silent> \{ @=Surround('{!cursorhere!', '}!mark!', 1, 1, '', 1, '\{')
nmap <silent> \< viw\<
xnoremap <silent> \< @=Surround('<', '>', 0, 0, '`>ll', 1)
nmap <silent> \[ viw\[
xnoremap <silent> \[ @=Surround('[', ']', 0, 0, '`>ll', 1)
map \rwp <Plug>RestoreWinPosn
map \swp <Plug>SaveWinPosn
map \c :echo g:colors_name
map \p :CP
map \n :CN
vmap ]% ]%m'gv``
vmap _j :call Justify('tw',4)
nmap _j :%call Justify('tw',4)
vmap a% [%v]%
map c y
nmap gx <Plug>NetrwBrowseX
nmap <silent> { viw{
xnoremap <silent> { @=Surround('{', '}', 0, 0, '`>ll', 1)
vnoremap <silent> <Plug>MuT_Surround :call lh#mut#surround()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cfile>"),0)
nmap <Nul><Nul>d :vert scs find d =expand("<cword>")
nmap <Nul><Nul>i :vert scs find i ^=expand("<cfile>")$	
nmap <Nul><Nul>f :vert scs find f =expand("<cfile>")	
nmap <Nul><Nul>e :vert scs find e =expand("<cword>")
nmap <Nul><Nul>t :vert scs find t =expand("<cword>")
nmap <Nul><Nul>c :vert scs find c =expand("<cword>")
nmap <Nul><Nul>g :vert scs find g =expand("<cword>")
nmap <Nul><Nul>s :vert scs find s =expand("<cword>")
nmap <Nul>d :scs find d =expand("<cword>")	
nmap <Nul>i :scs find i ^=expand("<cfile>")$	
nmap <Nul>f :scs find f =expand("<cfile>")	
nmap <Nul>e :scs find e =expand("<cword>")	
nmap <Nul>t :scs find t =expand("<cword>")	
nmap <Nul>c :scs find c =expand("<cword>")	
nmap <Nul>g :scs find g =expand("<cword>")	
nmap <Nul>s :scs find s =expand("<cword>")	
nmap <silent> <F9> <Plug>ToggleBrackets
nnoremap <silent> <Plug>ToggleBrackets :call lh#brackets#toggle()
map <Plug>MarkersJumpB !jumpB!
map <Plug>MarkersJumpF !jump!
nmap <Plug>MarkersMark !mark!
vmap <Plug>MarkersMark !mark!
map <M-S-Del> <Plug>MarkersJumpB
map <M-Del> <Plug>MarkersJumpF
vmap <M-Insert> <Plug>MarkersMark
nmap <M-Insert> <Plug>MarkersMark
vnoremap <silent> <Plug>CTagsSplitOpen :call lh#tags#split_open(lh#visual#selection())
nnoremap <silent> <Plug>CTagsSplitOpen :call lh#tags#split_open()
nnoremap <silent> <Plug>CTagsUpdateAll :call lh#tags#update_all()
nnoremap <silent> <Plug>CTagsUpdateCurrent :call lh#tags#update_current()
nmap <silent> <Plug>RestoreWinPosn :call RestoreWinPosn()
nmap <silent> <Plug>SaveWinPosn :call SaveWinPosn()
inoremap <expr> 	 pumvisible() ? "\" : "\	"
inoremap <silent>  =lh#brackets#_switch('''\<cr\>''', [{'action': 'lh#brackets#_add_newline_between_brackets()', 'condition': 'getline(".")[col(".")-2:col(".")-1]=="{}"'}])
inoremap <expr>  pumvisible() ? '' : '=pumvisible() ? "\<Down>" : ""'
imap 	 <Plug>MuT_cWORD
imap   <Plug>MuT_ckword
map!  
imap  i
imap C :let g:ycm_auto_trigger=xor(g:ycm_auto_trigger,1)|echo "AutoTrigger Toggled " . togglemodes[ycm_auto_trigger]|sleep "0.5"i
imap c :let g:ycm_complete_in_comments=xor(g:ycm_complete_in_comments,1)|echo "Comment AutoTrigger Toggled " . togglemodes[g:ycm_complete_in_comments]|sleep "0.5"i
imap OP :execute("Man 0 <cword>")
imap f :execute expand("split <cfile>")^W^W
imap [20~ [20~i    
imap !Hname! <a name="!mark!">!mark!</a>!mark!`[!jump!
imap !Href! <a href="!mark!">!mark!</a>!mark!`[!jump!
imap !Htag! "zyiwciw<z></z>!mark!F<i
imap !*comment! 0i/* A	*/F	i
imap !/comment! 0i// A
imap !#comment! 0i# A
imap !func! !)!!mark!!jump!!}!!mark!kk0!jump!
imap !$! $!{!
imap !(+);! (  );!mark!F i
imap !();! ();!mark!F)i
imap !nroffi! \fI\fP!mark!F\i
imap !nroffb! \fB\fP!mark!F\i
imap !space! .  !mark!F.xa
imap !}! o{!mark!o}!mark!^%!jump!
imap !{! {}!mark!F}i
imap !`! ``!mark!F`i
imap !]! [  ]!mark!F i
imap ![! []!mark!F]i
imap !>! <  >!mark!F i
imap !<! <>!mark!F>i
imap !_! __!mark!F_i
imap !)! (  )!mark!F i
imap !(! ()!mark!F)i
imap !*! **!mark!F*i
imap !'! ''!mark!F'i
imap !"! ""!mark!F"i
imap <silent> !bjump-and-del! !bjump-and-del!
imap <silent> !jump-and-del! !jump-and-del!
imap <silent> !jumpB! !jumpB!
imap <silent> !jump! !jump!
inoremap <silent> !mark! =Marker_Txt()
inoremap <silent> " =lh#brackets#opener('"',0,'','"','"',1,'')
inoremap <silent> ' =lh#brackets#opener('''',0,'','''','''',1,function('lh#ft#is_text'))
inoremap <silent> ( =lh#brackets#opener('(',0,'','(',')',0,'')
inoremap <silent> ) =lh#brackets#closer(')',')','')
nnoremap <silent> â :call BracketsManipMode("\â")
inoremap <silent> [ =lh#brackets#opener('[',0,'','[',']',0,'')
imap \ihn :IHN
imap \is :IHS:A
imap \ih :IHS
inoremap <silent> ] =lh#brackets#closer(']',']','')
inoremap <silent> { =lh#brackets#opener('{',0,'','{','}',0,'')
inoremap <silent> } =lh#brackets#closer('}','}','')
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
set backspace=indent,eol,start
set completefunc=youcompleteme#Complete
set completeopt=menuone
set cpoptions=aAeFsB
set cscopetag
set cscopeverbose
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set keymodel=startsel,stopsel
set mouse=nchr
set mousemodel=popup
set printoptions=paper:letter
set ruler
set runtimepath=~/.vim,~/.vim/bundle/lh-vim-lib,~/.vim/bundle/system-tools,~/.vim/bundle/lh-tags,~/.vim/bundle/lh-dev,~/.vim/bundle/mu-template@lh,~/.vim/bundle/lh-brackets,~/.vim/bundle/lh-cpp,~/.vim/bundle/tlib,~/.vim/bundle/matchit.zip,~/.vim/bundle/Vundle.vim,~/.vim/bundle/syntastic,~/.vim/bundle/YouCompleteMe,~/.vim/bundle/vim-addon-manager,~/.vim/bundle/unite.vim,~/.vim/bundle/perlomni.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after,~/.vim/bundle/Vundle.vim,~/.vim/bundle/Vundle.vim/after,~/.vim/bundle/syntastic/after,~/.vim/bundle/YouCompleteMe/after,~/.vim/bundle/vim-addon-manager/after,~/.vim/bundle/unite.vim/after,~/.vim/bundle/perlomni.vim/after,~/.vim/bundle/mu-template@lh/after,~/.vim/bundle/lh-brackets/after,~/.vim/bundle/lh-cpp/after
set selection=old
set selectmode=mouse
set shortmess=filnxtToOc
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set updatetime=2000
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd /mnt/sata/home/gabriel/src/mini/readln
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 ~/.vimrc
argglobal
silent! argdel *
argadd ~/.vimrc
edit ~/.vimrc
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 21 + 22) / 44)
exe '2resize ' . ((&lines * 20 + 22) / 44)
argglobal
edit /usr/share/vim/vim74/doc/starting.txt
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal nobuflisted
setlocal buftype=help
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=nc
setlocal conceallevel=2
setlocal completefunc=youcompleteme#Complete
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'help'
setlocal filetype=help
endif
setlocal foldcolumn=0
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcroql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=!-~,^*,^|,^\",192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal nomodifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal readonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=8
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'help'
setlocal syntax=help
endif
setlocal tabstop=8
setlocal tags=
setlocal textwidth=78
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1224 - ((0 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1224
normal! 064|
wincmd w
argglobal
nmap <buffer> <silent> ( viw(
xnoremap <buffer> <silent> ( @=Surround('(', ')', 0, 0, '`>ll', 1)
vnoremap <buffer> <silent> [" :exe "normal! gv"|call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
nnoremap <buffer> <silent> [" :call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")
vnoremap <buffer> <silent> [] m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "bW")
nnoremap <buffer> <silent> [] m':call search('^\s*endf*\%[unction]\>', "bW")
vnoremap <buffer> <silent> [[ m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "bW")
nnoremap <buffer> <silent> [[ m':call search('^\s*fu\%[nction]\>', "bW")
nmap <buffer> <silent> \< viw\<
xnoremap <buffer> <silent> \< @=Surround('<', '>', 0, 0, '`>ll', 1)
vnoremap <buffer> <silent> ]" :exe "normal! gv"|call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
nnoremap <buffer> <silent> ]" :call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")
vnoremap <buffer> <silent> ][ m':exe "normal! gv"|call search('^\s*endf*\%[unction]\>', "W")
nnoremap <buffer> <silent> ][ m':call search('^\s*endf*\%[unction]\>', "W")
vnoremap <buffer> <silent> ]] m':exe "normal! gv"|call search('^\s*fu\%[nction]\>', "W")
nnoremap <buffer> <silent> ]] m':call search('^\s*fu\%[nction]\>', "W")
inoremap <buffer> <expr>  vam#utils#CompleteWith("vam#install#CompleteAddonName")
inoremap <buffer> <silent> " =lh#brackets#opener('"',0,'',function('lh#vim#brackets#dquotes'),'"',1,'')
inoremap <buffer> <silent> ( =lh#brackets#opener('(',1,'','(',')',0,'')
inoremap <buffer> <silent> ) =lh#brackets#closer(')',')','')
inoremap <buffer> <silent> < =lh#brackets#opener('<',0,'',function('lh#vim#brackets#lt'),'>',0,'')
inoremap <buffer> <silent> > =lh#brackets#closer('>','>','')
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
setlocal commentstring=\"%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=youcompleteme#Complete
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'vim'
setlocal filetype=vim
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcqrl
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetVimIndent()
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,#
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'vim'
setlocal syntax=vim
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=80
setlocal thesaurus=
setlocal noundofile
setlocal undolevels=-123456
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 2 - ((1 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 0
wincmd w
exe '1resize ' . ((&lines * 21 + 22) / 44)
exe '2resize ' . ((&lines * 20 + 22) / 44)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
