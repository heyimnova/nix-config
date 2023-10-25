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

      ../secrets/users/aspire.nix

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

      ../modules/desktops/gnome
      ../modules/gaming
      ../modules/virtualisation

      ../secrets/users/nova-desktop.nix

      home-manager-rolling.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${flake-settings.user}.imports = [
            arkenfox.hmModules.arkenfox

            ./nova-desktop/home.nix

            ../modules/desktops/gnome/home.nix
            ../modules/gaming/home.nix
            ../modules/productivity/home.nix
            ../modules/social/home.nix
            ../modules/virtualisation/home.nix
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

      ../secrets/users/nova-laptop.nix

      home-manager.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${flake-settings.user}.imports = [
            arkenfox.hmModules.arkenfox

            ./nova-laptop/home.nix

            ../modules/desktops/gnome/home.nix
            ../modules/productivity/home.nix
            ../modules/social/home.nix
          ];
        };
      }
    ];
  };
}
