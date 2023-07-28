{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../secrets/users/idea/nova
    ../../containers/caddy
  ];

  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";
  networking.hostName = "idea";
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
