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
		if [[ $previous = "solarized-dark" ]]; then
			xfconf-query -c xsettings -p /Net/ThemeName -s "SolArc-Lighter"
		else
			xfconf-query -c xsettings -p /Net/ThemeName -s "SolArc-Dark"
		fi
	else
		xfconf-query -c xsettings -p /Net/ThemeName -s "SolArc-Dark"
	fi
	echo "Theme changed!"
}

change_pywal() {
	if [[ $toggle ]]; then

		if [ -f ~/.cache/wal/last_used_theme ]; then
			previous=$(cut -d "." -f 1 ~/.cache/wal/last_used_theme)
			echo "$previous"
		else
			previous="solarized-light"
		fi

		if [[ $previous = "solarized-light" ]]; then
			wal --theme "$waldir/dark/solarized-dark.json"
		else
			wal --theme "$waldir/light/solarized-light.json"
		fi
	else
		wal --theme "$waldir/dark/solarized-dark.json"
	fi
}
change_wallpaper() {
	if [[ $toggle ]]; then
		if [[ $previous = "solarized-light" ]]; then
			nitrogen --save --set-zoom-fill "$HOME/dotfiles/wallpapers/solarized-dark.png"
		else
			nitrogen --save --set-zoom-fill "$HOME/dotfiles/wallpapers/solarized-light.png"
		fi
	else
		nitrogen --save --set-zoom-fill "$HOME/dotfiles/wallpapers/solarized-dark.png"
	fi
}

change_gtk
change_wallpaper
change_pywal
i3-msg reload
