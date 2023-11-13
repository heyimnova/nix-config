# NixOS config for nova-laptop
{ config, pkgs, flake-settings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
  ];

  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";
  networking.hostName = "nova-laptop";
  system.stateVersion = "23.05";

  boot = {
    initrd.systemd.enable = true;

    kernelParams = [
      "quiet"
      "splash"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    plymouth = {
      enable = true;
      theme = "bgrt";
    };
  };

  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  users.users.${flake-settings.user}.extraGroups = [
    "networkmanager"
    "wheel"
  ];
}
