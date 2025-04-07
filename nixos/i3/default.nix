{ lib, config, ... }:

{
# i3 and polybar config
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = builtins.readFile ./config;
    config = {
      terminal = "wezterm";
      fonts = {
        names = [ "JetBrains Mono Nerd Font" ];
        size = 9.0;
      };
      floating = {
        criteria = [{ window_role = "pop-up"; }
          { class = "keepassxc"; }
          { window_role = "task_dialog"; }];
      };
      gaps = {
        inner = 10;
        smartGaps = true;
      };

      modifier = "Mod4";
      workspaceAutoBackAndForth = true;
      startup = [
{ command = "~/dotfiles/scripts/theme.sh"; always = false; notification = false; }
{ command = "udiskie"; always = false; notification = false; }
{ command = "greenclip daemon"; always = false; notification = false; }
{ command = "dunst"; always = false; notification = false; }
{ command = "lxqt-policykit-agent"; always = false; notification = false; }
{ command = "unclutter --jitter 10"; always = false; notification = false; }
#exec --no-startup-id xrdb ~/.Xresources
# Become the flash! (copied from https://github.com/ryanpcmcquen/linuxTweaks/blob/master/.xfceSetup.sh)
{ command = "picom"; always = true; notification = false; }
{ command = "xfconf-query -n -c keyboards -p /Default/KeyRepeat/Delay -t int -s 250"; always = false; notification = false; }
{ command = "xfconf-query -n -c keyboards -p /Default/KeyRepeat/Rate -t int -s 20"; always = false; notification = false; }
{ command = "xfsettingsd --daemon"; always = false; notification = false; }
{ command = "nitrogen --restore --set-auto"; always = false; notification = false; }
{ command = "~/.config/polybar/launch.sh"; always = false; notification = false; }
# exec --no-startup-id barriers --disable-client-cert-checking -a :24800
# assign [class="firefox"] $ws1
{ command = "~/.config/i3/i3-restore/i3-restore"; always = false; notification = false; }
{ command = "keepassxc"; always = false; notification = false; }
# exec --no-startup-id safeeyes
# exec --no-startup-id copyq
# exec --no-startup-id xsel
{ command = "xclip"; always = false; notification = false; }

      ];
      keybindings =
        let
          mod = "Mod4";
          alt = "Mod1";
        in
        lib.mkOptionDefault{
          "${mod}+Shift+q" = "kill";
          "${mod}+Shift+e" = "mode \"$mode_system\"";

          # Vim-like marks
          # read 1 character and mark the current window with this character
          "${mod}+m" = "exec i3-input -F 'mark %s' -l 1 -P 'Mark: '";
          # unmark current window
          "${mod}+Shift+m" = "exec i3-input -F 'unmark %s' -l 1 -P 'Unmark: '";
          # read 1 character and go to the window with the character
          "${mod}+g" = "exec i3-input -F '[con_mark=\"%s\"] focus' -l 1 -P 'Goto: '";

"${mod}+d" = "exec rofi -terminal $term -show drun -icon-theme \"Gruvbox-Material-Dark\"";
          # change focus
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          "${alt}+j" = "focus left";
          "${alt}+k" = "focus down";
          "${alt}+l" = "focus up";
          "${alt}+semicolon" = "focus right";

          # move focused window
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          # other app shortcuts
          "${mod}+i" = "exec firefox";
          "${mod}+n" = "exec neovide --maximized";
          "${mod}+o" = "exec obsidian";
          "${mod}+y" = "exec $terminal -e yazi ~/Downloads";
	  "${mod}+b" = "exec polybar-msg toggle";
	  "${mod}+q" = "exec rofi -modi 'clip:greenclip print' -show clip -run-command {'cmd'}";
	  "${mod}+t" = "exec gnome-solanum";

          "${mod}+Print" = "exec flameshot gui";
          "${mod}+Shift+o" = "exec ~/dotfiles/scripts/ocr.sh";
          "${mod}+p" = "exec ~/.config/rofi/scripts/sioyek.sh";
          "${mod}+Shift+greater" = "exec --no-startup-id mpc -p 6600 next";
          "${mod}+Shift+less" = "exec --no-startup-id  mpc -p 6600 prev";
          "${mod}+Shift+t" = "exec --no-startup-id  mpc -p 6600 toggle";
          "${mod}+Shift+c" = "exec --no-startup-id  ~/dotfiles/scripts/theme.sh true";
          "${mod}+Shift+d" = "exec --no-startup-id  rofi-autorandr";
          "${alt}+grave" = "exec --no-startup-id ~/dotfiles/scripts/scratch.sh dropdown 'nvim'";
          "XF86MonBrightnessUp" = "exec brightnessctl s +2%";
          "XF86MonBrightnessDown" = "exec brightnessctl s 2%-";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          # for_window [instance="dropdown"] floating enable, move scratchpad
	  # mode shortcuts
          "${mod}+z" = "mode \"$zathura\"";

        };

	};
  };
}
