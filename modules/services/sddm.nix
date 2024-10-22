
{ config, lib, pkgs, ... }:
{
  options = {
    sddm.enable = lib.mkEnableOption "Enable hyprland";
  };
  config = lib.mkIf config.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };
  };
}
