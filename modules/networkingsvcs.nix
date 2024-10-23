{ lib, config, pkgs, ... }:
let
    cfg = config.networkingsvcs;
in {
  options = {
    networkingsvcs.enable = lib.mkEnableOption "Setup networking services";
    networkingsvcs.hostName = lib.mkOption {
      description = "The host name of the system";
      type = lib.types.str;
    };
    networkingsvcs.nameservers = lib.mkOption {
      default = [ 
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.4.4.8"
      ];
      type = lib.types.listOf lib.types.str;
      description = "The name servers for the system to use";
    };
    networkingsvcs.allowedTCPPorts = lib.mkOption {
      description = "TCP ports to allow the system to access";
      type = lib.types.listOf lib.types.int;
      default = [];
    };
    networkingsvcs.allowedUDPPorts = lib.mkOption {
      description = "UDP ports to allow the system to access";
      type = lib.types.listOf lib.types.int;
      default = [];
    };
    networkingsvcs.allowPing = lib.mkOption {
      description = "Whether or not to allow pings";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    networking.hostName = cfg.hostName;
  
    networking.nameservers = cfg.nameservers;
    networking.networkmanager.enable = true;
  
    networking.nftables.enable = true;
    networking.firewall.allowedTCPPorts = cfg.allowedTCPPorts;
    networking.firewall.allowedUDPPorts = cfg.allowedUDPPorts;
    networking.firewall.enable = true;
    networking.firewall.allowPing = cfg.allowPing;
    
    services.resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.4.4.8" ];
      dnsovertls = "opportunistic";
    };
  };
}
