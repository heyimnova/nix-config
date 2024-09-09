# GNOME NixOS config
{ lib, config, pkgs, ... }:

lib.mkIf config.desktops.gnome.enable {
  environment = {
    gnome.excludePackages = with pkgs; [
      baobab
      epiphany
      geary
      gnome-clocks
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-music
      gnome-photos
      gnome-tour
      orca
      totem
      yelp
    ];

    systemPackages = with pkgs; [
      clapper
      gnome-tweaks

      (writeShellScriptBin "xdg-terminal-exec" ''
        # Use blackbox for gtk-launch
        exec ${blackbox-terminal}/bin/blackbox -c "$*"
      '')
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
    udev.packages = [ pkgs.gnome-settings-daemon ];

    xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}
