{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ozavodny";
  home.homeDirectory = "/home/ozavodny";

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    shell.program = "/run/current-system/sw/bin/fish";
    font = {
      size = 7;
    };
  };

  programs.git = {
    userEmail = "ondrej@zavodny.net";
    userName = "Ondřej Závodný";
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
    };

    config = {
      "bar/top" = {
        width = "100%";
        height = "3%";
        radius = 0;
        modules-right = "date";
        wm-restack = "bspwm";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%d.%m.%y";
        time = "%H:%M:%S";
        label = "%time% %date%";
      };
    };
    script = "polybar top &";
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
