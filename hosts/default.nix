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
    specialArgs = { inherit flake-settings; };

    modules = [
      ({ nixpkgs = nixpkgsOptions; })

      ./aspire

      ../secrets/users/aspire

      home-manager.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${flake-settings.user}.imports = [
            ./aspire/home.nix
          ];
        };
      }
    ];
  };

  nova-desktop = nixpkgs-rolling.lib.nixosSystem {
    specialArgs = { inherit flake-settings; };

    modules = [
      ({ nixpkgs = nixpkgsOptions; })

      lanzaboote.nixosModules.lanzaboote

      ./nova-desktop

      ../modules/apps/gaming
      ../modules/apps/virtualisation
      ../modules/desktops/gnome

      ../secrets/users/nova-desktop

      home-manager-rolling.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${flake-settings.user}.imports = [
            arkenfox.hmModules.arkenfox

            ./nova-desktop/home.nix

            ../modules/apps/entertainment/home.nix
            ../modules/apps/gaming/home.nix
            ../modules/apps/programming/home.nix
            ../modules/apps/social/home.nix
            ../modules/apps/virtualisation/home.nix
            ../modules/desktops/gnome/home.nix
          ];
        };
      }
    ];
  };

  nova-laptop = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit flake-settings; };

    modules = [
      ({ nixpkgs = nixpkgsOptions; })

      ./nova-laptop

      ../modules/desktops/gnome

      ../secrets/users/nova-laptop

      home-manager.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${flake-settings.user}.imports = [
            arkenfox.hmModules.arkenfox

            ./nova-laptop/home.nix

            ../modules/apps/entertainment/home.nix
            ../modules/apps/programming/home.nix
            ../modules/apps/social/home.nix
            ../modules/desktops/gnome/home.nix
          ];
        };
      }
    ];
  };
}
