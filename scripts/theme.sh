#!/bin/bash
#TODO: add time based theme setting on i3 startup
toggle=$1
waldir="$HOME/.config/wal/colorschemes"
previous=""
if [ -f ~/.cache/wal/last_used_theme ]; then
  previous=$(cut -d "." -f 1 ~/.cache/wal/last_used_theme)
fi
change_gtk() {
  if [[ $toggle ]]; then
    if [[ $previous = "gruvbox-dark" ]]; then
      xfconf-query -c xsettings -p /Net/ThemeName -s "SolArc-Lighter"
    else
      xfconf-query -c xsettings -p /Net/ThemeName -s "Colloid-Grey-Dark-Gruvbox"
    fi
  else
    xfconf-query -c xsettings -p /Net/ThemeName -s "Colloid-Grey-Dark-Gruvbox"
  fi
  echo "Theme changed!"
}

change_pywal() {
  if [[ $toggle ]]; then

    if [ -f ~/.cache/wal/last_used_theme ]; then
      previous=$(cut -d "." -f 1 ~/.cache/wal/last_used_theme)
      echo "$previous"
    else
      previous="gruvbox-light"
    fi

    # if [[ $previous = "solarized-light" ]]; then
    if [[ $previous = "gruvbox-light" ]]; then
      # wal --theme "$waldir/dark/solarized-dark.json"
      wal --theme "$waldir/dark/gruvbox-dark.json"
    else
      wal --theme "$waldir/light/gruvbox-light.json"
    fi
  else
    wal --theme "$waldir/dark/gruvbox-dark.json"
  fi
}
change_wallpaper() {
  if [[ $toggle ]]; then
    if [[ $previous = "gruvbox-light" ]]; then
      nitrogen --save --set-tiled "$HOME/dotfiles/wallpapers/glider.jpg"
    else
      nitrogen --save --set-tiled "$HOME/dotfiles/wallpapers/gruvbox-light.png"
    fi
  else
    nitrogen --save --set-tiled "$HOME/dotfiles/wallpapers/gruvbox-dark.png"
  fi
}

change_gtk
change_wallpaper
change_pywal
i3-msg reload
