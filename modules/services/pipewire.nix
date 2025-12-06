{
  config,
  lib,
  pkgs,
  options,
  ...
}:
let
  cfg = config.pipewire;
in
{
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
    services.avahi.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = cfg.enablePulse;
      alsa.enable = cfg.enableAlsa;
      alsa.support32Bit = cfg.enableAlsa;
      jack.enable = cfg.enableJack;

      wireplumber.enable = true;

      raopOpenFirewall = true;
      extraConfig.pipewire."10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";
          }
        ];
      };

      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 64;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 256;
        };
      };

      extraConfig.pipewire-pulse."92-low-latency" = {
        "context.properties" = {
          name = "libpipewire-module-protocol-pulse";
        };
        "pulse.properties" = {
          "pulse.min.req" = "64/48000";
          "pulse.default.req" = "128/48000";
          "pulse.max.req" = "256/48000";
          "pulse.min.quantum" = "64/48000";
          "pulse.max.quantum" = "256/48000";
        };
        "stream.properties" = {
          "node.latency" = "64/48000";
          "resample.quality" = 1;
        };
      };

      wireplumber.extraConfig.controlport = {
        "node.features.audio.control-port" = true;
      };

      wireplumber.extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [
            "hsp_hs"
            "hsp_ag"
            "hfp_hf"
            "hfp_ag"
          ];
        };
      };
    };
  };
}
