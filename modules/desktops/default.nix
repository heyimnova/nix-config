# System wide general desktop config
{ pkgs, ... }:

{
  hardware.pulseaudio.enable = false;
  networking.networkmanager.enable = true;
  # Needed for Pipewire
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    mullvad-browser
    podman-compose
  ];

  fonts.fonts = with pkgs; [
    liberation_ttf
    (nerdfonts.override { fonts = [ "Monofur" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  services = {
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

  virtualisation.podman = {
    # Allows containers started with podman-compose to talk to each other
    defaultNetwork.settings.dns_enabled = true;
    # Creates "docker" alias for Podman
    dockerCompat = true;
    enable = true;
  };
}
