{ config, lib, pkgs, ... }:
{
  imports = [
    ./services/pipewire.nix
  ];

  environment.systemPackages = with pkgs; [
      zita-alsa-pcmi
      jack-example-tools
      qpwgraph
      pavucontrol
      yabridge
      yabridgectl
  ];

  #musnix = {
  #    enable = true;
  #    alsaSeq.enable = true;
  #    rtcqs.enable = true;
  #    rtirq.enable = true;
  #};
}
