# Stylix configuration
{ lib, pkgs, variables, ... }:

lib.mkMerge [
  (lib.mkIf (variables.desktop == "gnome") {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
      enable = true;
      image = ../config/wallpapers/anders-jilden.jpg;
      polarity = "dark";

      cursor = {
        package = pkgs.vimix-cursors;
        name = "Vimix-white-cursors";
        size = 16;
      };

      fonts = {
        sizes = {
          applications = 11;
          terminal = 16;
          desktop = 14;
          popups = 12;
        };

        serif = {
          package = pkgs.maple-mono-autohint;
          name = "Maple Mono";
        };

        sansSerif = {
          package = pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; };
          name = "Caskaydia Cove Nerd Font";
        };

        monospace = {
          package = pkgs.nerdfonts.override { fonts = [ "Monofur" ]; };
          name = "Monofur Nerd Font Mono";
        };
      };
    };
  })

  (lib.mkIf (variables.desktop == "kde2") {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-pale.yaml";
      enable = true;
      image = ../config/wallpapers/forest-mountain-cloudy-valley.png;
      polarity = "dark";

      cursor = {
        package = pkgs.simp1e-cursors;
        name = "Simp1e-Gruvbox-Dark";
        size = 16;
      };

      fonts = {
        sizes = {
          applications = 11;
          terminal = 15;
          desktop = 14;
          popups = 12;
        };

        serif = {
          package = pkgs.maple-mono-autohint;
          name = "Maple Mono";
        };

        sansSerif = {
          package = pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; };
          name = "Caskaydia Cove Nerd Font";
        };

        monospace = {
          package = pkgs.nerdfonts.override { fonts = [ "Monofur" ]; };
          name = "Monofur Nerd Font Mono";
        };
      };
    };
  })
]
