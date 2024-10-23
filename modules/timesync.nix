{ config, lib, pkgs, ... }:
let
    cfg = config.timesync;
in {
  imports = [
    ./services/chrony.nix
    ./services/tzupdate.nix
  ];
  options = {
    timesync.enable = lib.mkEnableOption "Enable updating time sync options";
    timesync.enableChrony = lib.mkOption {
      default = true;
      description = "Enable chrony for time sync";
    }; 
    timesync.enableTzUpdate = lib.mkOption { 
      default = true;
      description = "Enable tzupdate for automatic timezone settup";
    };
    timesync.defaultTimeZone = lib.mkOption {
      default = "America/Los_Angeles";
      description = "The default time zone";
    };
  };
  config = lib.mkIf cfg.enable {
    
    time.timeZone = if cfg.enableTzUpdate then null else cfg.defaultTimeZone;

    chrony.enable = cfg.enableChrony;

    tzupdate.enable = cfg.enableTzUpdate;
  };
}
