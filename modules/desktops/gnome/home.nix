{ pkgs, ... }:

{
  home.packages = (with pkgs; [
    amberol
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
    status-area-horizontal-spacing
  ]);
}
