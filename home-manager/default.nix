{ inputs, flake-settings }:

let
  # Unpack required values from inputs
  inherit (inputs) nixpkgs-unstable nix-colors home-manager-rolling nix-index-database nixvim;

  # Define inputs to be passed to further configs
  config-inputs = with inputs; { inherit nix-colors nur firefox-gnome-theme flake-settings; };
in
{
  # Default user standalone home-manager configuration
  ${flake-settings.user} = home-manager-rolling.lib.homeManagerConfiguration {
    extraSpecialArgs = config-inputs;
    pkgs = nixpkgs-unstable.legacyPackages."x86_64-linux";

    modules = [
      ./home.nix

      ../modules/home-manager/alacritty.nix

      ../modules/home-manager/shells

      ../modules/nixvim.nix

      nix-colors.homeManagerModules.default
      nix-index-database.hmModules.nix-index
      nixvim.homeManagerModules.nixvim
    ];
  };
}
