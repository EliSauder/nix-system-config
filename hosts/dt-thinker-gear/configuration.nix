{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/graphics/amd.nix
    ./../../modules/sharedconfigs.nix
    ./../../users/esauder.nix
    ./../../modules/ui.nix
  ];

  greetd.enable = true;
  hyprland.enable = true;
  hyprland.useNvidia = false;

  i18n.defaultLocale = "en_US.UTF-8";

  networkingsvcs.enable = true;
  networkingsvcs.hostName = "dt-captive-snack";
  networkingsvcs.allowPing = true;

  #boot.blacklistedKernelModules = [
  #  "snd_seq_dummy"
  #  "snd_seq_midi"
  #  "snd_seq_midi_event"
  #  "snd_seq_device"
  #  "snd_seq"
  #];

  musnix = {
    enable = true;
    #rtcqs.enable = true;
    #kernel.realtime = true;
    #kernel.packages = pkgs.linuxPackages_rt;
    #alsaSeq.enable = false;
    #das_watchdog.enable = true;
  };

  # Original NixInstalled Version (DO NOT CHANGE)
  system.stateVersion = "24.05";

}
