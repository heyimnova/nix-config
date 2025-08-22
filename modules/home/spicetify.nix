{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.spicetify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  options.modules.spicetify.enable = lib.mkEnableOption "my spicetify config";

  config = lib.mkIf cfg.enable {
    stylix.targets.spicetify.enable = false;

    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.ziro;
      colorScheme = "rose-pine";

      enabledExtensions = with spicePkgs.extensions; [
        addToQueueTop
        keyboardShortcut
        playlistIntersection
        volumePercentage
      ];
    };
  };
}
