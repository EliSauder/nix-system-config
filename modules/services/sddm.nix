{ config, lib, pkgs, ... }:
let
    cfg = config.sddm;
in {
  options = {
    sddm.enable = lib.mkEnableOption "Enable hyprland";
  };
  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };
  };
}
