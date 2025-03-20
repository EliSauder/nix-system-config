{pkgs, options, lib, ...}:
{
    users.users.esauder = {
    } //
    lib.optionalAttrs (options?users.users.esauder.extraGroups) {
        users.users.esauder.extraGroups = ["wheel" "audio"];
    } //
    lib.optionalAttrs (options?users.users.esauder.isNormalUser) {
        users.users.esauder.isNormalUser = true;
    };
}
