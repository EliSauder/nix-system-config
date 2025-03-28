{config,pkgs,lib,options,...}: {
    config = {
        services.gnome.gnome-browser-connector.enable = true;
    } // lib.optionalAttrs (options?services.gnome.gnome-browser-connector) {
        services.gnome.gnome-browser-connector.enable = true;
    };
}
