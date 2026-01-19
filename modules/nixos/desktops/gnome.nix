# GNOME NixOS config
{
  lib,
  pkgs,
  variables,
  ...
}:
lib.mkIf (variables.desktop == "gnome") {
  environment = {
    # Default packages I don't want
    gnome.excludePackages = with pkgs; [
      baobab
      epiphany
      geary
      gnome-clocks
      gnome-connections
      gnome-contacts
      gnome-music
      gnome-photos
      gnome-tour
      orca
      totem
      yelp
    ];

    systemPackages = with pkgs; [
      gnome-tweaks

      (writeShellScriptBin "xdg-terminal-exec" ''
        # Use ghostty for gtk-launch
        exec ${lib.getExe pkgs.ghostty} -e "$*"
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
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    udev.packages = [pkgs.gnome-settings-daemon];
  };
}
