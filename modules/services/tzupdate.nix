{ config, lib, pkgs, ... }:
let
    cfg = config.tzupdate;
in {
  options = {
    tzupdate.enable = lib.mkEnableOption "Enable updating timezones automatically";
  };
  config = lib.mkIf cfg.enable {

    services.tzupdate.enable = true;

    systemd.timers."tzupdate-timer" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
         OnBootSec = "2m";
         OnCalendar = "daily";
         Persistent = true;
      };
    };
    systemd.services."tzupdate-timer" = {
      script = "systemctl start tzupdate.service";
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
    };
  };
}
