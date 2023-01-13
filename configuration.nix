{ config, pkgs, lib, modulesPath, inputs, ... }:

{
	# Nix config
	imports = [
		./hardware-configuration.nix
	];
	documentation.nixos.enable = false;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.autoUpgrade.enable = true;
	nix.settings.auto-optimise-store = true;
	nix.gc = {
		automatic = true;
		dates = "daily";
		options = "--delete-older-than 7d";
	};
	system.stateVersion = "22.11";
	# system.copySystemConfiguration = true;

	# Hardware config
	swapDevices = [ { device = "/var/swap/swapfile"; }];
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
	hardware.opengl.driSupport = true;

	# Bootloader config
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelParams = [
		"splash"
		"boot.shell_on_fail"
		"loglevel=3"
		"rd.udev.log_level=3"
		"udev.log_priority=3"
		"nvidia.drm.modeset=1"
	];

	# Filesystem config
	system.fsPackages = [ pkgs.bindfs ];
	boot.supportedFilesystems = [ "ntfs" ];

	fileSystems = let
		mkRoSymBind = path: {
			device = path;
			fsType = "fuse.bindfs";
			options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
		};
		aggregatedFonts = pkgs.buildEnv {
			name = "system-fonts";
			paths = config.fonts.fonts;
			pathsToLink = [ "/share/fonts" ];
		};
	in {
		"/".options = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
		"/home".options = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
		"/nix".options = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
		"/var".options = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
		"/var/log".options = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
		"/var/lib/flatpak".options = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
		"/var/lib/libvirt".options = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];
		"/var/lib/quickemu".options = [ "compress=zstd" "noatime" "space_cache=v2" "discard=async" ];

		"/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
		"/usr/share/icons" = mkRoSymBind "/run/current-system/sw/share/icons";
	};

	# Kernel config
	boot.kernelPackages = pkgs.linuxPackages_zen;
	boot.initrd.kernelModules = [
		"nvidia"
		"nvidia_modeset"
		"nvidia_uvm"
		"nvidia_drm"
		"v4l2loopback"
	];
	boot.extraModulePackages = with config.boot.kernelPackages; [
		v4l2loopback.out
	];

	# Network config
	networking.hostName = "nova-desktop";
	networking.networkmanager.enable = true;

	# i18n config
	time.timeZone = "Europe/London";
	i18n.defaultLocale = "en_US.UTF-8";
	environment.shells = with pkgs; [ fish ];

	# Xorg config
	services.xserver.enable = true;
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.opengl.enable = true;
	services.xserver.excludePackages = with pkgs; [ xterm ];

	# Gnome config
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
	environment.gnome.excludePackages = (with pkgs; [
		gnome-photos
		gnome-tour
		baobab
		gnome-console
		gnome-connections
	]) ++ (with pkgs.gnome; [
		cheese
		gnome-music
		gnome-terminal
		gedit
		epiphany
		geary
		totem
		tali
		hitori
		atomix
		yelp
		yelp-xsl
		gnome-contacts
		gnome-calculator
		gnome-clocks
	]);

	# Qt config
	qt = {
		enable = true;
		platformTheme = "gnome";
		style = "adwaita";
	};

	# Font config
	fonts.fonts = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		nerdfonts
	];

	# Pipewire config
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	# Users config
	users.users.nova = {
		isNormalUser = true;
		description = "Nova";
		extraGroups = [ "wheel" "libvirtd" "openrazer" ];
		packages = with pkgs; [
			gnomeExtensions.gsconnect
			gnomeExtensions.alphabetical-app-grid
			gnomeExtensions.blur-my-shell
			gnomeExtensions.caffeine
			gnomeExtensions.appindicator
			gnomeExtensions.clipboard-indicator
			gnomeExtensions.status-area-horizontal-spacing
			bat
			ripgrep
			exa
			starship
			neofetch
			polychromatic
			birdtray
			vscodium
			nixos-option
			texworks
			spicetify-cli
			git-crypt
			bitwarden
			fragments
			gimp
			mousai
			warp
			fluent-reader
			signal-desktop
			session-desktop
			element-desktop
			freetube
		];
		shell = pkgs.fish;
	};
	
	# System packages
	environment.systemPackages = with pkgs; [
		adw-gtk3
		colloid-icon-theme
		nur.repos.ambroisie.vimix-cursors
		helix
		wget
		curl
		git
		blackbox-terminal
		gnome.gnome-tweaks
		clapper
		mullvad-vpn
		gamemode
		virt-manager
		cargo
		rustc
		qt5ct
		quickemu
		droidcam
		flutter
	];

	# Enable services
	services.printing.enable = true;
	services.printing.drivers = [ pkgs.hplip ];
	services.flatpak.enable = true;
	services.mullvad-vpn.enable = true;
	programs.fish.enable = true;
	hardware.openrazer.enable = true;
	virtualisation.libvirtd.enable = true;
	programs.dconf.enable = true;
	programs.gnupg.agent.enable = true;
}

