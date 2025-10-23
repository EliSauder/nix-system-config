{ config, lib, pkgs, options, ... }:
let
    cfg = config.bootmng.systemd;
in {
    options.bootmng.systemd.enable = lib.mkEnableOption "Enable systemd";

    config = {
            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;
    };
}

