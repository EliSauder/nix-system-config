{config,pkgs,lib,options,...}: {
    config = lib.optionalAttrs (options?i18n) {
        i18n = {
          supportedLocales = [
            "en_US.UTF-8/UTF-8"
            "ja_JP.UTF-8/UTF-8"
          ];
        };
    };
}
