{ nixpkgs-rolling
, home-manager-rolling
, flake-settings
}:

{
  # Default user standalone home-manager configuration
  ${flake-settings.user} = home-manager-rolling.lib.homeManagerConfiguration {
    extraSpecialArgs = { inherit flake-settings; };
    pkgs = nixpkgs-rolling.legacyPackages."x86_64-linux";

    modules = [
      ./home.nix
    ];
  };
}
