{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  swapDevices = [{ device = "/var/swap/swapfile"; }];

  boot = {
    loader.efi.efiSysMountPoint = "/boot/efi";
    initrd = {
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
      luks.devices."luks-ade306e0-fc8c-4019-952b-1551dcc0a4c4" = {
        device = "/dev/disk/by-uuid/ade306e0-fc8c-4019-952b-1551dcc0a4c4";
        keyFile = "/crypto_keyfile.bin";
      };
    };
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
		"/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
		"/usr/share/icons" = mkRoSymBind "/run/current-system/sw/share/icons";
	};

  system.fsPackages = [ pkgs.bindfs ];

  i18n = {
    defaultLocale = "en_GB.UTF-8";
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

  networking.hostName = "nova-laptop";

  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  console.keyMap = "uk";
}

