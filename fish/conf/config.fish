set -x PATH ~/bin $PATH
set -x PATH ~/.rbenv/shims $PATH
set -x PATH $HOME/.jenv/bin $PATH

set -x SCRIPT_WRAPPED_NEWT /tmp
set -x GOPATH ~/dev/gopath

status --is-interactive; and source (rbenv init -|psub)

alias npm="newt exec npm --"
alias node="newt exec node --"
alias yarn="newt exec yarn --"

set -x EDITOR (which vim)

function fish_user_key_bindings 
  bind \ck edit_command_buffer 
end
