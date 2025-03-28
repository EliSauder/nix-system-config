{config,pkgs,lib,options,...}: 
let
    cfg = config.prog.dconf;
in {
    options.prog = {
        dconf.enable = lib.mkEnableOption "Enable dconf";
    };
    config = lib.optionalAttrs (options?programs.dconf && cfg.enable) {
        programs.dconf.enable = true;
    };
}
