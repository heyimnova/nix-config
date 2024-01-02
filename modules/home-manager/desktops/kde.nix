# home-manager KDE config
{ lib, config, pkgs, ... }:

lib.mkIf config.desktops.kde.enable {
  services.gpg-agent.pinentryFlavor = "qt";
}
