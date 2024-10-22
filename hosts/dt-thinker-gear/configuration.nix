{ config, lib, inputs, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./../../modules/graphics/amd.nix
      ./../../modules/sharedconfigs.nix
      ./../../users/esauder.nix
      ./../../modules/ui.nix
    ];

  sddm.enable = true;
  hyprland.enable = true;
  hyprland.useNvidia = false;

  i18n.defaultLocale = "en_US.UTF-8";

  networkingsvcs.enable = true;
  networkingsvcs.hostName = "dt-thinker-gear";

  # Original NixInstalled Version (DO NOT CHANGE)
  system.stateVersion = "24.05";

}

