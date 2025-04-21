{
  config,
  lib,
  pkgs,
  options,
  ...
}:
let
  isLinux = options ? i18n;
in
{
  imports = [
    ./boot/systemd.nix
    ./boot/kernelOptions.nix
    ./networkingsvcs.nix
    ./timesync.nix
    ./sound.nix
    ./sys-packages.nix
    ./environmentVariables.nix
    ./bluetooth.nix
    ./i18n.nix
    ./1password.nix
    ./dconf.nix
    ./firefox.nix
    ./security.nix
    ./browser-connector.nix
    ./winbox.nix
    ./steam.nix
    ./discord.nix
    ./libreoffice.nix
    ./inkscape.nix
    ./obs-studio.nix
    ./tor-browser.nix
  ];

  bootmng.systemd.enable = pkgs.stdenv.isLinux;

  prog.onepassword.enable = true;
  prog.dconf.enable = true;
  prog.firefox.enable = true;
  prog.winbox.enable = true;

  prog.steam.enable = true;
  prog.discord.enable = true;
  prog.libreoffice.enable = true;
  prog.inkscape.enable = true;
  prog.obs-studio.enable = true;
  prog.tor-browser.enable = true;

  timesync.enable = pkgs.stdenv.isLinux;
  pipewire.enable = pkgs.stdenv.isLinux;
  networkingsvcs.enable = pkgs.stdenv.isLinux;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nix.gc.automatic = true;

  # shells
  programs.zsh.enable = true;
  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.tmux.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "1password-cli"
      "steam"
    ];
}
