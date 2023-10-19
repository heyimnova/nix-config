{
  description = "NixOS and home-manager configurations as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    nixpkgs-rolling.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-rolling = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-rolling";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs-rolling";
    };
  };

  outputs = { nixpkgs, nixpkgs-rolling, nur, arkenfox, home-manager, home-manager-rolling, lanzaboote, ... }:
  let
    flake-settings = { # Configurable settings for flake location in filesystem and default user
      location = "$HOME/.flake";
      user = "nova";
      userDescription = "Nova";
    };
  in
  {
    nixosConfigurations = (
      import ./hosts {
        inherit nixpkgs nixpkgs-rolling nur arkenfox home-manager home-manager-rolling lanzaboote flake-settings;
      }
    );
  };
}
