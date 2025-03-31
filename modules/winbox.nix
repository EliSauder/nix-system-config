{ config, pkgs, lib, options, ... }:
let 
    cfg = config.prog.winbox;
    isDarwin = pkgs.stdenv.isDarwin;
in {
    options.prog = {
        winbox.enable = lib.mkEnableOption = "Enable winbox";
    };

    config = lib.optionalAttrs((options?homebrew.casks) && cfg.enable) {
        homebrew.casks = [
            "winbox"
        ];
    } // lib.optionalAttrs ((options?programs.winbox) && cfg.enable) {
        programs.winbox = {
            enable = true;
            package = pkgs.winbox4;
            openFirewall = true;
        };
    };
}
