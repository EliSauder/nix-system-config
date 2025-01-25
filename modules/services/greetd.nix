{ config, lib, pkgs, ... }:
let
    cfg = config.greetd;
in {
  options = {
    greetd.enable = lib.mkEnableOption "Enable greetd";
  };
  config = lib.mkIf cfg.enable 
  let
    hyprlandConfig = pkgs.writeText "greetd-hyprland-config" ''
    	exec-once = regreet; hyprctl dispatch exit
    '';
  in
  {
    services.greetd = {
    	enable = true;
	settings = {
	  default_session = {
	    command = "${pkgs.hyprland}/bin/hyprland --config ${hyprlandConfig}";
	  };
	};
    };
    security.pam.services.greetd.enableGnomeKeyring = true;

    programs.regreet.enable;
  };
}
