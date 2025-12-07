{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.hyprland;
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland";
    hyprland.useNvidia = lib.mkOption {
      default = false;
      description = "Whether or not to use nvidia settings";
    };
  };
  config = lib.mkIf cfg.enable {
    hardware.nvidia.modesetting.enable = cfg.useNvidia;
    environment.systemPackages = [
      pkgs.kdePackages.polkit-kde-agent-1
    ];
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
      withUWSM = true;
    };
    programs.uwsm.waylandCompositors.hyprland = lib.mkForce {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/start-hyprland";
    };
    environment.variables = {
      POLKIT_AUTH_AGENT = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      NIXOS_OZONE_WL = "1";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
