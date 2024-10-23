{ config, lib, pkgs, ... }:
let
    cfg = config.pipewire;
in {
  options = {
    pipewire.enable = lib.mkEnableOption "Enable pipewire";
    pipewire.enableAlsa = lib.mkOption {
      default = true;
      description = "Enable alsa support";
    };
    pipewire.enablePulse = lib.mkOption {
      default = true;
      description = "Enable pulse support";
    };
    pipewire.enableJack = lib.mkOption {
      default = true;
      description = "Enable jack support";
    };
  };
  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = cfg.enablePulse;
      alsa.enable = cfg.enableAlsa;
      alsa.support32Bit = cfg.enableAlsa;
      jack.enable = cfg.enableJack;
    };
  };
}
