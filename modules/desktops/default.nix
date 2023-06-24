{ pkgs, ... }:

{
    environment.systemPackages = [ pkgs.mullvad-browser ];
    hardware.pulseaudio.enable = false;
    networking.networkmanager.enable = true;
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
}
