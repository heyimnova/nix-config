{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gamemode ];
  programs.steam.enable = true;
}
