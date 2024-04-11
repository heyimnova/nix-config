# KDE NixOS config
{ lib, config, pkgs, ... }:

lib.mkIf config.desktops.kde.enable {
  # To remove hibernate from the power menu
  boot.kernelParams = [ "nohibernate" ];
  programs.kdeconnect.enable = true;
  # Unlock gnome-keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;

  environment = {
    variables.TERMINAL = "${pkgs.alacritty}/bin/alacritty";
    sessionVariables.NIXOS_OZONE_WL = "1";

    plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      konsole
      khelpcenter
    ];

    systemPackages = with pkgs; [
      alacritty
      # Needed for KDE Info Center
      clinfo
      glxinfo
      vulkan-tools
      # Themeing
      gruvbox-plus-icons
    ];
  };

  services = {
    desktopManager.plasma6.enable = true;
    # Manually disable KWallet for GNOME keyring to work as secret service
    gnome.gnome-keyring.enable = true;

    greetd = {
      enable = true;
      vt = 2;

      settings.default_session = {
        user = "greeter";

        command = ''
          #!${pkgs.bash}/bin/bash -e

          # Set gruvbox colorscheme
          echo -en "\e]P0282828" #black
          echo -en "\e]P8928374" #darkgrey
          echo -en "\e]P1cc241d" #darkred
          echo -en "\e]P9fb4934" #red
          echo -en "\e]P298971a" #darkgreen
          echo -en "\e]PAb8bb26" #green
          echo -en "\e]P3d79921" #brown
          echo -en "\e]PBfabd2f" #yellow
          echo -en "\e]P4458588" #darkblue
          echo -en "\e]PC83a598" #blue
          echo -en "\e]P5b16286" #darkmagenta
          echo -en "\e]PDd3869b" #magenta
          echo -en "\e]P6689d6a" #darkcyan
          echo -en "\e]PE8ec07c" #cyan
          echo -en "\e]P7a89984" #lightgrey
          echo -en "\e]PFebdbb2" #white
          clear #for background artifacting

          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --asterisks \
            --cmd dbus-run-session\ startplasma-wayland \
            --remember \
            --time \
            --user-menu \
            --user-menu-min-uid 1000 \
            --user-menu-max-uid 1010 \
            --window-padding 1
        '';
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };
}
