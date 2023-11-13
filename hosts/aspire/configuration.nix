# NixOS config for aspire
{ pkgs, flake-settings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
  ];

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "aspire";
  system.stateVersion = "23.05";
  users.users.${flake-settings.user}.extraGroups = [ "wheel" ];
  virtualisation.docker.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_hardened;

    loader.grub = {
      device = "/dev/sda";
      enable = true;
    };
  };

  services = {
    # Workaround to fix build error
    logrotate.checkConfig = false;
    openssh.enable = true;

    logind.extraConfig = ''
      # Disable the lid switch
      HandleLidSwitch=ignore
      HandleLidSwitchExternalPower=ignore
      HandleLidSwitchDocked=ignore
    '';
  };
}
