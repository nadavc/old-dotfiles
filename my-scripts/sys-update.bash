#!/usr/bin/env bash

pushd ~/dev/github
sync-gh-tree.rb $(pwd)

pushd ~/dev/stash
sync-gh-tree.rb $(pwd)

popd 
popd

brew update
brew upgrade

