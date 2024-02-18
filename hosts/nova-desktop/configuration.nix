# NixOS config for nova-desktop
{ lib, config, pkgs, flake-settings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
  ];

  console.keyMap = "us";
  desktops.gnome.enable = true;
  gaming.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "nova-desktop";
  system.stateVersion = "22.11";

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
    videoDrivers = [ "nvidia" ];

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  syncthing = {
    devices.coral = true;
    enable = true;
    folders.logseq = true;
  };

  users.users.${flake-settings.user}.extraGroups = [
    "libvirtd"
    "networkmanager"
    "openrazer"
    "wheel"
  ];

  virtualisation = {
    enable = true;
    # Enable Nvidia GPU use within Podman containers
    podman.enableNvidia = true;
    # Don't enable waydroid on nova-desktop, it uses X11 at the moment
    waydroid.enable = lib.mkForce false;
  };
}
