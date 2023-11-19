# home-manager virtualisation config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (callPackage ../../packages/quickgui { })
  ];
}
