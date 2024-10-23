
{ config, lib, pkgs, ... }:
{
    imports = [
      ./boot/systemd.nix
      ./networkingsvcs.nix
      ./timesync.nix
      ./sound.nix
      ./sys-packages.nix
    ];

    timesync.enable = true;
    pipewire.enable = true;
    networkingsvcs.enable = true;
  
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
    nix.gc.automatic = true;
    environment.enableDebugInfo = true;
    
    i18n = {
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
    };
}
