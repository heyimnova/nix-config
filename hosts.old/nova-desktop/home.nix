# User level config for nova-desktop
{ pkgs, ... }:

{
  imports = [
    ../home.nix
    ../../modules/apps/entertainment/home.nix
    ../../modules/apps/gaming/home.nix
    ../../modules/apps/programming/home.nix
    ../../modules/apps/social/home.nix
    ../../modules/apps/virtualisation/home.nix
    ../../modules/desktops/gnome/home.nix
  ];

  home = {
    packages = with pkgs; [
      clamav
      cubiomes-viewer
      polychromatic
      (python3.withPackages(ps: with ps; [
        flet
      ]))
      sbctl
      sqlitebrowser
      woeusb
      gnome.zenity
    ];

    stateVersion = "22.11";
  };
}