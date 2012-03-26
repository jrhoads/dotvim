
" Vim syntax file
" Language:	XPPaut ODE file for defining ordinary differntial equations
" Maintainer:  Joseph A. Rhoads  (joseph.rhoads@gmail.com	
" Last Change:	2009 May 31

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match 	xppComment 			"#.*$"
syn keyword xppImport 			import option
syn match 	xppPreConditi 		"@.*$"
syn match 	xppActiveComment 	"\".*$"

syn match 	xppFunction 		"d.*/dt[ \t]*="
syn match 	xppFunction 		".*'[ \t]*="
syn match 	xppFunction 		".*(.*)[ \t]*="

syn keyword xppStatement 		init bndry b[dry] 
syn keyword xppStatement 		p[arameter] params num[ber] wie[ner]
syn keyword xppStatement 		aux d[one] export
syn keyword xppStatement 		so[lve] table mar[kov] voltera 
syn keyword xppStatement 		global only options
syn keyword xppStatement 		set special
syn keyword xppStatement 		if then else

syn keyword xppBuiltin 			conv sparse fconv sum mmult fmmult
syn keyword xppBuiltin 			sin cos tan atan atan2
syn keyword xppBuiltin			sinh cosh tanh exp delay
syn keyword xppBuiltin			ln log log10 pi asin acos heav
syn keyword xppBuiltin 			sign ceil flr ran abs
syn keyword xppBuiltin	        max min normal besselj 
syn keyword xppBuiltin	        bessely erf erfc poisson

syn match xppOperator 		"="
syn match xppOperator 		"[-+]"

syn match   xppNumber	"\<0x\x\+[Ll]\=\>"
syn match   xppNumber	"\<\d\+[LljJ]\=\>"
syn match   xppNumber	"\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"
syn match   xppNumber	"\<\d\+\.\([eE][+-]\=\d\+\)\=[jJ]\=\>"
syn match   xppNumber	"\<\d\+\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"


if version >= 508 || !exists("did_xppaut_syn_inits")
  if version <= 508
    let did_xppaut_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
	HiLink xppComment 			Comment
	HiLink xppNumber 			Number
	HiLink xppStatement 		Statement
	HiLink xppPreConditi 		PreCondit
	HiLink xppOperator 		Operator
	HiLink xppBuiltin 			Function
	HiLink xppFunction 		Function
	HiLink xppActiveComment 	Special
	HiLink xppImport 			Include

	delcommand HiLink
endif
let b:current_syntax = "xpp"
