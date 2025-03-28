{ config, options, lib, pkgs, ... }:
let
    cfg = config.bootmng.systemd;
in {
    options.bootmng = {
        systemd.enable = lib.mkEnableOption "Enable systemd";
    };

    config = lib.optionalAttrs ((options?boot) && cfg.enable) {
            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;
    };
}

