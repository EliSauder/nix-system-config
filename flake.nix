{
  description = "Nixos config flake";

  nixConfig = {
    substituters = [
	"https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
    ];
    trusted-public-keys = [
	"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations = {
      dt-thinker-gear = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/dt-thinker-gear/configuration.nix
        ];
      };
    };
  };
}
