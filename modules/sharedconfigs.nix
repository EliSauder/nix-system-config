
{ config, lib, pkgs, ... }:
{
    imports = [
      ./boot/systemd.nix
      ./networkingsvcs.nix
      ./timesync.nix
      ./sound.nix
      ./sys-packages.nix
    ];

    timesync.enable = true;
    pipewire.enable = true;
    networkingsvcs.enable = true;
  
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
    nix.gc.automatic = true;

    services.blueman.enable = true;

    programs.dconf.enable = true;
    
    services.gnome.gnome-browser-connector.enable = true;

    security.polkit.enable = true;
    boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
    ];
    boot.extraModprobeConfig = ''
        options v4l2loopback devices=3 video_nr=1,1,1 card_label=v-loopback-1,v-loopback-2,v-loopback-3 exclusive_caps=1,1,1
    '';

    programs.firefox = let
        lock-false = {
	    Value = false;
	    Status = "locked";
	};
	lock-true = {
	    Value = true;
	    Status = "locked";
	};
	lock-empty-string = {
	    Value = "";
	    Status = "locked";
	};
    in {
        enable = true;
	preferences = {
	    "widget.use-xdg-desktop-portal.file-picker" = 1;
	};
	policies = {
	    DisableTelemetry = true;
	    DisableFirefoxStudies = true;
	    DontCheckDefaultBrowser = true;
	    DisablePocket = true;
	    SearchBar = "unified";
	    Preferences = {
	        "extensions.pocket.enabled" = lock-false;
		"browser.newtabpage.pinned" = lock-empty-string;
		"browser.topsites.contile.enable" = lock-false;
		"browser.newtabpage.activity-stream.showSponsored" = lock-false;
		"browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
		"browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
	    };
	};
    };

    environment.sessionVariables = {
        MOZ_USE_XINPUT2 = "1";
    };

    i18n = {
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
    };
}
