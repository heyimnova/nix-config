# Default home-manager desktop config
{ lib, config, pkgs, easyeffects-presets,  ... }:

let
  cfg = config.desktops;
in
{
  imports = [
    ./gnome.nix
    ./kde.nix
  ];

  options.desktops = {
    gnome.enable = lib.mkEnableOption "GNOME apps and settings";
    kde.enable = lib.mkEnableOption "KDE apps and settings";
  };

  config = lib.mkIf (cfg.gnome.enable || cfg.kde.enable) {
    modules.spicetify.enable = true;

    home = {
      file = {
        ".config/easyeffects/irs" = {
          source = "${easyeffects-presets}/irs";
          recursive = true;
        };

        ".config/easyeffects/output" = {
          source = easyeffects-presets;
          recursive = true;

          # Remove extra files present in the repo
          onChange = ''
            find $HOME/.config/easyeffects/output/irs -type l -delete
            rmdir $HOME/.config/easyeffects/output/irs
            find $HOME/.config/easyeffects/output -type l -not -name "*.json" -delete
          '';
        };
      };

      packages = with pkgs; [
        birdtray
        bitwarden
        bleachbit
        # clamtk
        distrobox
        easyeffects
        logseq
        mission-center
        mullvad-browser
        pods
        protonmail-bridge-gui
        qbittorrent
        thunderbird
        tor-browser-bundle-bin
      ];
    };
  };
}
