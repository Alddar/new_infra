{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    lolcat
    cmatrix
    exa
  ];

  programs.git = {
    userEmail = "ondrej@zavodny.net";
    userName = "Ondřej Závodný";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      "ls" = "exa";
      "ll" = "exa -l";
      "la" = "exa -la";
    };
  };
}
