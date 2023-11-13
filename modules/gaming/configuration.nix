# NixOS gaming config
{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gamemode ];
  nixpkgs.config.permittedInsecurePackages = [ "electron-24.8.6" ]; # Required by heroic
  programs.steam.enable = true;
}
