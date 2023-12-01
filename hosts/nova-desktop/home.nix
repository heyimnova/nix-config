# home-manager config for nova-desktop
{ pkgs, lib, ... }:

{
  imports = [ ../../home-manager/home.nix ];

  home = {
    packages = with pkgs; [
      polychromatic
      sbctl

      (libsForQt5.callPackage ../../packages/discord-screenaudio { })
    ];

    stateVersion = lib.mkForce "22.11";
  };
}
