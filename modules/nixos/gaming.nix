# NixOS gaming config
{ lib, config, pkgs, ... }:

let
  cfg = config.gaming;
in
{
  options.gaming.enable = lib.mkEnableOption "gaming nixos options";

  config = lib.mkIf cfg.enable {
    services.pipewire.lowLatency.enable = true;

    programs = {
      gamemode.enable = true;
      steam.enable = true;
    };
  };
}
