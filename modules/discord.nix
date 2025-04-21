{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.prog.discord;
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  options.prog = {
    discord.enable = lib.mkEnableOption "Enable Discord";
  };

  config =
    lib.mkIf (cfg.enable && isLinux) {
      environment.systemPackages = [
        pkgs.discord
      ];
    }
    // lib.mkIf (cfg.enable && isDarwin) {
      homebrew.casks = [
        "discord"
      ];
    };
}
