{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/gnome
    ../../modules/apps/gaming
  ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    openrazer.enable = true;
  };

  swapDevices = [{ device = "/var/swap/swapfile"; }];

  boot = {
    bootspec.enable = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    kernelParams = [
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "nvidia.drm.modeset=1"
    ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
    initrd.kernelModules = [
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
      "nvidia_uvm"
      "v4l2loopback"
    ];
    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [ "ntfs" ];
  };

	fileSystems = let
		mkRoSymBind = path: {
			device = path;
			fsType = "fuse.bindfs";
			options = [ "resolve-symlinks" "ro" "x-gvfs-hide" ];
		};
		aggregatedFonts = pkgs.buildEnv {
			name = "system-fonts";
			paths = config.fonts.fonts;
			pathsToLink = [ "/share/fonts" ];
		};
	in {
		"/".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/nix".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/home".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/var/log".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/var/lib/libvirt".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/var/lib/quickemu".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];

		"/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
		"/usr/share/icons" = mkRoSymBind "/run/current-system/sw/share/icons";
	};

	system = {
    fsPackages = [ pkgs.bindfs ];
    stateVersion = "22.11";
  };

  networking.hostName = "nova-desktop";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  services = {
    mullvad-vpn.enable = true;

    xserver = {
      videoDrivers = [ "nvidia" ];
      layout = "us";
      xkbVariant = "";
    };
  };

  console.keyMap = "us";

  virtualisation.libvirtd.enable = false;

  environment.systemPackages = with pkgs; [
    droidcam
    gamemode
    mullvad-vpn
    virt-manager
  ];
}
