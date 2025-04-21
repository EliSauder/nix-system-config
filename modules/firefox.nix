{config,pkgs,lib,options,...}: {
    options.prog = {
        firefox.enable = lib.mkEnableOption "Enable firefox";
    };

    config = lib.optionalAttrs (options?programs.firefox) {
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
    };
}
