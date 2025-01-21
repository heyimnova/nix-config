# Default NixOS desktop config
{ lib
, config
, pkgs
, variables
, ...
}:

{
  imports = [
    ./gnome.nix
    ./kde.nix
  ];

  # Only run if a desktop is set
  config = lib.mkIf (variables.desktop != "") {
    networking.networkmanager.enable = true;
    # Make pipewire realtime-capable
    security.rtkit.enable = true;
    system.fsPackages = [ pkgs.bindfs ];

    environment = {
      variables.TERMINAL = lib.getExe pkgs.ghostty;
      systemPackages = [ pkgs.podman-compose ];
    };

    # Fixes missing themes and icons in Flatpaks
    fileSystems = let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [ "resolve-symlinks" "ro" "x-gvfs-hide" ];
      };
      aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.packages;
        pathsToLink = [ "/share/fonts" ];
      };
    in {
      "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
      "/usr/share/icons" = mkRoSymBind "/run/current-system/sw/share/icons";
    };

    fonts.packages = with pkgs; [
      liberation_ttf
      (nerdfonts.override { fonts = [ "Monofur" ]; })
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
    ];

    hardware = {
      # Disable pulseaudio we are using pipewire
      pulseaudio.enable = false;

      # Enable hardware acceleration
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services = {
      printing.enable = true;

      mullvad-vpn = {
        enable = true;
        package = pkgs.mullvad-vpn;
      };

      pipewire = {
        enable = true;
        jack.enable = true;
        pulse.enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };
      };

      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };
    };

    virtualisation = {
      waydroid.enable = lib.mkDefault true;

      podman = {
        enable = true;
        # Allows containers started with podman-compose to talk to each other
        defaultNetwork.settings.dns_enabled = true;
        # Creates "docker" alias for Podman
        dockerCompat = true;
      };
    };
  };
}
