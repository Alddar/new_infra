{ config, pkgs, lib, ... }:
{
  boot.loader.grub.enable = false;

  boot.kernelPackages = pkgs.linuxPackages;

  boot.kernelParams = ["cma=256M"];

  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  # Preserve space by sacrificing documentation and history
  documentation.nixos.enable = false;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  boot.cleanTmpDir = true;
}
