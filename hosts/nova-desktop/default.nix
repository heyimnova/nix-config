{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/apps/desktop
    ../../modules/apps/gaming
    ../../modules/apps/virtualisation
    ../../modules/desktops/gnome
    ../../secrets/users/nova-desktop/nova
  ];

  console.keyMap = "us";
  environment.systemPackages = [ pkgs.droidcam ];
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "nova-desktop";
  system.stateVersion = "22.11";

  boot = {
    kernel.sysctl."vm.max_map_count" = 2147483642;
    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [ "ntfs" ];

    kernelParams = [
      "boot.shell_on_fail"
      "loglevel=3"
      "nvidia.drm.modeset=1"
      "rd.udev.log_level=3"
      "splash"
      "udev.log_priority=3"
    ];

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  hardware = {
    openrazer.enable = true;

    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      enable = true;
    };

    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  services.xserver = {
    layout = "us";
    videoDrivers = [ "nvidia" ];
    xkbVariant = "";
  };

  users.users.nova.extraGroups = [
    "libvirtd"
    "networkmanager"
    "openrazer"
    "wheel"
  ];
}
