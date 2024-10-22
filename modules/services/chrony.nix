{ config, lib, pkgs, ... }:
{
  options = {
    chrony.enable = lib.mkEnableOption "Enable updating time sync options";
    chrony.servers = lib.mkOption {
      default = [
        "0.pool.ntp.org"
        "1.pool.ntp.org"
        "2.pool.ntp.org"
        "3.pool.ntp.org"
      ];
      description = "The time servers to use";
    };
  };
  config = lib.mkIf config.chrony.enable {
    services.chrony = lib.mkIf config.chrony.enable {
      enable = config.chrony.enableChrony;
      servers = config.chrony.servers;
    };
  };
}
