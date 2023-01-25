{ lib, inputs, nixpkgs, home-manager, nur, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  nova-desktop = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ({
        nixpkgs = {
          config.allowUnfree = true;
          overlays = [
            nur.overlay
          ];
        };
      })
      ./nova-desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.nova = {
          imports = [(import ./home.nix)] ++ [(import ./nova-desktop/home.nix)];
        };
      }
    ];
  };

  nova-laptop = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ({
        nixpkgs = {
          config.allowUnfree = true;
          overlays = [
            nur.overlay
          ];
        };
      })
      ./nova-laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.nova = {
          imports = [(import ./home.nix)];
        };
      }
    ];
  };
}

