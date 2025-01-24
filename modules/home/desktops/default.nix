# Default home-manager desktop config
{
  lib,
  pkgs,
  variables,
  ...
}: {
  imports = [
    ./gnome.nix
    ./kde.nix
  ];

  config = lib.mkIf (variables.desktop != "") {
    modules.spicetify.enable = true;

    home.packages = with pkgs; [
      bitwarden
      bleachbit
      clamtk
      distrobox
      logseq
      mullvad-browser
      protonmail-desktop
      qbittorrent
      thunderbird
      tor-browser-bundle-bin
    ];
  };
}
