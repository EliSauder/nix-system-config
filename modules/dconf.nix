{config,pkgs,lib,options,...}: 
let
    cfg = config.prog.dconf;
in {
    options.prog = {
        dconf.enable = lib.mkEnableOption "Enable dconf";
    };
    config = lib.mkIf cfg.enable {
        programs.dconf.enable = true;
    };
}
