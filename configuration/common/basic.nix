
{ config, pkgs, lib, ... }:
with lib;
let
   extraGroups = config.basic.user.extraGroups;
in
{
  options.basic = {
    user.extraGroups = mkOption {
      type = with types; listOf str;
      default = [];
      example = [ "wheel" ];
      description = "Groups for the created user";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      wget
      vim
      git
    ];

    programs.fish.enable = true;

    users.users.ozavodny = {
      isNormalUser = true;
      extraGroups = extraGroups;
      createHome = true;
      home = "/home/ozavodny";
      shell = pkgs.fish;
    };

    users.users.root.shell = pkgs.fish;
  };
}
