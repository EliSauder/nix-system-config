{config,pkgs,lib,options,...}: {

    
    
        services.gnome.gnome-keyring.enable = true;
        security.polkit.enable = true;
        security.pam.services = {
        	sddm.enableGnomeKeyring = true;
        } // lib.optionalAttrs (options?security.pam.services.hyprlock) {
            security.pam.services.hyprlock.enableGnomeKeyring = true;
        };
}
