#!/bin/zsh


git submodule -q foreach git pull -q origin master

setopt EXTENDED_GLOB
for rcfile in ${$(pwd)}/prezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done