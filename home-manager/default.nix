{ nixpkgs-unstable
, home-manager-rolling
, nix-index-database
, nixvim
, flake-settings
}:

{
  # Default user standalone home-manager configuration
  ${flake-settings.user} = home-manager-rolling.lib.homeManagerConfiguration {
    extraSpecialArgs = { inherit flake-settings; };
    pkgs = nixpkgs-unstable.legacyPackages."x86_64-linux";

    modules = [
      ./home.nix

      ../modules/home-manager/shells

      ../modules/nixvim.nix

      nix-index-database.hmModules.nix-index
      nixvim.homeManagerModules.nixvim
    ];
  };
}
