if status is-interactive
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
  	exec startx -- -keeptty
  end
  kubectl completion fish | source
  # starship init fish | source
end


# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

fish_add_path /home/derp/go/bin
zoxide init fish | source
starship init fish | source
