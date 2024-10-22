{ config, lib, pkgs, ... }:
{
  options = {
    pipewire.enable = lib.mkEnableOption "Enable pipewire";
    pipewire.enableAlsa = lib.mkOption {
      default = true;
      description = "Enable alsa support";
    };
    pipewire.enablePluse = lib.mkOption {
      default = true;
      description = "Enable pulse support";
    };
    pipewire.enableJack = lib.mkOption {
      default = true;
      description = "Enable jack support";
    };
  };
  config = lib.mkIf config.pipewire.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = config.pipewire.enablePulse;
      alsa.enable = config.pipewire.enableAlsa;
      jack.enable = config.pipewire.enableJack;
    };
  };
}
