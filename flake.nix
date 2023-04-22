{
  description = "My NixOS config";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/release-22.11";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    nixpkgs.follows = "unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs @ { self, nixpkgs, stable, utils, home-manager, nur, ... }:
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
