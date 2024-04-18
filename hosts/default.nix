{ inputs, flake-settings }:

let
  # Unpack inputs needed in this file
  inherit (inputs) nixpkgs nixpkgs-unstable nix-colors nix-gaming spicetify-nix arkenfox home-manager home-manager-rolling lanzaboote nix-index-database nixvim sops-nix;

  # Inputs to be passed to further configs
  config-inputs = with inputs; { inherit nix-colors nur spicetify-nix firefox-gnome-theme flake-settings; };

  modules = {
    home-manager = [
      ../modules/home-manager/alacritty.nix
      ../modules/home-manager/apps.nix
      ../modules/home-manager/firefox.nix
      ../modules/home-manager/gaming.nix
      ../modules/home-manager/spicetify.nix
      ../modules/home-manager/virtualisation.nix

      ../modules/home-manager/desktops
      ../modules/home-manager/shells

      arkenfox.hmModules.arkenfox
      nix-colors.homeManagerModules.default
      nix-index-database.hmModules.nix-index
      spicetify-nix.homeManagerModule
    ];

    nixos = [
      ../modules/nixos/gaming.nix
      ../modules/nixos/syncthing.nix
      ../modules/nixos/virtualisation.nix

      ../modules/nixvim.nix

      ../modules/nixos/desktops

      lanzaboote.nixosModules.lanzaboote
      nix-gaming.nixosModules.pipewireLowLatency
      nixvim.nixosModules.nixvim
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
