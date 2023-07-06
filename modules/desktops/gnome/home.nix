{ pkgs, ... }:

{
  services.gpg-agent.pinentryFlavor = "gnome3";

  home.packages = (with pkgs; [
    amberol
    curtail
    gnome-obfuscate
    mousai
    warp
  ]) ++ (with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    appindicator
    blur-my-shell
    caffeine
    clipboard-indicator
    grand-theft-focus
    logo-menu
    #openweather
    status-area-horizontal-spacing
    vitals
  ]);
}
