#!/bin/sh

DOTFILES=`pwd`

mkdir -p ~/.vim/bundle/

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

ln -s -f $DOTFILES/vimrc ~/.vimrc
ln -s -f $DOTFILES/zshrc ~/.zshrc
ln -s -f $DOTFILES/zsh ~/.zsh
ln -s -f $DOTFILES/gitexcludes ~/.gitexcludes
ln -s -f $DOTFILES/gitconfig ~/.gitconfig
ln -s -f $DOTFILES/tmux.conf ~/.tmux.conf
ln -s -f $DOTFILES/editorconfig ~/.editorconfig
ln -s -f $DOTFILES/dircolors ~/.dircolors
