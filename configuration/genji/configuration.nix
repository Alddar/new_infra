{ config, options, ... }:
{
  imports = [
    "../common/basic.nix"
    "../rpi/3bplus.nix"
  ];

  basic.user.extraGroups = [ "wheel" ];

  networking.hostName = "genji";

    # Configure basic SSH access
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
}
