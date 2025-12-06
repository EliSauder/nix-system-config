{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./services/pipewire.nix
  ];

  environment.systemPackages =
    with pkgs;
    (pkgs.lib.optionals pkgs.stdenv.isLinux [
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
