{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    [
      ## Groups of packages
      toybox # unix command line utilities
      ## Individual packages
      # Editors
      vim
      neovim
      nano
      # Utilities
      wget
      curl
      git
      tree
      openssl
      openssh
      unzip
      zip
      p7zip
      # Build
      gdb
      glib
      clang
      lldb
      cmake
      gnumake
      ninja
      jdk
      python3
      # Terminal
      fish
      tmux
      # Applications
      wezterm
      firefox
      mpv
      # Other
      ffmpeg
      # UI
    ]
    ++ (pkgs.lib.optionals pkgs.stdenv.isLinux [
      libgcc
      pavucontrol
      vlc
      libdrm
    ]);
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    unifont
    iosevka
    unifont_upper
    freefont_ttf
    liberation_ttf
    fira
    fira-code
    fira-code-symbols
    fira-sans
    fira-go
    fira-math
    gyre-fonts
    ipafont
    kochi-substitute
  ];
}
