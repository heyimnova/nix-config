# NixOS config for nova-laptop
{ config, variables, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
  ];

  networking.hostName = "nova-laptop";
  # Localization
  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";
  # Make sure password file is loaded at boot
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

  # More localization
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Create the user with the predefined password
  users.users.${variables.user} = {
    hashedPasswordFile = config.sops.secrets."passwords/nova-laptop".path;

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
