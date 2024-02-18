# home-manager virtualisation config
{ lib, config, pkgs, ... }:

let
  cfg = config.virtualisation;
in
{
  options.virtualisation.enable = lib.mkEnableOption "virtualisation services";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (callPackage ../../packages/quickgui { })
    ];
  };
}
