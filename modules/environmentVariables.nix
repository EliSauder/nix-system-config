{config, pkgs, options, lib, ...}: {
    config = lib.optionalAttrs (options?environment.sessionVariables) {
        environment.sessionVariables = {
            MOZ_USE_XINPUT2 = "1";
        };
    };
}
