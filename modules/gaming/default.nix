# System-wide gaming app config
{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gamemode ];
  programs.steam.enable = true;
}
