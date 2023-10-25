# home-manager config for nova-desktop
{ pkgs, lib, ... }:

{
  imports = [ ../../home-manager/home.nix ];

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

    stateVersion = lib.mkForce "22.11";
  };
}
