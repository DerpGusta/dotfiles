{ config, pkgs, inputs, ... }:

{

  imports = [
    ./firefox.nix
    ./fish/fish.nix
    ./i3
  ];

  home.username = "derp";
  home.homeDirectory = "/home/derp";

  home.stateVersion = "24.11";

  xsession.enable = true;

  # let home-manager manage itself
  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    yazi
    p7zip
    gnome-solanum

    # utils
    ripgrep
    fzf
    jq
    jc
    jless
    eza
    zoxide
    bat
    dnsutils # dig + nslookup

    # misc

    keepassxc
    file
    which
    stow
    tree

    # website
    hugo

    # reading
    newsraft
    zathura
    sioyek
    obsidian

    # monitoring and tracing
    #strace
    #ltrace
    #lsof

    # system tools
    # dev/work
    kubectl
    wezterm
    neovide

    #i3 tools
    (polybarFull.override{i3Support = true;})
    xclip
    rofi
    udiskie
    #unclutter
    flameshot
    haskellPackages.greenclip
    tesseract
    brightnessctl
    mpc
    wireplumber
    picom
    vimiv-qt
    wallust
    xorg.xdpyinfo
    xfce.xfce4-settings
    xfce.xfconf 

  ];


}
