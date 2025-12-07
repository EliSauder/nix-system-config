{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.greetd;
  hyprlandConfig = pkgs.writeText "greetd-hyprland-config" ''
    exec-once = ${pkgs.regreet}/bin/regreet; hyprctl dispatch exit
    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      disable_hyprland_guiutils_check = true
    }
    env = GTK_USE_PORTAL,0
    env = GDK_DEBUG,no-portals
  '';
in
{
  options = {
    greetd.enable = lib.mkEnableOption "Enable greetd";
  };
  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "start-hyprland -- --config ${hyprlandConfig}";
        };
      };
    };

    security.pam.services.greetd.enableGnomeKeyring = true;

    programs.hyprland.enable = true;
    programs.regreet.enable = true;
  };
}
