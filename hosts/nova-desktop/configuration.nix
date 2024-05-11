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
  sops.secrets."passwords/nova-desktop".neededForUsers = true;
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
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      enable = true;
    };

    openrazer = {
      enable = true;
      users = [ flake-settings.user ];
    };

    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  networking = {
    hostName = "nova-desktop";
    # Needed for AI applications
    firewall.allowedTCPPorts = [
      11434
      11435
    ];
  };

  services = {
    # Set default gnome session to x11
    displayManager.defaultSession = lib.mkIf config.desktops.gnome.enable "gnome-xorg";

    ollama = {
      acceleration = "cuda";
      enable = true;
      listenAddress = "0.0.0.0:11434";
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

  virtualisation = {
    enable = true;
    # Enable Nvidia GPU use within Podman containers
    containers.cdi.dynamic.nvidia.enable = true;
    # Don't enable waydroid on nova-desktop, it uses X11 at the moment
    waydroid.enable = lib.mkForce false;
  };
}
