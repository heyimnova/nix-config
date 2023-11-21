# NixOS gaming config
{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gamemode ];
  programs.steam.enable = true;
  services.pipewire.lowLatency.enable = true;
}
