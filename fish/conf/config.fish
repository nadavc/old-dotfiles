set -x PATH ~/bin $PATH
set -x PATH ~/.rbenv/shims $PATH
set PATH $HOME/.jenv/bin $PATH
set -x SCRIPT_WRAPPED_NEWT /tmp

status --is-interactive; and source (rbenv init -|psub)