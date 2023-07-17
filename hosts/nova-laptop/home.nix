# User level config for nova-laptop
{ pkgs, ... }:

{
  imports = [
    ../home.nix
    ../../modules/apps/desktop/home.nix
    ../../modules/apps/entertainment/home.nix
    ../../modules/apps/programming/home.nix
    ../../modules/apps/social/home.nix
    ../../modules/desktops/gnome/home.nix
  ];

  home = {
    packages = [ pkgs.watchmate ];
    stateVersion = "23.05";
  };
}
