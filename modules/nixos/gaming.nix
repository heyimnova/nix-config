# NixOS gaming config
{ lib, config, pkgs, ... }:

let
  cfg = config.gaming;
in
{
  options.gaming.enable = lib.mkEnableOption "gaming nixos options";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.gamemode ];
    programs.steam.enable = true;
    services.pipewire.lowLatency.enable = true;
  };
}
