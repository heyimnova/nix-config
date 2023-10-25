# home-manager config for nova-desktop
{ pkgs, lib, ... }:

{
  imports = [ ../../home-manager/home.nix ];

  home = {
    packages = with pkgs; [
      clamav
      cubiomes-viewer
      polychromatic
      sbctl
      sqlitebrowser
      woeusb
      gnome.zenity
    ];

    stateVersion = lib.mkForce "22.11";
  };
}
