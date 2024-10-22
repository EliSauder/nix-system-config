{ lib, config, pkgs, inputs, ... }:
{
  imports = [
    ./services/sddm.nix
    ./services/hyprland.nix
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
