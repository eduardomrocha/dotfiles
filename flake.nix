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
      # Use the system evaluating the flake, making it portable to any architecture.
      system = builtins.currentSystem;
      # Get the username from the environment. Requires the --impure flag.
      username = builtins.getEnv "USER";

      # Function to build a Home Manager configuration.
      # This avoids code repetition.
      mkHome = { profile }: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        # Pass the profile name and username as a special arguments to home.nix
        extraSpecialArgs = { inherit profile username; };
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
