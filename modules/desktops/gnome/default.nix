# System-wide Gnome config
{ pkgs, ... }:

{
  imports = [
    ../.
  ];

  programs.dconf.enable = true;

  environment = {
    variables.TERMINAL = "${pkgs.blackbox-terminal}/bin/blackbox";

    gnome.excludePackages = (with pkgs; [
      baobab
      gnome-connections
      gnome-console
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
      gnomeExtensions.gsconnect
    ];
  };

  services = {
    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];

    xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}
