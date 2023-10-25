# Gnome NixOS config
{ pkgs, ... }:

{
  imports = [ ../. ];

  environment = {
    variables.TERMINAL = "${pkgs.blackbox-terminal}/bin/blackbox";

    gnome.excludePackages = (with pkgs; [
      baobab
      gnome-connections
      gnome-photos
      gnome-tour
      orca
    ]) ++ (with pkgs.gnome; [
      atomix
      cheese
      epiphany
      geary
      gedit
      gnome-clocks
      gnome-contacts
      gnome-music
      gnome-software
      hitori
      tali
      totem
      yelp
      yelp-xsl
    ]);

    systemPackages = with pkgs; [
      blackbox-terminal
      clapper
      gnome.gnome-tweaks
    ];
  };

  programs = {
    dconf.enable = true;

    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };

  services = {
    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];

    xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}
