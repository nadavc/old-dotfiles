# My dotfiles

Installs and configures apps from the Mac App Store, Homebrew and Homebrew Cask
on a fresh or existing macOS system. Heavily inspired by [Danny's dotfiles](https://github.com/DanielThomas/dotfiles).  

## Install

* Run `xcode-select --install` to install the Developer Tools
* Put your SSH keypairs in `~/.ssh`
* Clone this repo using `git@github.com:nadavc/dotfiles.git`
* Put your private config directories in `private/`
* Run `./bootstrap.rb` 

## How does it work?

The `bootstrap.rb` script iterates through its immediate subdirectories one-by-one, 
installing and configuring based on the files it finds in each directory. 
The only exception to this rule is the `private` directory, which allows 
for another level of subdirectories.
 
## Configuration files

While bootstrapping, the script searches for the files below (in the order they appear in the table)
and executes against them if found. The `private` directory is always executed last. 

File            | Format                                           | Script action
----------------|--------------------------------------------------|-------------------------------------------------------------------------
*.plist         | Standard macOS plist files                       | Symlinked to from `~/Library/Preferences`
*.homebrew      | Newline separated list of homebrew packages      | Installs packages using `brew install <package>`
*.homebrew-cask | Newline separated list of homebrew cask packages | Installs packages using `brew install cask <package>`
*.mas           | Newline separated list of numeric IDs (*)        | Installs specified app(s) from the Mac App Store
conf            | Directory                                        | Symlinked from `~/.config/<dirname>`. Useful if you need a consistent location for assets
*.otf           | Font files                                       | Copied to `~/Library/Fonts`
*.symlink       | Text file                                        | Symlinked from `HOME` such that `myfile.symlink` is linked from `~/.myfile`
install.sh      | Executable script                                | Runs a custom script for installation

(*) Use `mas search <app name>` to find the relevant id

## Todo

* Write script to download from Stash into the right directory