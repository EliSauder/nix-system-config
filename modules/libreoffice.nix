{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.prog.libreoffice;
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  options.prog = {
    libreoffice.enable = lib.mkEnableOption "Enable libreoffice";
  };

  config =
    lib.mkIf cfg.enable {
      environment.systemPackages = [
        pkgs.hunspell
        pkgs.hunspellDicts.en_US
      ];
    }
    // lib.mkIf (cfg.enable && isLinux) {
      environment.systemPackages = [
        pkgs.libreoffice-qt6
      ];
    };

}
