{ config, pkgs, lib, options, ... }:
let 
    cfg = config.prog.winbox;
in {
    options.prog = {
        winbox.enable = lib.mkEnableOption "Enable winbox";
    };

    config = lib.optionalAttrs (options?homebrew) {
        homebrew.casks = lib.mkIf cfg.enable [
            "winbox"
        ];
    }
    // lib.optionalAttrs ((options?programs.winbox) && cfg.enable) {
        programs.winbox = lib.mkIf cfg.enable {
            enable = true;
            package = pkgs.winbox4;
            openFirewall = true;
        };
    };
}
