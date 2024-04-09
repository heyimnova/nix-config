# home-manager KDE config
{ lib, config, pkgs, ... }:

lib.mkIf config.desktops.kde.enable {
  services.gpg-agent.pinentryPackage = pkgs.pinentry-qt;

  home = {
    packages = with pkgs; [
      qpwgraph
      tokodon
    ];

    file = {
      ".local/share/aurorae/themes/GruvboxAurorae".source = ../../../assets/GruvboxAurorae;
      ".local/share/color-schemes/GruvboxColors.colors".source = ../../../assets/GruvboxColors.colors;
    };

    pointerCursor = {
      gtk.enable = true;
      name = "Simp1e-Gruvbox-Dark";
      package = pkgs.simp1e-cursors;
      x11.enable = true;
    };
  };
}
