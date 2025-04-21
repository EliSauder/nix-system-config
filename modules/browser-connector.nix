{config,pkgs,lib,options,...}: {
    config = {
    } // lib.optionalAttrs (options?services.gnome) {
        services.gnome.gnome-browser-connector.enable = true;
    };
}
