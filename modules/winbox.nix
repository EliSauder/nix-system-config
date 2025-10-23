{ config, pkgs, lib, options, ... }:
let 
    cfg = config.prog.winbox;
in {
    options.prog = {
        winbox.enable = lib.mkEnableOption "Enable winbox";
    };

    config = lib.mkIf cfg.enable {
        programs.winbox = lib.mkIf cfg.enable {
            enable = true;
            package = pkgs.winbox4;
            openFirewall = true;
        };
    };
}
