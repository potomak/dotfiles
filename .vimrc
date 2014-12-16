syntax on
set showmatch      " Show matching brackets
set nocompatible   " Don't emulate vi's limitations
filetype plugin indent on " Enable filetype-specific indenting and plugins (andrea@)

set smarttab
set shiftwidth=2
set smartindent
set noexpandtab
set textwidth=0
set modeline

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim
   
set title                        " Set a title on the terminal
set laststatus=2                 " Always display the status line
set shortmess=atI                " Enable short messages (press a key is annoying)

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" Formats the statusline
set statusline=%f                               " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}]                         " file format
set statusline+=%y                              " filetype
set statusline+=%h                              " help file flag
set statusline+=%m                              " modified flag
set statusline+=%r                              " read only flag
set statusline+=\ %=                            " align left
set statusline+=Line:%l/%L[%p%%]                " line X of Y [percent of file]
set statusline+=\ Col:%c                        " current column
set statusline+=\ Buf:%n                        " Buffer number

"per filetype configuration (andrea@)
augroup myfiletypes
 "clear old autocmds in group
 autocmd!
 autocmd FileType ruby,eruby,yaml set list | set list listchars=trail:. ai sw=2 sts=2 et
 autocmd FileType js set list | set list listchars=trail:. ai sw=2 sts=2 et
 autocmd FileType tcl set is tw=0 si ai sta sw=4 ts=4 | set list | set list listchars=tab:>.,trail:.
 autocmd FileType java set ai sw=4 sts=4 et
 autocmd FileType tex set spell spelllang=en
 autocmd FileType tex syntax spell toplevel
augroup END
