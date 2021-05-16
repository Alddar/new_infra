{ config, options, ... }:
{
  imports = [
    ../common/basic.nix
    ../rpi/3bplus.nix
    ../common/wireguard.nix
  ];

  basic.user.extraGroups = [ "wheel" ];

  networking.hostName = "genji";

    # Configure basic SSH access
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."jellyfin.genji.local" =  {
      locations."/" = {
        proxyPass = "http://192.168.0.2:8096";
        proxyWebsockets = true; # needed if you need to use WebSocket
        extraConfig =
          # required when the target is also TLS server with multiple hosts
          "proxy_ssl_server_name on;" +
          # required when the server wants to use HTTP Authentication
          "proxy_pass_header Authorization;"
          ;
      };
    };
};
}
