{ inputs, config, lib, pkgs, ... }:
let
    cfg = config.hyprland;
in {
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
        pkgs.polkit-kde-agent
    ];
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
      withUWSM = true;
    };
    environment.variables = {
        POLKIT_AUTH_AGENT = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
	NIXOS_OZONE_WL = "1";
	XDG_SESSION_TYPE = "wayland";
    };
  };
}
