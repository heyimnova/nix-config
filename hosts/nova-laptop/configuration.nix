# NixOS config for nova-laptop
{ config, pkgs, flake-settings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
  ];

  console.keyMap = "uk";
  desktops.gnome.enable = true;
  i18n.defaultLocale = "en_GB.UTF-8";
  networking.hostName = "nova-laptop";
  sops.secrets."passwords/nova-laptop".neededForUsers = true;
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

  users.users.${flake-settings.user} = {
    hashedPasswordFile = config.sops.secrets."passwords/nova-laptop".path;

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
