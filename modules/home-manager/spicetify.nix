{ config, lib, pkgs, spicetify-nix, ... }:

let
  cfg = config.modules.spicetify;
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  options.modules.spicetify.enable = lib.mkEnableOption "my spicetify config";

  config = lib.mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.Comfy;

      enabledExtensions = with spicePkgs.extensions; [
        playlistIntersection
        savePlaylists
      ];
    };
  };
}
