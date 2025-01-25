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
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    musnix.url = "github:musnix/musnix";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations = {
      dt-thinker-gear = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
	  inputs.musnix.nixosModules.musnix
          ./hosts/dt-thinker-gear/configuration.nix
        ];
      };
    };
  };
}
