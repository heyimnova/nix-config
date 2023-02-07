{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, utils, home-manager, nur, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        nur.overlay
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

      hosts.nova-desktop = {
        channelName = "nixpkgs-unstable";
        modules = [
          ./hosts/nova-desktop
          home-manager.nixosModules.home-manager {
            home-manager.users.nova.imports = [
              ./hosts/nova-desktop/home.nix
            ];
          }
        ];
      };

      hosts.nova-laptop.modules = [
        ./hosts/nova-laptop
        home-manager.nixosModules.home-manager {
          home-manager.users.nova.imports = [
            ./hosts/nova-laptop/home.nix
          ];
        }
      ];
    };
}
