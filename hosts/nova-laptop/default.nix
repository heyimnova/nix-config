{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/apps/desktop
    ../../modules/desktops/gnome
  ];

  environment.systemPackages = [ pkgs.mullvad-vpn ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      systemd-boot.enable = true;
    };
    initrd = {
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
      luks.devices."luks-ade306e0-fc8c-4019-952b-1551dcc0a4c4" = {
        device = "/dev/disk/by-uuid/ade306e0-fc8c-4019-952b-1551dcc0a4c4";
        keyFile = "/crypto_keyfile.bin";
      };
      systemd.enable = true;
    };
    kernelParams = [
      "quiet"
      "splash"
    ];
    plymouth = {
      enable = true;
      theme = "bgrt";
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

  system = {
    fsPackages = [ pkgs.bindfs ];
    stateVersion = "23.05";
  };

  i18n.defaultLocale = "en_GB.UTF-8";

  networking.hostName = "nova-laptop";

  services = {
    mullvad-vpn.enable = true;

    xserver = {
      layout = "gb";
      xkbVariant = "";
    };
  };

  console.keyMap = "uk";
}
