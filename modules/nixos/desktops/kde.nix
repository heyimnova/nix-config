# KDE NixOS config
{
  lib,
  pkgs,
  variables,
  ...
}:
lib.mkIf (variables.desktop == "kde") {
  # To remove hibernate from the power menu
  boot.kernelParams = ["nohibernate"];
  programs.kdeconnect.enable = true;
  # Unlock gnome-keyring on login
  security.pam.services.sddm.enableGnomeKeyring = true;

  environment = {
    # Run the wayland native versions of supported applications
    sessionVariables.NIXOS_OZONE_WL = "1";

    plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      khelpcenter
    ];

    systemPackages = with pkgs; [
      # Needed for KDE Info Center
      clinfo
      glxinfo
      vulkan-tools
      # Themeing
      gruvbox-plus-icons
    ];
  };

  services = {
    desktopManager.plasma6.enable = true;
    # Manually disable KWallet for GNOME keyring to work as secret service
    gnome.gnome-keyring.enable = true;

    displayManager.sddm = {
      enable = true;
      # wayland.enable = true;
      autoNumlock = true;
    };
  };

  # qt = {
  #   enable = true;
  #   platformTheme = "kde";
  #   style = "breeze";
  # };
}
