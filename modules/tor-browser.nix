{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.prog.tor-browser;
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  options.prog = {
    tor-browser.enable = lib.mkEnableOption "Enable Tor Browser";
  };

  config =
    lib.mkIf (cfg.enable && isLinux) {
      environment.systemPackages = [
        pkgs.tor-browser
      ];
    }
    // lib.mkIf (cfg.enable && isDarwin) {
      homebrew.casks = [
        "tor-browser"
      ];
    };
}
