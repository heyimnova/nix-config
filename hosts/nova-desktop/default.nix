{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    openrazer.enable = true;
  };

  swapDevices = [{ device = "/var/swap/swapfile"; }];

  boot = {
    kernelParams = [
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "nvidia.drm.modeset=1"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
    initrd.kernelModules = [
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
      "nvidia_uvm"
      "v4l2loopback"
    ];
    kernelPackages = pkgs.linuxPackages_zen;
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
		"/home".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/nix".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/var".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/var/lib/flatpak".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/var/lib/libvirt".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/var/lib/quickemu".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];
		"/var/log".options = [ "compress=zstd" "discard=async" "noatime" "space_cache=v2" ];

		"/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
		"/usr/share/icons" = mkRoSymBind "/run/current-system/sw/share/icons";
	};

	system.fsPackages = [ pkgs.bindfs ];

  networking = {
    hostName = "nova-desktop";
    networkmanager.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    droidcam
    flutter
    gamemode
    quickemu
    virt-manager
  ];
}

