{ config, options, ... }:
{
  imports = [
    ../common/basic.nix
    ../rpi/3bplus.nix
#    ../common/wireguard.nix
  ];

  basic.user.extraGroups = [ "wheel" ];

  networking.defaultGateway = "192.168.0.1";
  networking.hostName = "genji";
  networking.enableIPv6 = true;
  networking.interfaces.eth0 = {
    useDHCP = false;
    ipv4.addresses = [{
     address = "192.168.0.3";
     prefixLength = 24;
    }];
  };

  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      listen-address=::1,127.0.0.1,192.168.0.3
      interface=eth0
      domain=zavodny.lan
      server=1.1.1.1
      server=1.0.0.1
      server=8.8.8.8
      server=8.8.4.4
      address=/zavodny.lan/192.168.0.3
      dhcp-range=192.168.0.100,192.168.0.200,12h
      dhcp-leasefile=/var/lib/dnsmasq/dnsmasq.leases
      dhcp-authoritative
    '';
  };

  /* networking.dhcpcd = {
    enable = true;
    extraConfig = ''
    option domain-name "mrdka";
    option routers 192.168.0.1;
    option domain-name-servers 192.168.0.3, 192.168.0.1;
    option subnet-mask 255.255.255.0;
    option broadcast-address 192.168.0.255;
    default-lease-time 3600;
    max-lease-time 7200;

    subnet 192.168.0.0 netmask 255.255.255.0 {
          range 192.168.0.100 192.168.0.200;
    }

    host tracer {
      hardware ethernet B8:27:EB:C6:E6:66;
      fixed-address 192.168.0.2;
    }
    '';
  }; */

  networking.nameservers = [ "127.0.0.1" "192.168.0.1" ];

    # Configure basic SSH access
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  /* services.coredns.enable = true;
  services.coredns.config =
    ''
      . {
        forward . 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4

        template ANY ANY local {
          answer "{{ .Name }} 60 IN A 192.168.0.3"
        }

        cache
      }
    ''; */

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."jellyfin.local" =  {
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

    virtualHosts."deluge.local" =  {
      locations."/" = {
        proxyPass = "http://192.168.0.2:8112";
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

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 53 ];
    allowedUDPPorts = [ 53 68 ];
  };
}
