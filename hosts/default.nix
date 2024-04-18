{ inputs, flake-settings }:

let
  # Unpack inputs needed in this file
  inherit (inputs) arkenfox home-manager home-manager-rolling lanzaboote nix-gaming nix-index-database nixpkgs nixpkgs-unstable nixvim sops-nix;

  # Inputs to be passed to further configs
  config-inputs = with inputs; { inherit firefox-gnome-theme nur flake-settings; };

  modules = {
    home-manager = [
      ../modules/home-manager/apps.nix
      ../modules/home-manager/firefox.nix
      ../modules/home-manager/gaming.nix
      ../modules/home-manager/virtualisation.nix

      ../modules/home-manager/desktops
      ../modules/home-manager/shells

      ../modules/nixvim.nix

      arkenfox.hmModules.arkenfox
      nix-index-database.hmModules.nix-index
      nixvim.homeManagerModules.nixvim
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
    specialArgs = config-inputs;

    modules = ([
      ./nova-desktop/configuration.nix

      home-manager-rolling.nixosModules.home-manager {
        home-manager = {
          backupFileExtension = "hmbak";
          extraSpecialArgs = config-inputs;
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${flake-settings.user}.imports = ([ ./nova-desktop/home.nix ] ++ modules.home-manager);
        };
      }
    ] ++ modules.nixos);
  };

  nova-laptop = nixpkgs.lib.nixosSystem {
    specialArgs = config-inputs;

    modules = ([
      ./nova-laptop/configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager = {
          backupFileExtension = "hmbak";
          extraSpecialArgs = config-inputs;
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${flake-settings.user}.imports = ([ ./nova-laptop/home.nix ] ++ modules.home-manager);
        };
      }
    ] ++ modules.nixos);
  };
}
