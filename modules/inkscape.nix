{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.prog.inkscape;
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  options.prog = {
    inkscape.enable = lib.mkEnableOption "Enable inkscape";
  };

  config =
    lib.mkIf (cfg.enable && isLinux) {
      environment.systemPackages = [
        pkgs.inkscape-with-extensions
        pkgs.inkscape-extensions.inkcut
        pkgs.inkscape-extensions.hexmap
        pkgs.inkscape-extensions.textext
        pkgs.inkscape-extensions.silhouette
        pkgs.inkscape-extensions.applytransforms
      ];
    };
}
