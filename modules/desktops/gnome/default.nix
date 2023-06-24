{ pkgs, ... }:

{
    imports = [
        ../.
    ];

    programs.dconf.enable = true;

    environment = {
        variables.TERMINAL = "${pkgs.blackbox-terminal}/bin/blackbox";

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

        systemPackages = with pkgs; [
            adw-gtk3
            blackbox-terminal
            clapper
            colloid-icon-theme
            gnome.gnome-tweaks
            gnomeExtensions.gsconnect
            nur.repos.ambroisie.vimix-cursors
        ];
    };

    services = {
        udev.packages = [ pkgs.gnome.gnome-settings-daemon ];

        xserver = {
            displayManager.gdm.enable = true;
            desktopManager.gnome.enable = true;
        };
    };
}
