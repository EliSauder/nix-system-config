{
  config,
  lib,
  options,
  pkgs,
  ...
}:
let
  cfg = config.prog.steam;
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  options.prog = {
    steam.enable = lib.mkEnableOption "Enable steam";
  };

  config =
    lib.mkIf (cfg.enable && isLinux) {
      environment.systemPackages = [
        pkgs.steam
        pkgs.steam-run
        pkgs.steam-unwrapped
      ];
      programs.steam = {
        enable = true;
        protontricks.enable = true;
      };
    }
    // lib.mkIf (cfg.enable && isDarwin) {
      homebrew.casks = [
        {
          name = "steam";
          args = {
            require_sha = false;
          };
        }
      ];
    };
}
