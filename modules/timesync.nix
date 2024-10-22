{ config, lib, pkgs, ... }:
{
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
  config = lib.mkIf config.timesync.enable {
    
    time.timeZone = config.timesync.defaultTimeZone;

    chrony.enable = config.timesync.enableChrony;

    tzupdate.enable = config.timesync.enableTzUpdate;
  };
}
