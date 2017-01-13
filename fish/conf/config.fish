set -x PATH ~/bin $PATH
set -x PATH ~/.rbenv/shims $PATH
set -x PATH $HOME/.jenv/bin $PATH

set -x SCRIPT_WRAPPED_NEWT /tmp
set -x GOPATH ~/dev/gopath

status --is-interactive; and source (rbenv init -|psub)
