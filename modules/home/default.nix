# Import all home-manager modules
{ ... }:

{
  imports = [
    ./desktops
    ./shells
    ./alacritty.nix
    ./apps.nix
    ./easyeffects.nix
    ./firefox.nix
    ./gaming.nix
    ./spicetify.nix
    ./virtualisation.nix
  ];
}
