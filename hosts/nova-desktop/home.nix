# home-manager config for nova-desktop
{ lib, pkgs, ... }:

{
  imports = [ ../../home-manager/home.nix ];

  desktops.gnome.enable = true;
  firefox.enable = true;
  gaming.enable = true;
  shells.nushell.enable = true;
  virtualisation.enable = true;

  apps = {
    productivity = true;
    social = true;
  };

  home = {
    packages = with pkgs; [
      polychromatic
      sbctl
    ];

    stateVersion = lib.mkForce "22.11";
  };

  modules.easyeffects = {
    enable = true;
    presets.enable = true;
    presets-loudness-equalizer.enable = true;
  };
}
