# KDE NixOS config
{ pkgs, ... }:

{
  imports = [ ../configuration.nix ];

  # Unlock default GNOME keyring on login
  security.pam.services.sddm.enableGnomeKeyring = true;

  environment = {
    variables.TERMINAL = "${pkgs.libsForQt5.konsole}/bin/konsole";

    plasma5.excludePackages = with pkgs.libsForQt5; [
      khelpcenter
      oxygen
    ];

    systemPackages = with pkgs; [
      # Needed for KDE Info Center
      clinfo
      glxinfo
      vulkan-tools
    ];
  };

  programs = {
    # Fixes potential GTK theme bugs in Wayland
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  services = {
    # Manually disable KWallet for GNOME keyring to work as secret service
    gnome.gnome-keyring.enable = true;

    xserver = {
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
    };
  };
}
