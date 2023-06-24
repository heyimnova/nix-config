{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (discord.override {
      withOpenASAR = true;
    })
    element-desktop
    revolt-desktop
    session-desktop
    signal-desktop
  ];
}
