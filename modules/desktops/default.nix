{ pkgs, ... }:

{
    hardware.pulseaudio.enable = false;
    networking.networkmanager.enable = true;
    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [
        mullvad-browser
        podman-compose
    ];

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

    services = {
        pipewire = {
            enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };
            pulse.enable = true;
            jack.enable = true;
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
        defaultNetwork.settings.dns_enabled = true;
        dockerCompat = true;
        enable = true;
    };
}
