# User level social app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (discord.override {
      # Don't tell Discord 🤫
      withOpenASAR = true;
    })
    element-desktop
    revolt-desktop
    session-desktop
    signal-desktop
  ];
}
