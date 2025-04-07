{ config, lib, pkgs, ... }:

{

  programs.zoxide.enableFishIntegration = true;
  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./config.fish;
    shellAliases = {
      k = "kubectl";
      cat = "bat";
    };
  };

  # set fish as user-interactive shell only.
  programs.bash = {
    enable = true;

    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
