{config,pkgs,lib,options,...}: {

            services.udev.packages = [ pkgs.yubikey-personalization ];
            services.gnome.gnome-keyring.enable = true;
    
     security = {

            pam.mount.enable = true;
            polkit.enable = true;
        pam.services = {
            hyprlock.enableGnomeKeyring = true;
            sddm.enableGnomeKeyring = true;
            greetd.enableGnomeKeyring = true;
            
        };
     };
    
}
