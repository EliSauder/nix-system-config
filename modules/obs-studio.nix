{
  config,
  lib,
  pkgs,
  options,
  ...
}:
let
  cfg = config.prog.obs-studio;
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  options.prog = {
    obs-studio.enable = lib.mkEnableOption "Enable obs";
  };

  config =
    #lib.optionalAttrs ((options ? programs.obs-studio) && cfg.enable) {
    lib.mkIf (cfg.enable && isLinux) {
      programs.obs-studio = {
        enable = true;
        plugins =
          with pkgs.obs-studio-plugins;
          [
            obs-vintage-filter
            obs-tuna
            input-overlay
            obs-backgroundremoval
          ]
          ++ (pkgs.lib.optionals pkgs.stdenv.isLinux [
            wlrobs
            obs-pipewire-audio-capture
            obs-vkcapture
            obs-vaapi
          ]);
      };
    };
}
