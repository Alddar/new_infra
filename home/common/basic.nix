{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    lolcat
    cmatrix
    exa

    #fish plugins

    fzf
  ];

  programs.git = {
    userEmail = "ondrej@zavodny.net";
    userName = "Ondřej Závodný";
    extraConfig = {
      pull.rebase = false;
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

  programs.vim = {
    enable = true;
    plugins = with pkgs; [
      vimPlugins.vim-nix
    ];
  };
}
