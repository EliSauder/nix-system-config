{ config, lib, pkgs, ... }:
let
    cfg = config.chrony;
in {
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
  config = lib.mkIf cfg.enable {
    services.chrony = lib.mkIf cfg.enable {
      enable = true;
      servers = cfg.servers;
    };
  };
}
