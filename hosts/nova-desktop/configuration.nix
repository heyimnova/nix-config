# NixOS config for nova-desktop
{ config, pkgs, flake-settings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
  ];

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "nova-desktop";
  system.stateVersion = "22.11";
  # Enable Nvidia GPU use within Podman containers
  virtualisation.podman.enableNvidia = true;

  boot = {
    # Set virtual memory max map count to MAX_INT - 5, fixes some bugs with games under Proton
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

  environment = {
    gnome.excludePackages = [ pkgs.snapshot ];
    systemPackages = [ pkgs.droidcam ];
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

  users.users.${flake-settings.user}.extraGroups = [
    "libvirtd"
    "networkmanager"
    "openrazer"
    "wheel"
  ];
}
