{
  description = "NixOS and home-manager configurations as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-index-database = {
      url = "github:mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, ... }@inputs:
  let
    flake-settings = { # Configurable settings for flake location in filesystem and default user
      location = "$HOME/.flake";
      stableVersion = "23.05";
      user = "nova";
      userDescription = "Nova";
      userHome = "/home/nova";
      userShell = "fish";
    };
  in
  {
    homeConfigurations = (
      with inputs; import ./home-manager {
        inherit nixpkgs-unstable home-manager-rolling nix-index-database flake-settings;
      }
    );

    nixosConfigurations = (
      with inputs; import ./hosts {
        inherit nixpkgs nixpkgs-unstable nur arkenfox home-manager home-manager-rolling lanzaboote nix-index-database flake-settings;
      }
    );
  };
}
