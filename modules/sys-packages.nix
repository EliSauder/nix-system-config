{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
    # Build
    libgcc
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
    zsh
    tmux
    # Applications
    kitty
    firefox
    vlc
    mpv
    # Other
    libdrm
    nerdfonts
  ];
  fonts.packages = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    unifont
    unifont_upper
    freefont_ttf
    liberation_ttf
    fira
    fira-code
    fira-code-symbols
    fira-sans
    fira-code-nerdfont
    fira-go
    fira-math
    gyre-fonts
    ipafont
    kochi-substitute
  ];
}
