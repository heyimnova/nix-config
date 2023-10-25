# home-manager KDE config
{ pkgs, ... }:

{
  imports = [ ../home.nix ];

  services.gpg-agent.pinentryFlavor = "qt";
}
