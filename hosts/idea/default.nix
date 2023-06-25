{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../secrets/users/idea/nova
  ];

  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";
  networking.hostName = "idea";
  services.openssh.enable = true;
  system.stateVersion = "23.05";
  users.users.nova.extraGroups = [ "wheel" ];

  boot = {
    kernel.sysctl."net.core.rmem_max"=2500000;

    loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.logind.extraConfig = ''
    # disable the lid switch
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
  '';
}
