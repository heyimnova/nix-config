# Default NixOS desktop config
{ lib, config, pkgs, ... }:

let
  cfg = config.desktops;
in
{
  imports = [
    ./gnome.nix
    ./kde.nix
  ];

  options.desktops = {
    gnome.enable = lib.mkEnableOption "GNOME desktop and config";
    kde.enable = lib.mkEnableOption "KDE desktop and config";
  };

  config = lib.mkIf (cfg.gnome.enable || cfg.kde.enable) {
    environment.systemPackages = [ pkgs.podman-compose ];
    hardware.pulseaudio.enable = false;
    networking.networkmanager.enable = true;
    # Make pipewire realtime-capable
    security.rtkit.enable = true;
    system.fsPackages = [ pkgs.bindfs ];

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
      noto-fonts-cjk
      noto-fonts-emoji
    ];

    services = {
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

      printing = {
        enable = true;
        drivers = [ pkgs.canon-cups-ufr2 ];
      };

      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };
    };

    virtualisation = {
      waydroid.enable = lib.mkDefault true;

      podman = {
        # Allows containers started with podman-compose to talk to each other
        defaultNetwork.settings.dns_enabled = true;
        # Creates "docker" alias for Podman
        dockerCompat = true;
        enable = true;
      };
    };
  };
}
