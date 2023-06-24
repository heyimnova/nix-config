{ pkgs, ... }:

{
  console.font = "Lat2-Terminus16";
  documentation.nixos.enable = false;
  time.timeZone = "Europe/London";

  environment = {
    shells = [ pkgs.fish ];

    variables = {
      EDITOR = "${pkgs.helix}/bin/hx";
      VISUAL = "${pkgs.helix}/bin/hx";
    };

    systemPackages = with pkgs; [
      bat
      curl
      exa
      helix
      unzip
      wget
    ];
  };

  i18n.extraLocaleSettings = {
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

  programs = {
    fish.enable = true;
    gnupg.agent.enable = true;
  };

  services = {
    cron.enable = true;

    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        addresses = true;
        enable = true;
        userServices = true;
      };
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  users.users.nova = {
    description = "Nova";
    extraGroups = [ "libvirtd" "networkmanager" "openrazer" "wheel" ];
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
