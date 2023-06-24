{ pkgs, ... }:

{
  users.users.nova = {
    isNormalUser = true;
    description = "Nova";
    extraGroups = [ "libvirtd" "networkmanager" "openrazer" "wheel" ];
    shell = pkgs.fish;
  };

  time.timeZone = "Europe/London";

  console.font = "Lat2-Terminus16";

  environment = {
    variables = {
      EDITOR = "${pkgs.helix}/bin/hx";
      VISUAL = "${pkgs.helix}/bin/hx";
    };
    systemPackages = with pkgs; [
      curl
      helix
      unzip
      wget
    ];
    shells = [ pkgs.fish ];
  };

  services = {
    cron.enable = true;

    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
  };

  documentation.nixos.enable = false;

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

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}
