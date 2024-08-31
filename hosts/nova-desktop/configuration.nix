# NixOS config for nova-desktop
{ config, pkgs, flake-settings, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
  ];

  console.keyMap = "us";
  desktops.gnome.enable = true;
  gaming.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  sops.secrets."passwords/nova-desktop".neededForUsers = true;
  system.stateVersion = "22.11";
  virtualisation.enable = true;

  boot = {
    # Set virtual memory max map count to MAX_INT - 5, fixes some bugs with games under Proton
    kernel.sysctl."vm.max_map_count" = 2147483642;
    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [ "ntfs" ];

    kernelParams = [
      "boot.shell_on_fail"
      "loglevel=3"
      "nvidia-drm.fbdev=1"
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
    # Enable Nvidia GPU use within Podman containers
    nvidia-container-toolkit.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      open = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    openrazer = {
      enable = true;
      users = [ flake-settings.user ];
    };
  };

  networking = {
    hostName = "nova-desktop";
    # Needed for AI applications
    firewall.allowedTCPPorts = [
      11435
    ];
  };

  services = {
    ollama = {
      acceleration = "cuda";
      enable = true;
      host = "0.0.0.0";
      openFirewall = true;
    };

    xserver = {
      videoDrivers = [ "nvidia" ];

      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  syncthing = {
    devices.coral = true;
    enable = true;
    folders.logseq = true;
  };

  users.users.${flake-settings.user} = {
    hashedPasswordFile = config.sops.secrets."passwords/nova-desktop".path;

    extraGroups = [
      "libvirtd"
      "networkmanager"
      "wheel"
    ];
  };
}
