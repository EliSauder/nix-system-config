{config,pkgs,lib,options,...}: {

    
    
        security.pam.services = {
        } // lib.optionalAttrs (options?security.pam.services.hyprlock) {
            security.pam.services.hyprlock.enableGnomeKeyring = true;
        } // lib.optionalAttrs (options?security.pam.services.sddm) {
            security.pam.services.sddm.enableGnomeKeyring = true;
        } // lib.optionalAttrs (options?security.polkit) {
            security.polkit.enable = true;
        } // lib.optionalAttrs (options?services.gnome.gnome-keyring) {
            services.gnome.gnome-keyring.enable = true;
        } // lib.optionalAttrs (options?services.udev) {
            services.udev.packages = [ pkgs.yubikey-personalization ];
        };
}
