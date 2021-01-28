" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "  autocmd VimEnter * PlugInstall
  "  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Gruvebox theme
    Plug 'morhetz/gruvbox'
    Plug 'arcticicestudio/nord-vim' 

    " Airline status bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Fuzzyfinder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'

    " Autocomplete, linter, formatter & magic
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Language specific
    " [C#]
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'nickspoons/vim-sharpenup'

    " Code Snippets
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'

    " Sugar
    Plug 'jiangmiao/auto-pairs'
    Plug 'machakann/vim-highlightedyank'
    Plug 'preservim/nerdcommenter'
    
    Plug 'voldikss/vim-floaterm'

call plug#end()
