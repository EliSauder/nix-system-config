{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.prog.discord;
in
{
  options.prog = {
    discord.enable = lib.mkEnableOption "Enable Discord";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.discord
    ];
  };
}
