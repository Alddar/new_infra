{ config, pkgs, ... }:
let
  colors = {
      primary = {
        background = "#1e1e1e";
        foreground = "#ffffff";
      };
      normal = {
          black   = "#1e1e1e";
          red     = "#ff453a";
          green   = "#32d74b";
          yellow  = "#ffd60a";
          blue    = "#0a84ff";
          magenta = "#bf5af2";
          cyan    = "#5ac8fa";
          white   = "#ffffff";
      };
      bright = {
          black   = "#1e1e1e";
          red     = "#ff453a";
          green   = "#32d74b";
          yellow  = "#ffd60a";
          blue    = "#0a84ff";
          magenta = "#bf5af2";
          cyan    = "#5ac8fa";
          white   = "#ffffff";
      };
  };
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ozavodny";
  home.homeDirectory = "/home/ozavodny";
  home.packages = with pkgs; [
    playerctl
    light
    lolcat
    cmatrix
    exa
    vivaldi
    fzf
  ];

  xsession.enable = true;
  xsession.windowManager.bspwm = {
    enable = true;
    monitors = { "eDP-1" = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ] ; } ;
    settings = {
      pointer_modifier = "mod4";
      pointer_action1 = "resize_side";
      pointer_action2 = "move";
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      "ls" = "exa";
      "ll" = "exa -l";
      "la" = "exa -la";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = "/run/current-system/sw/bin/fish";
      font = {
        size = 7;
      };
      colors = colors;
    };
  };

  programs.firefox.enable = true;

  programs.git = {
    userEmail = "ondrej@zavodny.net";
    userName = "Ondřej Závodný";
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
    };
    theme = {
      package = pkgs.materia-theme;
      name = "Materia-dark";
    };
  };

  services.network-manager-applet.enable = true;
  services.gnome-keyring.enable = true;
  services.flameshot.enable = true;
  programs.rofi = {
    enable = true;
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
      pulseSupport = true;
    };

    config = {
      "bar/top" = {
        height = "34";
        radius = 0;
        modules-left = "bspwm";
        modules-center = "player-mpris-simple";
        modules-right = "xkeyboard backlight pulseaudio battery date";
        wm-restack = "bspwm";
        tray-position = "right";
        padding-right = 1;

        font-0 = "firacode:pixelsize=10;3";
        font-1 = "Material Design Icons:pixelsize=14;3";

        separator = " ";
        line-size = 2;
        background = colors.primary.background;
        foreground = colors.primary.foreground;

      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        format = "󰅐 <label>";

        date = "%d.%m.%y";
        time = "%H:%M:%S";
        label = "%time%";
      };
      "module/bspwm" = {
        type = "internal/bspwm";

        ws-icon-0 = "1;󰎤";
        ws-icon-1 = "2;󰎧";
        ws-icon-2 = "3;󰎪";
        ws-icon-3 = "4;󰎭";
        ws-icon-4 = "5;󰎱";
        ws-icon-5 = "6;󰎳";
        ws-icon-6 = "7;󰎶";
        ws-icon-7 = "8;󰎹";
        ws-icon-8 = "9;󰎼";
        ws-icon-9 = "10;󰽽";

        label-focused = "%icon%";
        label-focused-padding = 1;
        label-focused-foreground = colors.normal.yellow;
        label-focused-underline = colors.normal.yellow;

        label-occupied = "%icon%";
        label-occupied-padding = 1;
        label-occupied-foreground = colors.normal.green;

        label-urgent = "%icon%!";
        label-urgent-padding = 1;

        label-empty = "%icon%";
        label-empty-padding = 1;
      };
      "module/battery" = {
        type = "internal/battery";

        battery = "BAT1";
        adapter = "ADP1";
        full-at = 98;

        format-discharging = "<ramp-capacity> <label-discharging>";
        label-discharging = "%percentage%%";

        ramp-capacity-0 = "󱃍";
        ramp-capacity-1 = "󰁻";
        ramp-capacity-2 = "󰁾";
        ramp-capacity-3 = "󰂁";
        ramp-capacity-4 = "󰁹";

        format-charging = "<animation-charging> <label-charging>";
        label-charging = "%percentage%%";

        animation-charging-0 = "󰢜";
        animation-charging-1 = "󰂇";
        animation-charging-2 = "󰢝";
        animation-charging-3 = "󰢞";
        animation-charging-4 = "󰂅";

        animation-charging-framerate = 750;

        label-full = "󰁹 100%";
      };
      "module/player-mpris-simple" = {
        type = "custom/script";
        exec = "~/new_infra/scripts/polybar/mpris-player.sh";
        interval = 3;
        click-left = "~/.nix-profile/bin/playerctl previous &";
        click-right = "~/.nix-profile/bin/playerctl next &";
        click-middle = "~/.nix-profile/bin/playerctl play-pause &";
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        label-volume = "%percentage%%";
        format-volume = "<ramp-volume> <label-volume>";
        label-muted = "󰖁";
        ramp-volume-0 = "󰕿";
        ramp-volume-1 = "󰖀";
        ramp-volume-2 = "󰕾";
      };
      "module/xkeyboard" = {
        type = "internal/xkeyboard";

        blacklist-0 = "num lock";
        blacklist-1 = "scroll lock";
        label-layout-padding = 0;
      };
      "module/backlight" = {
        type = "internal/backlight";
        card = "intel_backlight";
        format = "<ramp> <label>";
        ramp-0 = "󰃛";
        ramp-1 = "󰃝";
        ramp-2 = "󰃞";
        ramp-3 = "󰃟";
        ramp-4 = "󰃠";
      };
    };
    script = "polybar top &";
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "nixGLIntel alacritty";
      "super + d" = "rofi -show run";
      "XF86Audio{Raise,Lower}Volume" = "pamixer -{i,d} 5";
      "XF86AudioMute" = "pamixer -t";
      "XF86MonBrightnessUp" = "light -A 10";
      "XF86MonBrightnessDown" = "light -U 10";
      "{_, shift + }Print" = "flameshot {gui,full} -p /home/ozavodny/Pictures/Screenshots";
      "super + Escape" = "systemctl --user restart sxhkd.service";
      "super + shift + Escape" = "systemctl --user restart polybar.service";
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "super + {_, shift +} q" = "bspc node -{c,k}";
      "super + alt + {q,r}" = "bspc {quit,wm -r}";
      "super + {_,shift + }w" = "bspc node -{c,k}";
      "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
      "super + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";
      "super + {_,shift + }{Left,Down,Up,Right}" = "bspc node -{f,s} {west,south,north,east}";
    };
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
