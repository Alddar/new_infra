# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
  [ # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ../common/basic.nix
  ];

  basic.user.extraGroups = [ "wheel" "networkmanager" "video" "audio" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
#    efi.canTouchEfiVariables = true;
    grub = {
     enable = true;
     efiSupport = true;
     device = "nodev";
  };
  };

  networking.hostName = "hammond"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    vivaldi = {
      proprietaryCodecs = true;
      enableWideVine = true;
    };
  };
  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlo1.useDHCP = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
    overpass
    fira-code
    noto-fonts
    iosevka
    material-design-icons
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Fira Code" ];
        sansSerif = [ "Overpass" ];
        serif     = [ "Noto Serif" ];
      };
    };
  };

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

  environment.systemPackages = with pkgs; [
    neofetch
    terminator
    rofi
    pcmanfm
    pamixer
    xorg.xbacklight
    vivaldi
    nix
  ];


  # Enable the Plasma 5 Desktop Environment.
  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  services.xserver = {
    videoDrivers = [ "modesetting" "nvidia" ];
    enable = true;
    desktopManager = {
      xfce = {
        enable = true;
        enableXfwm = false;
        noDesktop = true;
      };

      xterm.enable = false;
    };

    exportConfiguration = true; # link /usr/share/X11/ properly
    layout = "us,cz";
    xkbOptions = "grp:alt_shift_toggle";

    displayManager = {
      defaultSession = "xfce";
    };

  };

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
    { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };

  security.sudo.enable = true;
  security.polkit.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  nixpkgs.config.pulseaudio = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPortRanges = [ { from = 25565; to = 25565; } ];
  networking.firewall.allowedUDPPortRanges = [
  { from = 9993; to = 9993; }
  { from = 24642; to = 24642; }
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
