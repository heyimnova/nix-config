# System-wide config for aspire
{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../secrets/users/aspire
  ];

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "aspire";
  system.stateVersion = "23.05";
  users.users.nova.extraGroups = [ "wheel" ];
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
