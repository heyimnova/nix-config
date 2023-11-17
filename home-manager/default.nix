{ nixpkgs-unstable
, home-manager-rolling
, nix-index-database
, flake-settings
}:

{
  # Default user standalone home-manager configuration
  ${flake-settings.user} = home-manager-rolling.lib.homeManagerConfiguration {
    extraSpecialArgs = { inherit flake-settings; };
    pkgs = nixpkgs-unstable.legacyPackages."x86_64-linux";

    modules = [
      nix-index-database.hmModules.nix-index

      ./home.nix
      ../modules/shells
    ];
  };
}
