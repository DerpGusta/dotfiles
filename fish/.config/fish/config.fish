if status is-interactive
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx -- -keeptty
  end
  kubectl completion fish | source
  # starship init fish | source
end


# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

set -g fish_key_bindings fish_vi_key_bindings
set fish_cursor_default     block
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

function fish_user_key_bindings
  # Execute this once per mode that emacs bindings should be used in
  fish_default_key_bindings -M insert
  fish_vi_key_bindings --no-erase insert
  fzf_key_bindings
end
fish_user_key_bindings

fish_add_path /home/derp/go/bin
zoxide init fish | source
#starship init fish | source
