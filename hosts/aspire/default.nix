{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../secrets/users/aspire/nova
    ../../containers/caddy
  ];

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "aspire";
  services.openssh.enable = true;
  system.stateVersion = "23.05";
  users.users.nova.extraGroups = [ "wheel" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_hardened;

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
