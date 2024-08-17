if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias tf terraform
alias k kubectl
alias ll "ls -alF"
alias po poetry

set -x SAM_CLI_TELEMETRY 0 
set -x AWS_PROFILE hellios

fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
fish_add_path ~/Dropbox/bin
fish_add_path ~/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/go/bin
fish_add_path /opt/homebrew/opt/python@3.11/libexec/bin 
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path "/Applications/IntelliJ IDEA CE.app/Contents/MacOS"
