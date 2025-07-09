# ~/dotfiles/flake.nix
{
  description = "My Personal Environment Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }:
    let
      system = "x86_64-linux";
      username = "eduardo";

      # Function to build a Home Manager configuration.
      # This avoids code repetition.
      mkHome = { profile }: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        # Pass the profile name as a special argument to home.nix
        extraSpecialArgs = { inherit profile; };
        modules = [
          ./home.nix
          sops-nix.homeManagerModules.sops
        ];
      };

    in {
      # Personal Profile: make personal
      homeConfigurations."${username}-personal" = mkHome { profile = "personal"; };

      # Work Profile: make work
      homeConfigurations."${username}-work" = mkHome { profile = "work"; };
    };
}
