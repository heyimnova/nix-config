{ nixpkgs
, nixpkgs-unstable
, nur
, arkenfox
, home-manager
, home-manager-rolling
, lanzaboote
, nix-gaming
, nix-index-database
, sops-nix
, flake-settings
}:

let
  nixpkgsConfig.nixpkgs = {
    config.allowUnfree = true;
    overlays = [ nur.overlay ];
  };

  nixConfig.nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  modules = {
    home-manager = [
      ../modules/home-manager/apps.nix
      ../modules/home-manager/firefox.nix
      ../modules/home-manager/gaming.nix
      ../modules/home-manager/virtualisation.nix

      ../modules/home-manager/desktops
      ../modules/home-manager/shells

      arkenfox.hmModules.arkenfox
      nix-index-database.hmModules.nix-index
    ];

    nixos = [
      ../modules/nixos/gaming.nix
      ../modules/nixos/syncthing.nix
      ../modules/nixos/virtualisation.nix

      ../modules/nixos/desktops

      lanzaboote.nixosModules.lanzaboote
      nix-gaming.nixosModules.pipewireLowLatency
      sops-nix.nixosModules.sops
    ];
  };
in
{
  nova-desktop = nixpkgs-unstable.lib.nixosSystem {
    specialArgs = { inherit flake-settings; };

    modules = ([
      (nixpkgsConfig)
      (nixConfig)

      ./nova-desktop/configuration.nix

      home-manager-rolling.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${flake-settings.user}.imports = ([ ./nova-desktop/home.nix ] ++ modules.home-manager);
        };
      }
    ] ++ modules.nixos);
  };

  nova-laptop = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit flake-settings; };

    modules = ([
      (nixpkgsConfig)

      ./nova-laptop/configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager = {
          extraSpecialArgs = { inherit flake-settings; };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${flake-settings.user}.imports = ([ ./nova-laptop/home.nix ] ++ modules.home-manager);
        };
      }
    ] ++ modules.nixos);
  };
}
