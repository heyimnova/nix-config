# home-manager config for nova-laptop
{ lib, pkgs, ... }:

{
  imports = [ ../../home-manager/home.nix ];

  desktops.gnome.enable = true;
  firefox.enable = true;

  apps = {
    productivity = true;
    social = true;
  };

  home = {
    packages = [ pkgs.watchmate ];
    stateVersion = lib.mkForce "23.05";
  };

  modules.easyeffects = {
    enable = true;
    presets.enable = true;
  };
}
