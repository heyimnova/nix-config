# Default home-manager desktop config
{ lib, config, pkgs, ... }:

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

    home.packages = with pkgs; [
      bitwarden
      bleachbit
      clamtk
      distrobox
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
}
