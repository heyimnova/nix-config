{
  description = "My NixOS configs";

  inputs = {
    nur.url = "github:nix-community/NUR";
    stable.url = "github:nixos/nixpkgs/release-23.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

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

  outputs = inputs @ { self, home-manager, home-manager-unstable, lanzaboote, nixpkgs, nur, stable, utils, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;
      hostDefaults.modules = [ ./hosts ];
      sharedOverlays = [ nur.overlay ];

      hosts.aspire = {
        channelName = "stable";

        modules = [
          ./hosts/aspire

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.users.nova.imports = [ ./hosts/aspire/home.nix ];
            home-manager.useUserPackages = true;
          }
        ];
      };

      hosts.nova-desktop.modules = [
        ./hosts/nova-desktop
        lanzaboote.nixosModules.lanzaboote

        home-manager-unstable.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.users.nova.imports = [ ./hosts/nova-desktop/home.nix ];
          home-manager.useUserPackages = true;
        }
      ];

      hosts.nova-laptop = {
        channelName = "stable";

        modules = [
          ./hosts/nova-laptop

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.users.nova.imports = [ ./hosts/nova-laptop/home.nix ];
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
}
