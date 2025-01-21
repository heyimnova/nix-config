# home-manager KDE config
{ lib, pkgs, variables, ... }:

lib.mkIf (variables.desktop == "kde") {
  services.gpg-agent.pinentryPackage = pkgs.pinentry-qt;
  stylix.targets.kde.enable = false;

  home = {
    packages = with pkgs; [
      qpwgraph
      tokodon
    ];

    # file = {
    #   ".local/share/aurorae/themes/GruvboxAurorae".source = ../../../config/GruvboxAurorae;
    #   ".local/share/color-schemes/GruvboxColors.colors".source = ../../../config/GruvboxColors.colors;
    # };
  };
}
