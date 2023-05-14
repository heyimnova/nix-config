{ config, lib, pkgs, inputs, ... }:

{
  users.users.nova = {
    isNormalUser = true;
    description = "Nova";
    extraGroups = [ "libvirtd" "networkmanager" "openrazer" "wheel" ];
    shell = pkgs.fish;
  };

  time.timeZone = "Europe/London";

  console.font = "Lat2-Terminus16";

  security.rtkit.enable = true;

	fonts.fonts = with pkgs; [
    liberation_ttf
		(nerdfonts.override {
      fonts = [
        "Monofur"
      ];
    })
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
	];

  environment = {
    variables = {
      TERMINAL = "blackbox";
      EDITOR = "hx";
      VISUAL = "hx";
    };
    systemPackages = with pkgs; [
      adw-gtk3
      blackbox-terminal
      clapper
      colloid-icon-theme
      curl
      gnome.gnome-tweaks
      helix
      mullvad-browser
      mullvad-vpn
      unzip
      nur.repos.ambroisie.vimix-cursors
      wget
    ];
    shells = [ pkgs.fish ];

	  gnome.excludePackages = (with pkgs; [
		  baobab
		  gnome-connections
		  gnome-console
		  gnome-photos
		  gnome-tour
		  orca
	  ]) ++ (with pkgs.gnome; [
		  atomix
		  cheese
		  epiphany
		  geary
		  gedit
		  gnome-clocks
		  gnome-contacts
		  gnome-music
      gnome-software
		  gnome-terminal
		  hitori
		  tali
		  totem
		  yelp
		  yelp-xsl
	  ]);
  };

  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.canon-cups-ufr2 ];
    };
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
    cron.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    mullvad-vpn.enable = true;
    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  documentation.nixos.enable = false;

  networking.networkmanager.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "flakes" "nix-command" ];
    };
  };

  system.stateVersion = "22.11";

  hardware.pulseaudio.enable = false;

  programs = {
    dconf.enable = true;
    fish.enable = true;
    gnupg.agent.enable = true;
  };
}
