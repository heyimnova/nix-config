# User level KDE Plasma config
{ pkgs, ... }:

{
  imports = [
    ../home.nix
  ];

  services.gpg-agent.pinentryFlavor = "qt";
  # Add the plasma integration extension to the home profile
  programs.firefox.profiles.home.extensions = [ pkgs.nur.repos.rycee.firefox-addons.plasma-integration ];
}
