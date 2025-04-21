{ config, lib, pkgs, ... }:
{
  imports = [
    ./services/pipewire.nix
  ];

  environment.systemPackages = with pkgs; [
      jack-example-tools
  ] ++ 
  (pkgs.lib.optionals pkgs.stdenv.isLinux [
      zita-alsa-pcmi
      qpwgraph
      pavucontrol
      yabridge
      yabridgectl
  ]);

  #musnix = {
  #    enable = true;
  #    alsa‘zita-alsa-pcmi-0.6.1’Seq.enable = true;
  #    rtcqs.enable = true;
  #    rtirq.enable = true;
  #};
}
