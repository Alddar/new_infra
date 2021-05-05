{ config, pkgs, lib, ... }:
{
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

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
}
