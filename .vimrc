syntax on
set showmatch      " Show matching brackets
set nocompatible   " Don't emulate vi's limitations
filetype plugin indent on " Enable filetype-specific indenting and plugins (andrea@)

set smarttab
set shiftwidth=2
set smartindent
set expandtab
set textwidth=79
set modeline

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

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

" Per filetype configuration (andrea@)
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  autocmd FileType ruby,eruby,yaml set list | set list listchars=trail:. ai sw=2 sts=2 et
  autocmd FileType js set list | set list listchars=trail:. ai sw=2 sts=2 et
  autocmd FileType tcl set is tw=0 si ai sta sw=4 ts=4 | set list | set list listchars=tab:>.,trail:.
  autocmd FileType java set ai sw=4 sts=4 et
  autocmd FileType tex set spell spelllang=en
  autocmd FileType tex syntax spell toplevel

  " Elm
  autocmd BufRead,BufNewFile *.elm set filetype=elm

  " YAML Front Matter workaround, see
  " http://www.codeography.com/2010/02/20/making-vim-play-nice-with-jekylls-yaml-front-matter.html
  autocmd BufRead,BufNewFile *.markdown syntax match Comment /\%^---\_.\{-}---$/
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
augroup END

" Color column
set colorcolumn=80
hi ColorColumn ctermbg=DarkGrey

" Set solarized color scheme
set background=dark
colorscheme solarized

" Enable line numbers
set number

" Recognize *.md extension as Markdown files
au BufRead,BufNewFile *.md set filetype=markdown
