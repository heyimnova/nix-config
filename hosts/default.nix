{ nixpkgs
, nixpkgs-unstable
, nur
, arkenfox
, home-manager
, home-manager-rolling
, lanzaboote
, nix-gaming
, nix-index-database
, flake-settings
}:

let
  nixpkgsConfig.nixpkgs = {
    overlays = [ nur.overlay ];
    config.allowUnfree = true;
  };

  nixConfig.nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };
in
{
  aspire = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit flake-settings; };

    modules = [
      (nixpkgsConfig)

      ./aspire/configuration.nix

      ../secrets/users/aspire.nix

      home-manager.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${flake-settings.user}.imports = [
            nix-index-database.hmModules.nix-index

            ./aspire/home.nix
            ../modules/shells
          ];
        };
      }
    ];
  };

  nova-desktop = nixpkgs-unstable.lib.nixosSystem {
    specialArgs = { inherit flake-settings; };

    modules = [
      (nixpkgsConfig)
      (nixConfig)

      lanzaboote.nixosModules.lanzaboote
      nix-gaming.nixosModules.pipewireLowLatency

      ./nova-desktop/configuration.nix

      ../modules/desktops/gnome/configuration.nix
      ../modules/gaming/configuration.nix
      ../modules/virtualisation/configuration.nix

      ../secrets/users/nova-desktop.nix

      home-manager-rolling.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${flake-settings.user}.imports = [
            arkenfox.hmModules.arkenfox
            nix-index-database.hmModules.nix-index

            ./nova-desktop/home.nix

            ../modules/desktops/gnome/home.nix
            ../modules/firefox.nix
            ../modules/gaming/home.nix
            ../modules/productivity.nix
            ../modules/shells
            ../modules/social.nix
            ../modules/virtualisation/home.nix
          ];
        };
      }
    ];
  };

  nova-laptop = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit flake-settings; };

    modules = [
      (nixpkgsConfig)

      ./nova-laptop/configuration.nix

      ../modules/desktops/gnome/configuration.nix

      ../secrets/users/nova-laptop.nix

      home-manager.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${flake-settings.user}.imports = [
            arkenfox.hmModules.arkenfox
            nix-index-database.hmModules.nix-index

            ./nova-laptop/home.nix

            ../modules/desktops/gnome/home.nix
            ../modules/firefox.nix
            ../modules/productivity.nix
            ../modules/shells
            ../modules/social.nix
          ];
        };
      }
    ];
  };
}
