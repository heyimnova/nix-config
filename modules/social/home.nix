# User level entertainment app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (discord.override {
      withOpenASAR = true;
    })
    element-desktop
    fluent-reader
    freetube
    revolt-desktop
    session-desktop
    signal-desktop
  ];
}
