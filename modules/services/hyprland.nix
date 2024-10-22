{ inputs, config, lib, pkgs, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland";
    hyprland.useNvidia = lib.mkOption {
      default = false;
      description = "Whether or not to use nvidia settings";
    };
  };
  config = lib.mkIf config.hyprland.enable {
    hardware.nvidia.modesetting.enable = config.hyprland.useNvidia;
    programs.hyprland = {
      enable = true;
      #package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      #portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
    environment.variables.NIXOS_OZONE_WL = "1";
  };
}
