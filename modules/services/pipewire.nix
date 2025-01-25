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
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = cfg.enablePulse;
      alsa.enable = cfg.enableAlsa;
      alsa.support32Bit = cfg.enableAlsa;
      jack.enable = cfg.enableJack;

      wireplumber.enable = true;

      #extraConfig.pipewire."92-low-latency" = {
      #    "context.properties" = {
      #      "default.clock.rate" = 48000;
      #      "default.clock.quantum" = 128;
      #      "default.clock.min-quantum" = 64;
      #      "default.clock.max-quantum" = 256;
      #    };
      #};

      wireplumber.extraConfig.bluetoothEnhancements = {
          "monitor.bluez.properties" = {
	      "bluez5.enable-sbc-xq" = true;
	      "bluez5.enable-msbc" = true;
	      "bluez5.enable-hw-volume" = true;
	      "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
	  };
      };
    };
  };
}
