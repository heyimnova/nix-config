# home-manager EasyEffects module
{ lib, config, pkgs, easyeffects-presets, easyeffects-presets-loudness-equalizer, ... }:

let
  cfg = config.modules.easyeffects;
in
{
  options.modules.easyeffects = {
    enable = lib.mkEnableOption "EasyEffects";
    presets.enable = lib.mkEnableOption "EasyEffects Presets";
    presets-loudness-equalizer.enable = lib.mkEnableOption "EasyEffects Presets (Loudness Equalizer)";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = [ pkgs.easyeffects ];

        file = {
          ".config/easyeffects/irs" = lib.mkIf cfg.presets.enable {
            source = "${easyeffects-presets}/irs";
            recursive = true;
          };

          ".config/easyeffects/output" = {
            recursive = true;

            source = pkgs.symlinkJoin {
              name = "easyeffects-output";

              paths = [
                (if cfg.presets.enable then "${easyeffects-presets}" else null)
                (if cfg.presets-loudness-equalizer.enable then "${easyeffects-presets-loudness-equalizer}" else null)
              ];
            };

            # Remove extra files present in the presets repos
            onChange = ''
              find $HOME/.config/easyeffects/output/irs -delete
              find $HOME/.config/easyeffects/output -type l -not -name "*.json" -delete
            '';
          };
        };
      };
    }

    (lib.mkIf config.desktops.gnome.enable {
      dconf.settings."org/gnome/shell".enabled-extensions = [ "eepresetselector@ulville.github.io" ];
      home.packages = [ pkgs.gnomeExtensions.easyeffects-preset-selector ];
    })
  ]);
}
