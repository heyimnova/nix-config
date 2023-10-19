{ nixpkgs
, nixpkgs-rolling
, nur
, arkenfox
, home-manager
, home-manager-rolling
, lanzaboote
, flake-settings
}:

let
  nixpkgsOptions = {
    overlays = [ nur.overlay ];
    config.allowUnfree = true;
  };
in
{
  aspire = nixpkgs.lib.nixosSystem {
    modules = [
      ({ nixpkgs = nixpkgsOptions; })

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  nova-desktop = nixpkgs-rolling.lib.nixosSystem {
    modules = [
      lanzaboote.nixosModules.lanzaboote
      ({ nixpkgs = nixpkgsOptions; })

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users.${flake-settings.user}.imports = [
          arkenfox.hmModules.arkenfox
        ];
      }
    ];
  };

  nova-laptop = nixpkgs.lib.nixosSystem {
    modules = [
      ({ nixpkgs = nixpkgsOptions; })

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users.${flake-settings.user}.imports = [
          arkenfox.hmModules.arkenfox
        ];
      }
    ];
  };
}
