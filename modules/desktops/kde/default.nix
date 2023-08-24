# System-wide KDE Plasma config
{ pkgs, ... }:

{
  imports = [
    ../.
  ];

  # Fixes potential GTK theme bugs in Wayland
  programs.dconf.enable = true;

  environment = {
    variables.TERMINAL = "${pkgs.libsForQt5.konsole}/bin/konsole";

    plasma5.excludePackages = with pkgs.libsForQt5; [
      khelpcenter
      oxygen
    ];
  };

  services = {
    xserver = {
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
    };
  };
}
