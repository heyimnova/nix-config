{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    console.keyMap = "uk";
    i18n.defaultLocale = "en_GB.UTF-8";
    networking.hostName = "idea";
    system.stateVersion = "23.05";
    virtualisation.docker.enable = true;

    boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
    };
}
