{config, pkgs, lib, options, ...}: {
    config = lib.optionalAttrs (options?hardware && pkgs.stdenv.isLinux) {
        hardware.bluetooth.enable = true;
        hardware.bluetooth.powerOnBoot = true;
        services.blueman.enable = true;
    };
}
