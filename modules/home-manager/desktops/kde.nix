# home-manager KDE config
{ lib, config, pkgs, ... }:

lib.mkIf config.desktops.kde.enable {
  modules.alacritty.enable = true;
  services.gpg-agent.pinentryPackage = pkgs.pinentry-qt;
  stylix.targets.kde.enable = false;

  home = {
    packages = with pkgs; [
      qpwgraph
      tokodon
    ];

    file = {
      ".local/share/aurorae/themes/GruvboxAurorae".source = ../../../assets/GruvboxAurorae;
      ".local/share/color-schemes/GruvboxColors.colors".source = ../../../assets/GruvboxColors.colors;
    };
  };
}
