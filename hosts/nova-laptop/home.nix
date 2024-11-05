# home-manager config for nova-laptop
{ lib, pkgs, ... }:

{
  # This file extends the default home-manager config
  imports = [ ../../home/home.nix ];

  home = {
    packages = [ pkgs.watchmate ];
    stateVersion = lib.mkForce "23.05";
  };

  modules = {
    firefox.enable = true;

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
