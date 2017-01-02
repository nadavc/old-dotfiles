#!/usr/bin/env bash

# make fish default for current user
sudo -- sh -c "echo /usr/local/bin/fish >> /etc/shells"
chsh -s /usr/local/bin/fish

# install Oh-my-fish
curl -L http://get.oh-my.fish | fish

# install bobthefish theme
/usr/local/bin/fish -c "omf install bobthefish"
