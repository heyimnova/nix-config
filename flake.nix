{
  description = "My NixOS config";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/release-22.11";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "unstable";
    };

    nixpkgs.follows = "unstable";
  };

  outputs = inputs @ { self, nixpkgs, stable, utils, home-manager, nur, lanzaboote, ... }:
  let
    unstable-overlay = self: super: {
      unstable = import inputs.unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };
  in
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        nur.overlay
        unstable-overlay
      ];

      hostDefaults.modules = [
        ./hosts
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nova.imports = [
            ./hosts/home.nix
          ];
        }
      ];

      hosts.nova-desktop.modules = [
        ./hosts/nova-desktop
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager {
          home-manager.users.nova.imports = [
            ./hosts/nova-desktop/home.nix
          ];
        }
      ];

      hosts.nova-laptop = {
        channelName = "stable";
        modules = [
          ./hosts/nova-laptop
          home-manager.nixosModules.home-manager {
            home-manager.users.nova.imports = [
              ./hosts/nova-laptop/home.nix
            ];
          }
        ];
      };
    };
}
