# Entry point for generating NixOS hosts
{ nixpkgs, nixpkgs-stable, inputs, variables }:

# Declare modules
let
  modules = {
    home-manager = [
      ../modules/home

      inputs.arkenfox.hmModules.arkenfox
      inputs.nix-index-database.hmModules.nix-index
      inputs.spicetify-nix.homeManagerModules.default
    ];

    nixos = [
      ../modules/nixos
      ../modules/nixvim.nix
      ../modules/stylix.nix

      inputs.stylix.nixosModules.stylix
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      inputs.nix-gaming.nixosModules.platformOptimizations
      inputs.nixvim.nixosModules.nixvim
      inputs.sops-nix.nixosModules.sops
    ];
  };
in
{
  nova-desktop = nixpkgs-stable.lib.nixosSystem {
    specialArgs = { # Pass inputs and variables as arguments
      inherit inputs variables;
    };

    # Import nova-desktop NixOS config with the modules declared earlier
    modules = ([
      ./nova-desktop/configuration.nix

      inputs.home-manager-stable.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          # Import nova-desktop home-manager config with the modules declared earlier
          users.${variables.user}.imports = ([ ./nova-desktop/home.nix ] ++ modules.home-manager);

          extraSpecialArgs = { # Pass inputs and variables as arguments to home-manager configuration
            inherit inputs variables;
          };
        };
      }
    ] ++ modules.nixos);
  };

  nova-laptop = nixpkgs-stable.lib.nixosSystem {
    specialArgs = {
      inherit inputs variables;
    };

    modules = ([
      ./nova-laptop/configuration.nix

      inputs.home-manager-stable.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${variables.user}.imports = ([ ./nova-laptop/home.nix ] ++ modules.home-manager);

          extraSpecialArgs = {
            inherit inputs variables;
          };
        };
      }
    ] ++ modules.nixos);
  };
}
