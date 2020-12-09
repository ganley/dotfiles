" some of this is from https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim

" indent and line width
set autoindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=80
highlight ColorColumn ctermbg=254 guibg=lightgrey

" line numbering
set number
highlight LineNr term=bold cterm=NONE ctermfg=252 ctermbg=NONE gui=NONE guifg=lightgray guibg=NONE
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

" syntax highlighting
syntax on

" case-sensitivity in searching
set ignorecase
set smartcase

" always show 5 lines before/after current line
set scrolloff=5

" more history
set history=1000

" match braces
set showmatch
set mat=2

" status line

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

function! StatusLineGitBranch()
    if exists("g:git_branch")
        return g:git_branch
    else
        return ''
    endif
endfunction

function! GetGitBranch()
    let l:is_git_dir = system('echo -n $(git rev-parse --is-inside-work-tree)')
    let g:git_branch = l:is_git_dir == 'true' ?
        \ system('bash -c "echo -n $(git rev-parse --abbrev-ref HEAD)"') : ''
endfunction

autocmd BufEnter * call GetGitBranch()

set laststatus=2
set statusline=%F%m\ (%{StatusLineGitBranch()})\ \ Line:%l/%L\ \ Column:%c

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

