# home-manager config for nova-desktop
{ lib, pkgs, ... }:

{
  # This file extends the default home-manager config
  imports = [ ../../home/home.nix ];

  shells.nushell.enable = true;

  home = {
    packages = with pkgs; [
      polychromatic
      sbctl
    ];

    stateVersion = lib.mkForce "22.11";
  };

  modules = {
    firefox.enable = true;
    gaming.enable = true;
    virtualisation.enable = true;

    apps = {
      productivity = true;
      social = true;
    };

    easyeffects = {
      enable = true;
      presets.enable = true;
      presets-loudness-equalizer.enable = true;
    };
  };
}
