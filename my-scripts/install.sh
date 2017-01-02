#!/usr/bin/env bash

# Symlinks all ruby scripts to ~/bin

mkdir -p ~/bin
for f in *.rb; do
    chmod +x ${f}
    ln -s "$1/${f}" "$HOME/bin/`basename $f`"
done