{
  description = "My NixOS configs";

  inputs = {
    stable.url = "github:nixos/nixpkgs/release-23.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "stable";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "unstable";
    };

    nixpkgs.follows = "unstable";
  };

  outputs = inputs @ { self, nixpkgs, stable, utils, home-manager, home-manager-unstable, nur, lanzaboote, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        nur.overlay
      ];

      hostDefaults.modules = [
        ./hosts
      ];

      hosts.nova-desktop.modules = [
        ./hosts/nova-desktop
        lanzaboote.nixosModules.lanzaboote
        home-manager-unstable.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nova.imports = [
            ./hosts/nova-desktop/home.nix
            ./hosts/home.nix
          ];
        }
      ];

      hosts.nova-laptop = {
        channelName = "stable";
        modules = [
          ./hosts/nova-laptop
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nova.imports = [
              ./hosts/nova-laptop/home.nix
              ./hosts/home.nix
            ];
          }
        ];
      };

      hosts.idea = {
        channelName = "stable";
        modules = [
          ./hosts/idea
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nova.imports = [
              ./hosts/idea/home.nix
              ./hosts/home.nix
            ];
          }
        ];
      };
    };
}
