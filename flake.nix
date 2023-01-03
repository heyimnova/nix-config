{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nur.url = "github:nix-community/NUR";    
    
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: 
  let
    unstableOverlay = final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      nova-desktop = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
          modules = [
            ({
              nixpkgs = {
                overlays = [
                  unstableOverlay
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

