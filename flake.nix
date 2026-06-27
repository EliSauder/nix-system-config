{
  description = "Nixos config flake";

  nixConfig = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    hyprland.url = "github:hyprwm/Hyprland";

    musnix.url = "github:musnix/musnix";

    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      nix-homebrew,
      homebrew-cask,
      homebrew-core,
      ...
    }:
    {
      nixosConfigurations = {
        dt-thinker-gear =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              pkgs-unstable = import inputs.nixpkgs-unstable {
                inherit system;
              };
            };
            modules = [
              inputs.musnix.nixosModules.musnix
              ./hosts/dt-thinker-gear/configuration.nix
            ];
          };
        dt-captive-snack =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              pkgs-unstable = import inputs.nixpkgs-unstable {
                inherit system;
              };
            };
            modules = [
              inputs.musnix.nixosModules.musnix
              ./hosts/dt-captive-snack/configuration.nix
            ];
          };
      };
      darwinConfigurations = {
        lt-yard-boy =
          let
            system = "aarch64-darwin";
          in
          nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              pkgs-unstable = import inputs.nixpkgs-unstable {
                inherit system;
              };
            };
            modules = [
              nix-homebrew.darwinModules.nix-homebrew
              {
                nix-homebrew = {
                  enable = true;
                  enableRosetta = true;
                  user = "esauder";
                  taps = {
                    "homebrew/homebrew-core" = homebrew-core;
                    "homebrew/homebrew-cask" = homebrew-cask;
                  };
                  mutableTaps = false;
                };
              }
              ./hosts/lt-yard-boy/configuration.nix
            ];
          };
      };
    };
}
