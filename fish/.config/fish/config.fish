if status is-interactive
    starship init fish | source
    kubectl completion fish | source
end
