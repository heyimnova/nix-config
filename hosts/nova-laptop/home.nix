{ pkgs, ... }:

{
  imports = [
    ../home.nix
		../../modules/apps/desktop/home.nix
    ../../modules/apps/entertainment/home.nix
    ../../modules/apps/social/home.nix
    ../../modules/desktops/gnome/home.nix
  ];

  home = {
    packages = with pkgs; [
      watchmate
    ];

    stateVersion = "23.05";
  };
}
