if status is-interactive
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    	exec startx -- -keeptty
    end
    kubectl completion fish | source
    starship init fish | source
end
source ~/.config/fish/colors/carbonfox.fish
fish_add_path /home/derp/go/bin
starship init fish | source
zoxide init fish | source
