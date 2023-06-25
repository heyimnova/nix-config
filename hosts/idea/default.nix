{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";
  networking.hostName = "idea";
  services.openssh.enable = true;
  system.stateVersion = "23.05";
  virtualisation.docker.enable = true;

  boot = {
    kernel.sysctl."net.core.rmem_max"=2500000;

    loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
    };
  };

  services.logind.extraConfig = ''
    # disable the lid switch
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
  '';
}
