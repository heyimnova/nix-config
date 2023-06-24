{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      watchmate
    ];

    stateVersion = "23.05";
  };
}
