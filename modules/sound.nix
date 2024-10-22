{ config, lib, pkgs, ... }:
{
  imports = [
    ./services/pipewire.nix
  ];
}
