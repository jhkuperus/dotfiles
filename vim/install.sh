#!/bin/bash

CWD=$(pwd)

mkdir -p ~/.vim/autoload ~/.vim/bundle
rm ~/.vim/autoload/pathogen.vim
ln -s $CWD/vim/pathogen.vim ~/.vim/autoload/pathogen.vim

cd ~/.vim/bundle
RESULT=$(git clone git@github.com:elzr/vim-json.git)

cd $CWD
