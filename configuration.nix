{ config, pkgs, lib, modulesPath, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];
	
	# Nix config
	documentation.nixos.enable = false;
	nix.gc = {
		automatic = true;
		dates = "daily";
		options = "--delete-older-than 3d";
	};
	nix.settings.auto-optimise-store = true;
	nix.settings.experimental-features = [ "flakes" "nix-command" ];
	system.stateVersion = "22.11";
	
	# Hardware config
	hardware.opengl.enable = true;
	hardware.opengl.driSupport = true;
	hardware.opengl.driSupport32Bit = true;
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
	swapDevices = [{ device = "/var/swap/swapfile"; }];
	
	# Bootloader config
	boot.kernelParams = [
		"splash"
		"boot.shell_on_fail"
		"loglevel=3"
		"rd.udev.log_level=3"
		"udev.log_priority=3"
		"nvidia.drm.modeset=1"
	];
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.enable = true;
	
	# Filesystem config
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
	
	# Kernel config
	boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
	boot.initrd.kernelModules = [
		"nvidia"
		"nvidia_drm"
		"nvidia_modeset"
		"nvidia_uvm"
		"v4l2loopback"
	];
	boot.kernelPackages = pkgs.linuxPackages_zen;
	
	# Network config
	networking.hostName = "nova-desktop";
	networking.networkmanager.enable = true;
	
	# i18n config
	environment.shells = [ pkgs.fish ];
	i18n.defaultLocale = "en_US.UTF-8";
	time.timeZone = "Europe/London";
	
	# Xorg config
	services.xserver.enable = true;
	services.xserver.excludePackages = [ pkgs.xterm ];
	services.xserver.videoDrivers = [ "nvidia" ];
	
	# Gnome config
	environment.gnome.excludePackages = (with pkgs; [
		baobab
		gnome-connections
		gnome-console
		gnome-photos
		gnome-tour
	]) ++ (with pkgs.gnome; [
		atomix
		cheese
		epiphany
		geary
		gedit
		gnome-calculator
		gnome-clocks
		gnome-contacts
		gnome-music
		gnome-terminal
		hitori
		tali
		totem
		yelp
		yelp-xsl
	]);
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
	
	# Qt config
	qt = {
		enable = true;
		platformTheme = "gnome";
		style = "adwaita";
	};
	
	# Font config
	fonts.fonts = with pkgs; [
		nerdfonts
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
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
		description = "Nova";
		extraGroups = [ "libvirtd" "openrazer" "wheel" ];
		isNormalUser = true;
		packages = with pkgs; [
			bat
			birdtray
			bitwarden
			brave
			element-desktop
			exa
			fluent-reader
			fragments
			freetube
			gimp
			git-crypt
			gnomeExtensions.alphabetical-app-grid
			gnomeExtensions.appindicator
			gnomeExtensions.blur-my-shell
			gnomeExtensions.caffeine
			gnomeExtensions.clipboard-indicator
			gnomeExtensions.gsconnect
			gnomeExtensions.grand-theft-focus
			gnomeExtensions.status-area-horizontal-spacing
			(lutris.override {
				extraLibraries = pkgs: [
					libgpg-error
					jansson
				];
			})
			heroic
			mousai
			neofetch
			onlyoffice-bin
			polychromatic
			prismlauncher
			ripgrep
			session-desktop
			signal-desktop
			starship
			texworks
			thunderbird
			vscodium
			warp
		];
		shell = pkgs.fish;
	};
	
	# System packages
	environment.systemPackages = with pkgs; [
		adw-gtk3
		blackbox-terminal
		clapper
		colloid-icon-theme
		curl
		droidcam
		flutter
		gamemode
		git
		gnome.gnome-tweaks
		helix
		mullvad-vpn
		qt5ct
		quickemu
		unzip
		nur.repos.ambroisie.vimix-cursors
		virt-manager
		wget
	];
	
	# Enable services
	hardware.openrazer.enable = true;
	programs.dconf.enable = true;
	programs.fish.enable = true;
	programs.gnupg.agent.enable = true;
	services.flatpak.enable = true;
	services.mullvad-vpn.enable = true;
	services.printing.enable = true;
	services.printing.drivers = [ pkgs.hplip ];
	virtualisation.libvirtd.enable = true;
}

