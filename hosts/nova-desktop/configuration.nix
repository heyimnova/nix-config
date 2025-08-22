# NixOS config for nova-desktop
{
  config,
  pkgs,
  variables,
  ...
}: {
  imports = [
    ./hardware.nix
    ../configuration.nix
  ];

  networking.hostName = "nova-desktop";
  # Localization
  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  # Make sure password file is loaded at boot
  sops.secrets."passwords/nova-desktop".neededForUsers = true;
  system.stateVersion = "22.11";

  boot = {
    # Use xanmod kernel
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    supportedFilesystems = ["ntfs"];

    kernelParams = [
      # Use Nvidia framebuffer
      "nvidia-drm.fbdev=1"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "splash"
    ];

    # Enable secureboot
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  # Enable full Nvidia driver configuration
  drivers.nvidia = {
    enable = true;
    extras = true;
  };

  # Razer RGB config
  hardware.openrazer = {
    enable = true;
    users = [variables.user];
  };

  environment = {
    systemPackages = [pkgs.droidcam];
    gnome.excludePackages = [pkgs.snapshot];
  };

  services = {
    ollama = {
      enable = true;
      # Make ollama accessible over the network
      host = "0.0.0.0";
      openFirewall = true;
    };

    # More localization
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  modules = {
    gaming.enable = true;
    virtualisation.enable = true;

    syncthing = {
      enable = true;

      folders = {
        logseq = true;
        work = true;
      };

      devices = {
        coral = true;
        the-thinker = true;
      };
    };
  };

  # Create the user with the predefined password
  users.users.${variables.user} = {
    hashedPasswordFile = config.sops.secrets."passwords/nova-desktop".path;

    extraGroups = [
      "libvirtd"
      "networkmanager"
      "wheel"
    ];
  };
}
