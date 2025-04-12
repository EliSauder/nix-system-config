{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = [
    pkgs.wineWowPackages.stable
    pkgs.wine
    pkgs.wine64
    pkgs.winetricks
  ];
}
