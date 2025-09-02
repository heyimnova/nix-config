# Stylix configuration
{
  lib,
  pkgs,
  variables,
  ...
}: let
  # I only want the proportional italics from Victor Mono
  victor-mono-italics = pkgs.nerd-fonts.victor-mono.overrideAttrs (finalAttrs: previousAttrs: {
    postFixup = ''
      find $out/share/fonts -type f -not -name "*Propo*Italic*" -delete
    '';
  });
in
  lib.mkMerge [
    (lib.mkIf (variables.desktop == "gnome") {
      stylix = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
        enable = true;
        image = ../config/wallpapers/anders-jilden.jpg;
        polarity = "dark";

        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 20;
        };

        fonts = {
          sizes = {
            applications = 11;
            terminal = 16;
            desktop = 14;
            popups = 12;
          };

          # GNOME document font
          serif = {
            package = pkgs.maple-mono.Normal-Variable;
            name = "Maple Mono";
          };

          # GNOME interface font
          sansSerif = {
            package = victor-mono-italics;
            name = "VictorMono Nerd Font Propo Semi-Bold Italic";
          };

          monospace = {
            package = pkgs.nerd-fonts.fantasque-sans-mono;
            name = "FantasqueSansM Nerd Font Mono";
          };
        };
      };
    })

    (lib.mkIf (variables.desktop == "kde") {
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
            package = pkgs.maple-mono.Normal-Variable;
            name = "Maple Mono";
          };

          sansSerif = {
            package = pkgs.nerd-fonts.caskaydia-cove;
            name = "Caskaydia Cove Nerd Font";
          };

          monospace = {
            package = pkgs.nerd-fonts.fantasque-sans-mono;
            name = "FantasqueSansM Nerd Font Mono";
          };
        };
      };
    })
  ]
