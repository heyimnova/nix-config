# home-manager social app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    element-desktop
    fluent-reader
    freetube
    revolt-desktop
    session-desktop
    signal-desktop

    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
