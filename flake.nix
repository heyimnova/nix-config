{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nur.url = "github:nix-community/NUR";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  {
    nixosConfigurations = {
      nova-desktop = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
          modules = [
            ({
              nixpkgs = {
                overlays = [
                  inputs.nur.overlay
                ];
                config.allowUnfree = true;
              };
            })
            ./configuration.nix
          ];
      };
    };
  };
}

