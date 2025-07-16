# ~/dotfiles/flake.nix
{
  description = "My Personal Environment Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
    };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }:
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
          catppuccin.homeModules.catppuccin
        ];
      };

    in {
      # Personal Profile: make personal
      homeConfigurations."${username}-personal" = mkHome { profile = "personal"; };

      # Work Profile: make work
      homeConfigurations."${username}-work" = mkHome { profile = "work"; };
    };
}
