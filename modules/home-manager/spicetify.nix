{ config, lib, pkgs, spicetify-nix, ... }:

let
  cfg = config.modules.spicetify;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  options.modules.spicetify.enable = lib.mkEnableOption "my spicetify config";

  config = lib.mkIf cfg.enable {
    stylix.targets.spicetify.enable = false;

    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.defaultDynamic;

      enabledExtensions = with spicePkgs.extensions; [
        playlistIntersection
        savePlaylists
      ];
    };
  };
}
