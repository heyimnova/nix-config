# home-manager virtualisation config
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.virtualisation;
in {
  options.modules.virtualisation.enable = lib.mkEnableOption "virtualisation services";

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.quickemu];
  };
}
