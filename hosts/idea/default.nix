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

  boot = {
    kernelPackages = pkgs.linuxPackages_hardened;

    loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
    };
  };

  networking.firewall = {
    enable = true;

    interfaces.enp0s4.allowedTCPPorts = [
      80
      443
    ];
  };

  services = {
    caddy = {
      enable = true;

      extraConfig = ''

      '';
    };

    logind.extraConfig = ''
      # disable the lid switch
      HandleLidSwitch=ignore
      HandleLidSwitchExternalPower=ignore
      HandleLidSwitchDocked=ignore
    '';
  };

  users = {
    groups.caddyProxy.members = [ "caddyProxy" ];

    users = {
      nova.extraGroups = [ "wheel" ];

      caddyProxy = {
        createHome = true;
        group = "caddyProxy";
        home = "/var/lib/caddyProxy";
        isSystemUser = true;
      };
    };
  };
}
