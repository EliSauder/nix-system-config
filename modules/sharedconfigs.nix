
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

    programs.gnupg.agent = {
    	enable = true;
	enableSSHSupport = true;
    };
 
    nix.gc.automatic = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    programs.dconf.enable = true;
    
    services.gnome.gnome-browser-connector.enable = true;

    boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
    ];
    boot.kernelModules = [
       "v4l2loopback"
    ];
    boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    services.udev.packages = [ pkgs.yubikey-personalization ];

    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;
    security.pam.services = {
    	sddm.enableGnomeKeyring = true;
	hyprlock.enableGnomeKeyring = true;
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "1password"
	"1password-cli"
    ];
    programs._1password.enable = true;
    programs._1password-gui = {
    	enable = true;
	# TODO: Update to be more dynamic and not require the hardcoding of user names
	polkitPolicyOwners = [
	    "esauder"
	];
    };

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
