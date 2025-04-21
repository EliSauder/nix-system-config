{pkgs, options, config, lib, ...}:
{
    users.knownUsers = [
        "esauder"
    ];

    users.users.esauder = {
        uid = 501;
        shell = pkgs.fish;
        home = if pkgs.stdenv.isLinux then "/home/esauder" else "/Users/esauder";
    } //
    lib.optionalAttrs (options?users.users.esauder.extraGroups) {
        users.users.esauder.extraGroups = ["wheel" "audio"];
    } //
    lib.optionalAttrs (options?users.users.esauder.isNormalUser) {
        users.users.esauder.isNormalUser = true;
    };
    # // 
    # lib.optionalAttrs (options?system.activationScripts.applications.text) {
    #     system.activationScripts.applications.text = lib.mkForce ''
    #       echo "setting up ~/Applications..." >&2
    #       applications="$HOME/Applications"
    #       nix_apps="$applications/Nix Apps"

    #       # Needs to be writable by the user so that home-manager can symlink into it
    #       if ! test -d "$applications"; then
    #           mkdir -p "$applications"
    #           chown esauder: "$applications"
    #           chmod u+w "$applications"
    #       fi

    #       # Delete the directory to remove old links
    #       rm -rf "$nix_apps"
    #       mkdir -p "$nix_apps"
    #       find ${config.system.build.applications}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
    #           while read src -r; do
    #               # Spotlight does not recognize symlinks, it will ignore directory we link to the applications folder.
    #               # It does understand MacOS aliases though, a unique filesystem feature. Sadly they cannot be created
    #               # from bash (as far as I know), so we use the oh-so-great Apple Script instead.
    #               /usr/bin/osascript -e "
    #                   set fileToAlias to POSIX file \"$src\" 
    #                   set applicationsFolder to POSIX file \"$nix_apps\"
    #                   tell application \"Finder\"
    #                       make alias file to fileToAlias at applicationsFolder
    #                       # This renames the alias; 'mpv.app alias' -> 'mpv.app'
    #                       set name of result to \"$(rev <<< "$src" | cut -d'/' -f1 | rev)\"
    #                   end tell
    #               " 1>/dev/null
    #           done
    #     '';
    # };
}
