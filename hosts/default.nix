{ nixpkgs
, nixpkgs-unstable
, nur
, arkenfox
, home-manager
, home-manager-rolling
, lanzaboote
, flake-settings
}:

let
  nixpkgsConfig.nixpkgs = {
    overlays = [ nur.overlay ];
    config.allowUnfree = true;
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

      lanzaboote.nixosModules.lanzaboote

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
